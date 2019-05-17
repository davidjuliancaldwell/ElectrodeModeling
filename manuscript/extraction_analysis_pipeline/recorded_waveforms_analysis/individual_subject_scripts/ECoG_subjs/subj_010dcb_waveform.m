%% now go through 010dcb - DIVIDE THIS BY 4 SINCE IT WAS ALREADY ACCOUNTED FOR
Z_Constants_Resistivity

myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.mat')); %gets all mat files in struct


% vector to loop through
stimChansVec = {[4,5],[4 7 8],[5 7 8]}; % cell of stimulation channel combinations

currentMatVec  = [-2333 2333];
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

numStimChans = size(stimChansVec,1);
numCurrents = size(currentMatVec,2);
plotIt = 1;
ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(99,2,numStimChans,numCurrents);
stdMatAll =  zeros(99,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 3;
numColumns = 1;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 99;
sid = '010dcb';


for ii = [1:3]
    stimChans = stimChansVec{ii};
    baseFileName = myFiles(ii).name;
    myFolder = myFiles(ii).folder;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    load(fullFileName);
    
    fs = 12207;
    stimChans = stimChansVec;
    ECoGData = dataEpoched./(4*1e6); % FACTOR OF 4 !!!!
    ECoGData = ECoGData(:,1:99,(labels==current));
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',1);
    
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