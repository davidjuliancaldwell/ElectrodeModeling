%% factor of 4 is included in here NOW within voltage_extract_avg

% data for further analysis
meanMatAll = zeros(64,2,7,1);
stdMatAll = zeros(64,2,7,1);
numberStimsAll = zeros(7,1,1);
stdEveryPoint = {};
extractCellAll = {};
meanEveryTrialAll = {};
subjectNum = [];
figTotal =  figure('units','inches','outerposition',[1 1 8.5 11]);

% stimulation currents in A
stimChansVec = [30 22;14 13;12 11;60 59;55 56;62 54;56 64];

currentMatVec = [0.00175 0.00075 0.0035 0.00075 0.003 0.0025 0.00175]';
numChansInt = 64;
counterIndex = 1;
numRows = 4;
numColumns = 2;
saveIt = 1;
plotIt = 1;
sameScale = 1;

for ii = 1:7
    sid = SIDS{ii};
    fprintf(['running for subject ' sid '\n']);
    fs = 12207;
    jj =1;
    stimChans = stimChansVec(ii,:);
    load(fullfile(folderData,[sid '_StimulationAndCCEPs.mat']))
    
    % rebaseine these to just be 25 to 5 ms before
    for chan = 1:size(ECoGData,3)
        ECoGData(:,:,chan) =  ECoGData(:,:,chan)-repmat(mean(ECoGData((t<0-0.005 & t>-0.025),:,chan),1), [size(ECoGData, 1),1]);
    end
    ECoGData = permute(ECoGData,[1 3 2]);
    
    
    %%
    [meanMat,stdMat,stdCellEveryPoint,meanEveryTrial,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',...
        fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    %%
    if plotIt
        figure
        ECoGDataAverage = mean(ECoGData,3);
        ECoGDataAverage(:,stimChans,:) = nan;
        smallMultiplesModeling(ECoGDataAverage,t,'type1',stimChans,'average',1,'sameScale',sameScale);
        currentDirec = pwd;
        if saveIt
            SaveFig(currentDirec,['subject_' num2str(ii) '_average_signal'],'eps')
        end
    end
    %%
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,meanEveryTrialAll,extractCellAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,meanEveryTrial,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,meanEveryTrialAll,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,1,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    %%
    [dataSubset,tSubset] = data_subset(ECoGData,1e3*t,preExtract,postExtract);
    dataSubsetCell{counterIndex} = dataSubset;
    
    sidCell{counterIndex} = sid;
    subjectNum(ii) = ii;
    counterIndex = counterIndex + 1;
end

if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('Electrode')
    ylabel('Voltage (V)')
    if saveIt
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_first7_v2']),'png','-r600');
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_first7_v2']),'eps','-r600');
    end
end

[first_7_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,meanEveryTrialAll,stimChansVec,...
    currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum,dataSubsetCell,tSubset);

clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat currentMatVec stimChansVec numberStimsAll extractCellAll sidCell subjectNum sid ii jj counterIndex tSubset dataSubset dataSubsetCell