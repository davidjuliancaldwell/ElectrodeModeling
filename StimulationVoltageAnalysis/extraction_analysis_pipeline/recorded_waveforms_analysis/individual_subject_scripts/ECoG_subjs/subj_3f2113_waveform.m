%% go through 64 


stimChansVec = [ 31 32];
currentMatVec = [ 0.002];
% data for further analysis
meanMatAll = zeros(64,2,1,1);
stdMatAll = zeros(64,2,1,1);
numberStimsAll = zeros(1,1,1);
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 64;
counterIndex = 1;
numRows = 1;
numColumns = 1;
sid = '3f2113';
subjectNum = [];
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

for ii = 1:1
    fprintf(['running for subject ' sid '\n']);
    jj = 1;
    fs = 12207;
    stimChans = stimChansVec(ii,:);
    load(fullfile([sid '_StimulationAndCCEPs.mat']))
    ECoGData = permute(ECoGData,[1 3 2]);
    ECoGData = ECoGData(:,[1:48],:);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',...
        fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    subjectNum(ii) = 9;
end

[subj_3f2113_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum);
clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat extractCellAll