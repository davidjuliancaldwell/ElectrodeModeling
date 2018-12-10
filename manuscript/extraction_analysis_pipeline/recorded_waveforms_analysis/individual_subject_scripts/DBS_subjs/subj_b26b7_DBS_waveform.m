%% try DBS subject b26b7
preSamps = 3;
postSamps = 3;
stimChansVec = [7 6; 6 7; 7 8; 8 7; 8 6; 6 8; 3 5; 5 3; 7 10; 10 7]';
currentMatVec = repmat([0.0001],length(stimChansVec),1);
numStimChans = size(stimChansVec,2);
numCurrents = size(currentMatVec,2);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(16,2,numStimChans,numCurrents);
stdMatAll =  zeros(16,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 5;
numColumns = 2;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 16;

sid = DBS_SIDS{2};
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

for stimChans = stimChansVec
    fprintf(['running for b26b7 stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile(DBS_DIR,sid, ['stimSpacingDBS-b26b7-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    
    % take off mean for DBS channels
    tSamps = 1:size(dataEpoched,1);
    % fs is in these data files
    for chan = 1:16
        %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
        dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(tSamps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';
        
    end
    % calculate metrics of interest
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpoched,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  DBS_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    
   [dataSubset,tSubset] = data_subset(dataEpoched,t,preExtract,postExtract);
    dataSubsetCell{counterIndex} = dataSubset;
    
    subjectNum(counterIndex) = 20;
    sidCell{counterIndex} = sid;
    
    ii = ii + 1;
    %  jj = ii + 1;
    counterIndex = counterIndex + 1;
    
end
if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
    
end

[subj_b26b7_DBS_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,...
    currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum,dataSubsetCell,tSubset);

clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat currentMatVec stimChansVec numberStimsAll extractCellAll sidCell subjectNum sid ii jj counterIndex tSubset dataSubset dataSubsetCell