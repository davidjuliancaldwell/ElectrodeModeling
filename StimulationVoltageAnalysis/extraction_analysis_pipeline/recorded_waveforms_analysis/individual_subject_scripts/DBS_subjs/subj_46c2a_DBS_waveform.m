%% DBS subject 46c2a

stimChansVec = [4 5]';
currentMatVec = [0.00005,0.0001];

numStimChans = size(stimChansVec,2);
numCurrents = size(currentMatVec,2);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(8,2,numStimChans,numCurrents);
stdMatAll =  zeros(8,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 2;
numColumns = 1;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 8;

sid = DBS_SIDS{4};
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);
labels = [repmat(50,20,1); repmat(100,20,1)];

for current = currentMatVec
    stimChans = stimChansVec;
    fprintf(['running for 46c2a stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile('G:\My Drive\GRIDLabDavidShared\resistivityDataSets\DBS_Subjects\Voltage_Monitor\46c2a', ['stimSpacingDBS-46c2a-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    
    % take off mean for DBS channels
    tSamps = 1:size(dataEpoched,1);
    
    dataEpoched = dataEpoched(:,1:8,(labels==1e6*(current)));
    
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
        
    subjectNum(counterIndex) = 17;
    sidCell{counterIndex} = sid; 

    %ii = ii + 1;
    jj = ii + 1;
    counterIndex = counterIndex + 1;
    
end
if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');

end

[subj_46c2a_DBS_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum);
clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat currentMatVec stimChansVec numberStimsAll extractCellAll sidCell subjectNum sid ii jj counterIndex

