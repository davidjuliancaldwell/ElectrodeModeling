function fitStruct = fit_symmetrized_global(subStruct)
%% function to fit symmetric data
%fitlm by bins
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer

dataInt = subStruct.gridDataLRUDavg;
stimChansSym = subStruct.stimChansIndices;
dataInt = dataInt(:);

cost_vec_1layer = [];
rhoA = 1;
cost_vec_1layer = [];
rhoAcalc = 1;
subject_min_rhoA_vec = [];
subject_residuals = [];

jLength = 15;
kLength = 15;
gridSize = [jLength,kLength];

%%

% select particular values for constants
i0 = 1;

jp = stimChansSym(1);
kp = stimChansSym(2);
jm = stimChansSym(3);
km = stimChansSym(4);

% perform 1d optimization
offsetSym = 0;
% extract measured data and calculate theoretical ones

[l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChansSym,offsetSym,jLength,kLength);

intercept = true;

% use MSE
% use MSE
if ~isempty(dataInt)
    if ~intercept
        dlm=fitlm(l1,dataInt,'intercept',false);
        fitStruct.rhoAcalc=dlm.Coefficients{1,1};
        fitStruct.offset = 0;
    else
        dlm=fitlm(l1,dataInt);
        fitStruct.rhoAcalc=dlm.Coefficients{2,1};
        fitStruct.offset = dlm.Coefficients{1,1};
    end
    fitStruct.MSE = dlm.RMSE;
    fitStruct.bestVals = dlm.Fitted;
    
else
    fitStruct.rhoAcalc = nan;
    fitStruct.MSE = nan;
    fitStruct.offset = nan;
end

fprintf(['complete for symmetric  rhoA ='  num2str(fitStruct.rhoAcalc) ' offsetSym = ' num2str(fitStruct.offset) ' \n ']);


end


