%% now go through a7a181 - DIVIDE THIS BY 4 SINCE IT WAS ALREADY ACCOUNTED FOR

% vector to loop through
stimChansVec = [
    23 24
    ];

currentMatVec  = [0.0015 0.003 0.0075];
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

numStimChans = size(stimChansVec,1);
numCurrents = size(currentMatVec,2);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(112,2,numStimChans,numCurrents);
stdMatAll =  zeros(112,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 3;
numColumns = 1;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 112;
sid = 'a7a181';

for current = currentMatVec
    stimChans = stimChansVec;
    fprintf(['running for a7a181 stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile(['a7a181_' num2str(stimChans(1)) '_' num2str(stimChans(2))]),'dataEpoched','labels');
    fs = 12207;
    stimChans = stimChansVec;
    ECoGData = dataEpoched./4; % FACTOR OF 4 !!!!
    ECoGData = ECoGData(:,1:112,(labels==1e6*(current./3)));
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    
    [dataSubset,tSubset] = data_subset(ECoGData,t,preExtract,postExtract);
    dataSubsetCell{counterIndex} = dataSubset;
    
    subjectNum(counterIndex) = 13;
    sidCell{counterIndex} = sid;
    %  ii = ii + 1;
    jj = jj + 1;
    counterIndex = counterIndex + 1;
    
end
if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
    
end

[subj_a7a181_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,...
    currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum,dataSubsetCell,tSubset);

clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat currentMatVec stimChansVec numberStimsAll extractCellAll sidCell subjectNum sid ii jj counterIndex tSubset dataSubset dataSubsetCell