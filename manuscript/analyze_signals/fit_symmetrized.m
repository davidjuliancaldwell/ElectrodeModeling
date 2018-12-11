
%% fitlm by bins - symmetrized data
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
dataInt = dataInt(:);

bins = (repmat([1:8],2,1)+[0;1])';
rhoAcalc = 1;
offset = 0;

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
stimChansDistance = stimChansSym(1:2);

jp = stimChansIndicesSym(1);
kp = stimChansIndicesSym(2);
jm = stimChansIndicesSym(3);
km = stimChansIndicesSym(4);

% perform 1d optimization
offsetSym = 0;

% [distancesPosNeg] = distance_electrodes_pos_neg(stimChans,gridSize);
[distances] = distance_electrodes_center(stimChansDistance,gridSize);

% perform 1d optimization
% extract measured data and calculate theoretical ones

[l1] = computePotentials_1layer(jp,kp,jm,km,rhoAcalc,i0,stimChansSym,offsetSym,jLength,kLength);
% c91479 was flipped l1 l3

[rhoAoutput,MSE,subjectResiduals,offsetOutput,fitVals] = distance_selection_MSE_bins_fitlm(dataInt,l1,bins,distances,stimChansSym);

fitValsSymVecBin = fitVals;

costVec1layerSymBin = MSE;
rhoAVecSymBin = rhoAoutput;
offsetVecSymBin = offsetOutput;
fprintf(['complete for symmetric  rhoA ='  num2str(rhoAVecSymBin) ' offsetSym = ' num2str(offsetVecSymBin) ' \n ']);



%% plot

if plotIt
    
    figure
    plot(rhoAVecSymBin,'-o','linewidth',2)
    legend({'1','2','3','4','5','6','7','8'})
    xlabel('bin')
    ylabel('rhoA (ohm-m)')
    title('one layer apparent resistivity for global data by bin')
    set(gca,'fontsize',18)
    
end

%% if plotit
if plotIt
    
    figure
    plot(dataInt,'linewidth',2)
    hold on
    plot(fitValsSymVecBin,'linewidth',2)    
    plot(fitValsSymVec,'linewidth',2)
    title(['Global fit'])
    set(gca,'fontsize',18)
    ylabel('V/I')
    legend({'data','binned best fits','global best fits'})
    
end


