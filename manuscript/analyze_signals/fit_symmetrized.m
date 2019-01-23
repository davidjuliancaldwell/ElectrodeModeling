function fitStruct = fit_symmetrized(subStruct,plotIt,saveIt);
%% function for fitlm by bins - symmetrized data
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


stimChansSym = subStruct.stimChansIndicesShrunk;
stimChansSymLinear = subStruct.stimChansShrunk;

conditionsInt = {'Avg','LRavg','UDavg','LRUDavg'};
for conditionsIntSelect = conditionsInt
    conditionsIntSelect = conditionsIntSelect{:};
    dataInt = eval(['subStruct.gridData' conditionsIntSelect 'Shrunk']);
    % optimization for 1 layer
    jLength = size(dataInt,2);
    kLength = size(dataInt,1);
    dataInt = dataInt(:);
    
    bins = (repmat([1:8],2,1)+[0;1])';
    rhoAcalc = 1;
    
    gridSize = [kLength,jLength];
    %%
    
    % select particular values for constants
    i0 = 1;
    
    stimChansDistance = subStruct.stimChansShrunk;
    
    jp = stimChansSym(1);
    kp = stimChansSym(2);
    jm = stimChansSym(3);
    km = stimChansSym(4);
    % perform 1d optimization
    offsetSym = 0;
    
    [distances] = distance_electrodes_center(stimChansDistance,gridSize);
    
    % perform 1d optimization
    % extract measured data and calculate theoretical ones
    
    [l1] = computePotentials_1layer(jp,kp,jm,km,rhoAcalc,i0,stimChansSymLinear,offsetSym,jLength,kLength);
    
    [rhoAoutput,MSE,subjectResiduals,offset,bestVals] = distance_selection_MSE_bins_fitlm(dataInt,l1,bins,distances);
    
    fldnm = conditionsIntSelect;
    fitStruct.(fldnm).bestVals = bestVals;
    fitStruct.(fldnm).MSE = MSE;
    fitStruct.(fldnm).rhoAcalc = rhoAoutput;
    fitStruct.(fldnm).offset = offset;
    
    fprintf(['complete for symmetric  rhoA ='  num2str(fitStruct.(fldnm).rhoAcalc) ' offsetSym = ' num2str(fitStruct.(fldnm).offset) ' \n ']);
end
%% plot

if plotIt
    
    figure
    hold on
    xrange = [1.5:1:8.5];
    plot(xrange,fitStruct.Avg.rhoAcalc,'-o','linewidth',2)
    plot(xrange,fitStruct.LRavg.rhoAcalc,'-o','linewidth',2)
    plot(xrange,fitStruct.UDavg.rhoAcalc,'-o','linewidth',2)
    plot(xrange,fitStruct.LRUDavg.rhoAcalc,'-o','linewidth',2)
    legend({'Average','LR symmetry','UD symmetry','LRUD symmetry'});
    xlabel('bin center (cm)')
    ylabel('rhoA (ohm-m)')
    title('one layer apparent resistivity for global data by bin')
    set(gca,'fontsize',18)
    
    if saveIt
        
    end
    
end

end

