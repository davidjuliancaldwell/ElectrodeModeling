%% try DBS subject 3972f
% preSamps = 3;
% postSamps = 3;
stimChansVec = [4 3; 3 4; 5 4; 4 5; 6 5; 5 6; 2 3; 3 2; 6 4; 4 6; 5 7; 7 5]';
currentMatVec = repmat([0.0005],length(stimChansVec),1);
labels = [repmat(50,20,1); repmat(100,20,1)];

numStimChans = size(stimChansVec,2);
numCurrents = size(currentMatVec,2);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(8,2,numStimChans,numCurrents);
stdMatAll =  zeros(8,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 4;
numColumns = 3;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 8;

sid = DBS_SIDS{3};
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

for stimChans = stimChansVec
    fprintf(['running for 3972f stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile('G:\My Drive\GRIDLabDavidShared\resistivityDataSets\DBS_Subjects\Voltage_Monitor\3972f', ['stimSpacingDBS-3972f-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    
    % take off mean for DBS channels
    tSamps = 1:size(dataEpoched,1);
    
    dataEpoched = dataEpoched(:,1:numChansInt,:);

    % fs is in these data files
    for chan = 1:8
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
       
    subjectNum(counterIndex) = 19;
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

[subj_3972f_DBS_struct] = convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,...
    currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum,dataSubsetCell,tSubset);

clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat currentMatVec stimChansVec numberStimsAll extractCellAll sidCell subjectNum sid ii jj counterIndex tSubset dataSubset dataSubsetCell