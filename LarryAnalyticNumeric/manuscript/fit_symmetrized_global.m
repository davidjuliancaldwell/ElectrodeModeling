%% script to fit symmetric data
%
% fitlm global
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
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
stimChansSym(1) = sub2ind([jLength,kLength],8,8);
stimChansSym(2) = sub2ind([jLength,kLength],8,9);

jp = stimChansIndicesSym(1);
kp = stimChansIndicesSym(2);
jm = stimChansIndicesSym(3);
km = stimChansIndicesSym(4);

% perform 1d optimization
offsetSym = 0;
% extract measured data and calculate theoretical ones

[l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChansSym,offsetSym,jLength,kLength);

intercept = true;

% use MSE
if ~isempty(dataInt)
    if ~intercept
        dlm=fitlm(l1,dataInt,'intercept',false);
        rhoACalcSym =dlm.Coefficients{1,1};
        offsetSym = 0;
    else
        dlm=fitlm(l1,dataInt);
        
        rhoACalcSym=dlm.Coefficients{2,1};
        offsetSym = dlm.Coefficients{1,1};
    end
    MSESym = dlm.RMSE;
    fitValsSymVec = dlm.Fitted;
    
else
    
    rhoACalcSym = nan;
    MSESym = nan;
    offsetSym = nan;
end


fprintf(['complete for symmetric  rhoA ='  num2str(rhoACalcSym) ' offsetSym = ' num2str(offsetSym) ' \n ']);
%%




