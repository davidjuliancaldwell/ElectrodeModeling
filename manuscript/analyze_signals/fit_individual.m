%% script to fit individual data
%
% David.J.Caldwell

%% fitlm by bins
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer

gridSize = [8,8];
bins = (repmat([1:7],2,1)+[0;1])';
rhoAcalc = 1;
offset = 0;

costVec1layer = [];
subject_residuals = [];
rhoAOutput = [];
jLength = 8;
kLength = 8;
%%
for index = 1:numIndices
    
    % select particular values for constants
    dataInt = dataSelect(:,index);
    i0 = currentMat(index);
    sid = sidAll{:};
    stimChans = [(stimChansVecTotal{index})];
    stimChansDistance = stimChans(1:2);
    jp = jp_vec(index);
    kp = kp_vec(index);
    jm = jm_vec(index);
    km = km_vec(index);
    
    % [distancesPosNeg] = distance_electrodes_pos_neg(stimChans,gridSize);
    [distances] = distance_electrodes_center(stimChansDistance,gridSize);
    
    % perform 1d optimization
    % extract measured data and calculate theoretical ones
    
    [l1] = computePotentials_1layer(jp,kp,jm,km,rhoAcalc,i0,stimChans,offset,jLength,kLength);
    % c91479 was flipped l1 l3
    
    [rhoAoutput,MSE,subjectResiduals,offsetOutput,fitVals] = distance_selection_MSE_bins_fitlm(dataInt,l1,bins,distances,stimChans);
    
    fit.fitVals = fitVals;
    fit.MSE = MSE;
    fit.rhoAoutput = rhoAoutput;
    fit.offsetVec = offsetVec;
    
    fitStruct.fitIndGrid{index} = fit;
    fprintf(['complete for subject ' num2str(index) ' rhoA = ' num2str(rhoAoutput) ' offset = ' num2str(offsetOutput) ' \n ']);
    
    
end

%% plot

if plotIt
    
    figure
    plot(rhoAVec','-o','linewidth',2)
    legend({'1','2','3','4','5','6','7','8'})
    xlabel('bin')
    ylabel('rhoA (ohm-m)')
    title('one layer apparent resistivity by subject and bin')
    set(gca,'fontsize',18)
    
end

%%

if plotIt
    
    figure
    
    for index = 1:numIndices
        
        subplot(2,4,index)
        plot(rhoAVec(index,:),'-o','linewidth',2)
        
        title(['subject ' num2str(index)])
        set(gca,'fontsize',18)
        ylim([0 5])
    end
    xlabel('bin')
    ylabel('rhoA (ohm-m)')
    
end

%% if plotit
if plotIt
    
    figure
    
    for index = 1:numIndices
        
        subplot(2,4,index)
        plot(dataSelect(:,index),'linewidth',2)
        hold on
        plot(fitValsVec(:,index),'linewidth',2)
        plot(bestVals(:,index),'linewidth',2)
        title(['subject ' num2str(index)])
        set(gca,'fontsize',18)
    end
    ylabel('voltage (V)')
    legend({'data','binned best fits','global best fits'})
    
end

