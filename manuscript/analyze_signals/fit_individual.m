function fitStruct = fit_individual(subStruct,plotIt,saveIt)
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer

gridSize = [8,8];
bins = (repmat([1:7],2,1)+[0;1])';
rhoA = 1;
dataSelect = subStruct.dataSelect;
numIndices = size(subStruct.meanMat,3);
jLength = 8;
kLength = 8;
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
    
    stimChansDistance = stimChans;
    
    % [distancesPosNeg] = distance_electrodes_pos_neg(stimChans,gridSize);
    [distances] = distance_electrodes_center(stimChansDistance,gridSize);
    
    % perform 1d optimization
    % extract measured data and calculate theoretical ones
    
    [l1] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChans,0,jLength,kLength);
    % c91479 was flipped l1 l3
    
    [rhoAoutput,MSE,subjectResiduals,offset,bestVals] = distance_selection_MSE_bins_fitlm(dataInt,l1,bins,distances,stimChans);
    
    tempStruct.bestVals = bestVals;
    tempStruct.MSE = MSE;
    tempStruct.rhoAcalc = rhoAoutput;
    tempStruct.offset = offset;
    
    fitStruct.calc{index} = tempStruct;
    
    fprintf(['complete for subject ' num2str(index) ' rhoA = ' num2str(rhoAoutput) ' offset = ' num2str(offset) ' \n ']);
    
    
end

%% plot

if plotIt
    
    figure
    hold on
    for index = 1:numIndices
        plot(fitStruct.calc{index}.rhoAcalc(1:5),'-o','linewidth',2)
    end
    legend({'1','2','3','4','5','6','7'})
    xlabel('bin')
    ylabel('rhoA (ohm-m)')
    title('one layer apparent resistivity by subject and bin')
    set(gca,'fontsize',18)
    
    if saveIt
    end
    
end

%%

if plotIt
    
    figure
    
    for index = 1:numIndices
        
        subplot(2,4,index)
        plot(fitStruct.calc{index}.rhoAcalc(1:5),'-o','linewidth',2)
        
        title(['subject ' num2str(index)])
        set(gca,'fontsize',18)
        ylim([0 5])
        xlim([0 6])
        yticks([0 1 2 3 4 5 6])
        xticks([0 1 2 3 4 5 6])
        
    end
    xlabel('bin')
    ylabel('rhoA (ohm-m)')
    sgtitle('one layer apparent resistivity by subject and bin','fontsize',18)
    
    if saveIt
        
    end
    
end

end