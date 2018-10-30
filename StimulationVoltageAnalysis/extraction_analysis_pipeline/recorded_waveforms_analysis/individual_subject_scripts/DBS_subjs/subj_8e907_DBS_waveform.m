%% DBS subject 8e907

stimChansVec = [7 8 ; 6 7; 5 4];
currentMatVec = repmat([0.00001,0.0001,0.0005],length(stimChansVec),1);

numStimChans = size(stimChansVec,2);
numCurrents = size(currentMatVec,2);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(8,2,numStimChans,numCurrents);
stdMatAll =  zeros(8,2,numStimChans,numCurrents);
numberStimsAll =  zeros(numStimChans,numCurrents,1);
numRows = 3;
numColumns = 3;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 8;

sid = DBS_SIDS{7};
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

for stimChans = stimChansVec'
    jj = 1;
    for current = currentMatVec(1,:)
        stimChans = stimChansVec(ii,:);
        fprintf(['running for 8e907 stim chans ' num2str(stimChans(1)) '\n']);
        load(fullfile('G:\My Drive\GRIDLabDavidShared\resistivityDataSets\DBS_Subjects\Voltage_Monitor\8e907', ['EPScreen-DBS-8e907-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
                fs = fsData;

        dataEpoched = dataEpoched(:,1:8,(round(3*stimLevelLabels)==1e6*(current) & pulseWidthLabels >1.05e3));
        
        % ALREADY MEAN SUBTRACTED
        % fs is in these data files
%         for chan = 1:8
%             %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
%             dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(tSamps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';
%             
%         end
%         
        % calculate metrics of interest
        [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpoched,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
        [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  DBS_subject_processing(ii,jj,...
            meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
            meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
            stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
        
        jj = jj + 1;
        counterIndex = counterIndex + 1;
        
    end
    ii = ii + 1;
    
end

if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
end

[subj_3972f_DBS_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,currentMatVec,numberStimsAll,extractCellAll);
clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat extractCellAll

