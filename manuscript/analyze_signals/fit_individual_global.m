function fitStruct = fit_individual_global(subStruct)

% function to fit individual subject data with global rhoA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer


rhoA = 1;
jLength = 8;
kLength = 8;
dataSelect = subStruct.dataSelect;
numIndices = size(subStruct.meanMat,3);

%%
for index = 1:numIndices
    
    dataInt = dataSelect(:,index);
    % select particular values for constants
    
    stimChans = subStruct.stimChans(index,:);
    i0 = subStruct.currentMat(index);
    meanMat = subStruct.meanMat(:,:,index);
    locs = subStruct.locs{index};
    stimChansIndices = subStruct.stimChansIndices;
    sid = subStruct.sid{index};
    stimChansTotal = subStruct.stimChansVecTotal{index};
    jp = stimChansIndices(1,index);
    kp = stimChansIndices(2,index);
    jm = stimChansIndices(3,index);
    km = stimChansIndices(4,index);
    
    % perform 1d optimization
    offset = 0;
    % extract measured data and calculate theoretical ones
    
    [l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChansTotal,offset,jLength,kLength);
    
    intercept = true;
    
    % use MSE
    if ~isempty(dataInt)
        if ~intercept
            dlm=fitlm(l1,dataInt,'intercept',false);
            tempStruct.rhoACalc(index)=dlm.Coefficients{1,1};
            tempStruct.offset(index) = 0;
        else
            dlm=fitlm(l1,dataInt);
            tempStruct.rhoACalc(index)=dlm.Coefficients{2,1};
            tempStruct.offset(index) = dlm.Coefficients{1,1};
        end
        tempStruct.MSE(index) = dlm.RMSE;
        tempStruct.bestVals(:,index) = dlm.Fitted;
        
    else
        tempStruct.rhoACalc(index) = nan;
        tempStruct.MSE(index) = nan;
        tempStruct.offset(index) = nan;
    end
    
    fitStruct.calc{index} = tempStruct;
    fprintf(['complete for subject ' num2str(index) ' rhoA = ' num2str(tempStruct.rhoACalc(index)) ' offset = ' num2str(tempStruct.offset(index)) ' \n ']);
    
end


end


