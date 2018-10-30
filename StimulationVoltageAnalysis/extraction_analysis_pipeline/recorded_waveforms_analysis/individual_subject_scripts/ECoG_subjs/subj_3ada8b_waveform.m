%% now go through 3ada8b

% vector to loop through
stimChansVec = [
    3 4;
    4 3;
    4 12;
    12 4;
    20 4;
    4 20;
    5 7;
    7 5;
    13 12;
    12 13;
    14 11;
    11 14
    15 10;
    10 15
    16 9;
    9 16;
    ];

currentMatVec = repmat([0.0005],length(stimChansVec),1) ;
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

numStimChans = size(stimChansVec,1);
numCurrents = size(currentMatVec,2);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(92,2,numStimChans,numCurrents);
stdMatAll =  zeros(92,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 4;
numColumns = 4;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 92;
sid = '3ada8b';

for stimChans = stimChansVec'
    
    fprintf(['running for 3ada8b stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile('G:\My Drive\CDrive-Output-Pistachio\stimSpacing\outputData', ['3ada8b_' num2str(stimChans(1)) '_' num2str(stimChans(2))]));
    
    stimChans = stimChansVec(ii,:);
    ECoGData = dataEpoched;
    ECoGData = ECoGData(:,1:92,:);
    fs = fsData;
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    
    ii = ii + 1;
    counterIndex = counterIndex + 1;
end
if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
end


[subj_3ada8b_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,currentMatVec,numberStimsAll,extractCellAll);
clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat extractCellAll