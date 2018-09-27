%% script to fit individual data
%
% David.J.Caldwell

%% fitlm by bins
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer

cost_vec_1layer = [];
gridSize = [8,8];
rhoA = 1;
cost_vec_1layer = [];
rhoAcalc = 1;
subject_min_rhoA_vec = [];
subject_residuals = [];

jLength = 8;
kLength = 8;
%%
for i = 1:numSubjs
    
    dataInt = dataSelect(:,i);
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    stimChans = [(stimChansVec{i})];
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    
    % perform 1d optimization
    offset = 0;
    % extract measured data and calculate theoretical ones
    
    [l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,jLength,kLength);
    
    intercept = true;
    
    % use MSE
    if ~isempty(dataInt)
        if ~intercept
            dlm=fitlm(l1,dataInt,'intercept',false);
            rhoACalc(i)=dlm.Coefficients{1,1};
            offset(i) = 0;
        else
            dlm=fitlm(l1,dataInt);
            
            rhoACalc(i)=dlm.Coefficients{2,1};
            offset(i) = dlm.Coefficients{1,1};
        end
        MSE(i) = dlm.RMSE;
        bestVals(:,i) = dlm.Fitted;
        
    else
        
        rhoACalc(i) = nan;
        MSE(i) = nan;
        offset(i) = nan;
    end
    
    
    fprintf(['complete for subject ' num2str(i) ' rhoA = ' num2str(rhoACalc(i)) ' offset = ' num2str(offset(i)) ' \n ']);
    
    
end



