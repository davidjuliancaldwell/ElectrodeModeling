%% now go through 2fd831

% vector to loop through
stimChansVec = [
    122 121;
    121 122
    63 121
    121 63
    55 121
    121 55];

currentMatVec   = repmat([0.0005],length(stimChansVec),1);
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

numStimChans = size(stimChansVec,1);
numCurrents = size(currentMatVec,2);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(128,2,numStimChans,numCurrents);
stdMatAll =  zeros(128,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 2;
numColumns = 3;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 128;
sid = '2fd831';
dataDir_2fd831 = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\ECoG_Subjects\2fd831\StimulationSpacingChunked';
filesChoice = [2 3 5 6 8 9];

for stimChans = stimChansVec'
    fprintf(['running for 2fd831 stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile(dataDir_2fd831,['stim_widePulse_' num2str(stimChans(1)) '_' num2str(stimChans(2))]));
    fs = 12207;
    stimChans = stimChansVec(ii,:);
    ECoGData = dataEpoched;
    ECoGData = ECoGData(:,1:128,:);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    
    pair_inds = strsplit(char(pair),'_');
    
    subjectNum(counterIndex) = 11;
    sidCell{counterIndex} = sid;
    ii = ii + 1;
    counterIndex = counterIndex + 1;
    
end

if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
end

[subj_2fd831_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum);
clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat extractCellAll