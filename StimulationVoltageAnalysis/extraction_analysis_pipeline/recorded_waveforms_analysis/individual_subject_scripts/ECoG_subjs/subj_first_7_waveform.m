%% factor of 4 is included in here NOW within voltage_extract_avg

% data for further analysis
meanMatAll = zeros(64,2,7,1);
stdMatAll = zeros(64,2,7,1);
numberStimsAll = zeros(7,1,1);
stdEveryPoint = {};
extractCellAll = {};
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

% stimulation currents in A
stimChansVec = [22 30;13 14;11 12;59 60;56 55;54 62;56 64];
currentMatVec = [0.00175 0.00075 0.0035 0.00075 0.003 0.0025 0.00175];
numChansInt = 64;
counterIndex = 1;
numRows = 4;
numColumns = 2;
for ii = 1:7
    sid = SIDS{ii};
    fprintf(['running for subject ' sid '\n']);
    fs = 12207;
    jj =1;
    stimChans = stimChansVec(ii,:);
    load(fullfile([sid '_StimulationAndCCEPs.mat']))
    ECoGData = permute(ECoGData,[1 3 2]);
    
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',...
        fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    
    counterIndex = counterIndex + 1;
end

if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_first7']),'png');
end

[first_7_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,currentMatVec,numberStimsAll,extractCellAll);

clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat extractCellAll