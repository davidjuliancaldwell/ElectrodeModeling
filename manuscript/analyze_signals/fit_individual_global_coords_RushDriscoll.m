function fitStruct = fit_individual_global_coords_spherical(subStruct)

% function to fit individual subject data with global rhoA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer

rhoA = 1;
dataSelect = subStruct.dataSelect;
numIndices = size(subStruct.meanMat,3);

%%
for index = 1:numIndices
    
    dataInt = dataSelect(:,index);
    badTotal = subStruct.badTotal{index};
    dataInt(badTotal) = nan;
    
    % select particular values for constants
    
    stimChans = subStruct.stimChans(index,:);
    i0 = subStruct.currentMat(index);
    locs = subStruct.locs{index};
    % only use grid electrodes
    locs = locs(1:64,:);
    % extract measured data and calculate theoretical ones
    
    
    locs = locs/1000;
    
    [az,el,r]  = cart2sph(locs(:,1),locs(:,2),locs(:,3));
    %R = 7/100; % cm
    b = median(r);
    c = b + (1/1000);
    a = b - (3.5/1000);
    s1 = 3; % conductivity of top layer
    s2 = 2;
    s3 = 1;
    
    %[l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChansTotal,offset,jLength,kLength);
    [thy1,thy2,thy3] = compute_1layer_theory_coords_RushDriscoll(locs,stimChans,s1,s2,s3,a,b,c);
    
    scaleA=(i0)/(2*pi*c*s1);
    thy1 = scaleA*thy1;
    thy2 = scaleA*thy2;
    thy3 = scaleA*thy3;
    
    intercept = true;
    tempStruct = struct;
    
    % use MSE
    if ~isempty(dataInt)
        if ~intercept
            dlm=fitlm(thy1,dataInt,'intercept',false);
            tempStruct.rhoAcalc(index)=dlm.Coefficients{1,1};
            tempStruct.offset(index) = 0;
        else
            dlm=fitlm(thy1,dataInt);
            tempStruct.rhoAcalc(index)=dlm.Coefficients{2,1};
            tempStruct.offset(index) = dlm.Coefficients{1,1};
        end
        tempStruct.MSE = dlm.RMSE;
        tempStruct.bestVals = dlm.Fitted;
        
    else
        tempStruct.rhoAcalc = nan;
        tempStruct.MSE = nan;
        tempStruct.offset = nan;
    end
    
    fitStruct.calc{index} = tempStruct;
    fprintf(['complete for subject ' num2str(index) ' rhoA = ' num2str(tempStruct.rhoAcalc(index)) ' offset = ' num2str(tempStruct.offset(index)) ' \n ']);
    
end


end


