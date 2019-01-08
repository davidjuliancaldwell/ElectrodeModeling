function fitStruct = fit_symmetrized(subStruct,plotIt,saveIt);
%% function for fitlm by bins - symmetrized data
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
dataInt = subStruct.gridDataLRUDavg;
stimChansSym = subStruct.stimChansIndices;
dataInt = dataInt(:);

bins = (repmat([1:8],2,1)+[0;1])';
rhoAcalc = 1;

jLength = 15;
kLength = 15;
gridSize = [jLength,kLength];
%%

% select particular values for constants
i0 = 1;

stimChansDistance = subStruct.stimChans;

jp = stimChansSym(1);
kp = stimChansSym(2);
jm = stimChansSym(3);
km = stimChansSym(4);
% perform 1d optimization
offsetSym = 0;

[distances] = distance_electrodes_center(stimChansDistance,gridSize);

% perform 1d optimization
% extract measured data and calculate theoretical ones

[l1] = computePotentials_1layer(jp,kp,jm,km,rhoAcalc,i0,stimChansSym,offsetSym,jLength,kLength);

[rhoAoutput,MSE,subjectResiduals,offset,bestVals] = distance_selection_MSE_bins_fitlm(dataInt,l1,bins,distances);


fitStruct.bestVals = bestVals;
fitStruct.MSE = MSE;
fitStruct.rhoAcalc = rhoAoutput;
fitStruct.offset = offset;

fprintf(['complete for symmetric  rhoA ='  num2str(fitStruct.rhoAcalc) ' offsetSym = ' num2str(fitStruct.offset) ' \n ']);



%% plot

if plotIt
    
    figure
    plot(fitStruct.rhoAcalc,'-o','linewidth',2)
    legend({'1','2','3','4','5','6','7','8'})
    xlabel('bin')
    ylabel('rhoA (ohm-m)')
    title('one layer apparent resistivity for global data by bin')
    set(gca,'fontsize',18)
    
    if saveIt
        
    end
    
end


