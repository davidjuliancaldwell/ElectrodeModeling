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
sameScale = 0;
saveIt = 1;
% only do 64 channels right now
meanMatAll = zeros(64,2,numStimChans,numCurrents);
stdMatAll =  zeros(64,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 4;
numColumns = 4;
stdEveryPoint = {};
extractCellAll = {};
meanEveryTrialAll = {};
phaseSigAll = {};
subjectNum = [];
numChansInt = 64;
sid = '3ada8b';

for stimChans = stimChansVec'
    
    fprintf(['running for 3ada8b stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile('G:\My Drive\CDrive-Output-Pistachio\stimSpacing\outputData', ['3ada8b_' num2str(stimChans(1)) '_' num2str(stimChans(2))]),'dataEpoched','t','stimEpoched','fsData');
    
    % convert t back to ms
    t = t/1e3;
    if ii == 1
        dataEpoched = dataEpoched(:,:,3:end);
        stimEpoched = stimEpoched(:,3:end);
    end
    stimChans = stimChansVec(ii,:);
    ECoGData = dataEpoched;
    %  ECoGData = ECoGData(:,1:92,:);
        ECoGData = ECoGData(:,1:64,:);

%      % rebaseine these to just be 25 to 5 ms before
%     for chan = 1:size(ECoGData,3)
%         ECoGData(:,chan,:) =  ECoGData(:,chan,:)-repmat(mean(ECoGData((t<0-0.005 & t>-0.025),chan,:),1), [size(ECoGData, 1),1]);
%     end
    
    fs = fsData;
    
    figure
    plot(stimEpoched)
    %%
    [meanMat,stdMat,stdCellEveryPoint,meanEveryTrial,extractCell,numberStims,phaseSig] = voltage_extract_avg(ECoGData,'fs',...
        fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    %%
    % scale after processing, since 4x is also in voltage_extract function
    ECoGData = 4.*ECoGData;
    
    if plotIt
        figure
        ECoGDataAverage = mean(ECoGData,3);
        ECoGDataAverage(:,stimChans,:) = nan;
        smallMultiplesModeling(ECoGDataAverage,t,'type1',stimChans,'average',1,'sameScale',sameScale);
        currentDirec = pwd;
        if saveIt
            SaveFig(OUTPUT_DIR,['3ada8b_run_' num2str(ii) '_average_signal'],'eps')
        end
    end
    %%
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,meanEveryTrialAll,extractCellAll,phaseSigAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,meanEveryTrial,extractCell,phaseSig,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,meanEveryTrialAll,extractCellAll,phaseSigAll,...
        stimChans,currentMatVec,numChansInt,sid,1,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    %%
    [dataSubset,tSubset] = data_subset(ECoGData,t,preExtract,postExtract);
    dataSubsetCell{counterIndex} = dataSubset;
    
    subjectNum(counterIndex) = 12;
    sidCell{counterIndex} = sid;
    ii = ii + 1;
    counterIndex = counterIndex + 1;
end
%%
if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    if saveIt
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png','-r600');
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'eps');
        
    end
    
end

%%
[subj_3ada8b_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,meanEveryTrialAll,stimChansVec,...
    currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum,dataSubsetCell,tSubset,phaseSigAll);

clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat currentMatVec stimChansVec numberStimsAll extractCellAll sidCell subjectNum sid ii jj counterIndex tSubset dataSubset dataSubsetCell phaseSigAll