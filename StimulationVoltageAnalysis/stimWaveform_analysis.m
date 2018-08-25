%%
close all;clear all;clc
Z_Constants_Resistivity
plotIt = 0;

%% go through first seven subjects first
fs = 12207;
preSamps = 3;
postSamps = 3;
figTotal = figure;
plotIt = 1;

% data for further analysis
meanMatAll_1st8 = zeros(64,2,8);
stdMatAll_1st8 = zeros(64,2,8);
numberStimsAll_1st8 = zeros(8,1);
stdEveryPoint_1st8 = {};

for i = 1:length(SIDS)
    sid = SIDS{i};
    stimChans_subj = stimChans(i,:);
    load(fullfile([sid '_StimulationAndCCEPs.mat']))
    ECoGData = permute(ECoGData,[1 3 2]);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_1st8(:,:,i) = meanMat;
    stdMatAll_1st8(:,:,i) = stdMat;
    numberStimsAll_1st8(i) = numberStims;
    stdEveryPoint_1st8{i} = stdCellEveryPoint;
    
    if plotIt
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        chanVec = [1:size(ECoGData,2)];
        figure
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
        hold on
        errorbar(chanVec+0.3,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(i)])
        title(['Mean and Standard Deviation for Recorded Biphasic Pulse'])
        set(gca,'fontsize',16)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure(figTotal)
        subplot(4,2,i)
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
        
        title(['Subject ' num2str(i)])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(i)])
        title({['Subject ' num2str(i)],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
        
    end
end
if plotIt
    figure(figTotal)
    
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
end
%% now go through the next 5 spacing
dataStruct = struct('pair_21_20',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_20_12',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_22_19',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_23_18',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_28_4',struct('stim_current',[],'time_vec',[],'stim_data',[]));

% vector to loop through
stimChans = [ 20 12;21 20; 22 19; 23 18; 28 4];
pair_vec = {'pair_20_12','pair_21_20','pair_22_19','pair_23_18','pair_28_4'};
fs = 12207;
preSamps = 3;
postSamps = 3;
figTotal = figure;

i = 1;
plotIt = 1;
meanMatAll_2nd5 = zeros(110,2,5);
stdMatAll_2nd5 = zeros(110,2,5);
numberStimsAll_2nd5 = zeros(5,1);
stdEveryPoint_2nd5 = {};
chansVec = [1:110];
sid = '20f8a3';
for pair = pair_vec
    
    switch(char(pair))
        case 'pair_20_12'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_20_12.mat')
        case 'pair_21_20'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_21_20.mat')
        case 'pair_22_19'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_22_19.mat')
        case 'pair_23_18'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_23_18.mat')
        case 'pair_28_4'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_28_4.mat')
    end
    stimChans_subj = stimChans(i,:);
    ECoGData = dataEpoched;
    ECoGData = ECoGData(:,chansVec,:);
    
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_2nd5(:,:,i) = meanMat;
    stdMatAll_2nd5(:,:,i) = stdMat;
    numberStimsAll_2nd5(i) = numberStims;
    stdEveryPoint_2nd5{i} = stdCellEveryPoint;
    
    i = i + 1;
    
    
    pair_inds = strsplit(char(pair),'_');
    
    %pair_title = strrep(pair,'_','\_');
    
    if plotIt
        chanVec = [1:110];
        figure
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        title(['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure(figTotal)
        subplot(2,3,i)
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        
        title(['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(i)])
        title({['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid '_electrodePair_'  pair_inds{2} '_' pair_inds{3} ]),'png');
        
    end
end
if plotIt
    figure(figTotal)
    
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
end
%% try DBS subject 5e0cf
preSamps = 3;
postSamps = 3;
%fs = 48828;
stimChansVec = [2 3; 3 2; 3 4; 4 3; 4 5; 5 4; 5 6; 6 5; 6 7; 7 6; 4 6; 6 4]';
numTrials = size(stimChansVec,2);

meanMatAll_DBS_5e0cf = zeros(12,2,numTrials);
stdMatAll_DBS_5e0cf = zeros(12,2,numTrials);
numberStimsAll_DBS_5e0cf = zeros(numTrials,1);
stdEveryPoint_DBS_5e0cf = {};
i = 1;
DBS_SID = DBS_SIDS{1};

for stimChans = stimChansVec
    
    
    %stimChans = [2 3];
    load(fullfile(DBS_DIR,DBS_SID, ['stimSpacingDBS-5e0cf-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    
    % take off mean for DBS channels
    tSamps = 1:size(dataEpoched,1);
    stimChans_subj = stimChans;
    
    for chan = 1:12
        %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
        dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(tSamps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';
        
    end
    dataEpoched = dataEpoched/1e6; % the data was stored in uV, convert this to volts
    
    % calculate metrics of interest
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpoched,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    chanVec = [1:size(dataEpoched,2)];
    
    meanMat(stimChans,:) = nan;
    stdMat(stimChans,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_DBS_5e0cf(:,:,i) = meanMat;
    stdMatAll_DBS_5e0cf(:,:,i) = stdMat;
    numberStimsAll_DBS_5e0cf(i) = numberStims;
    stdEveryPoint_DBS_5e0cf{i} = stdCellEveryPoint;
    i = i + 1;
    
    
    if plotIt
        figure
        hold on
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        hax =axes;
        hold on
        hax.YScale = 'log';
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure('units','normalized','outerposition',[0 0 1 1])
        
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(i)])
        title({DBS_SID,['Electrode Pair ' num2str(stimChans(1)) ' ' num2str(stimChans(2))],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            hold on
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        
        set(gca,'YScale','log')
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1} v1 v2 v3],{'first phase','second phase','DBS/ECoG','- chan','+ chan'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' DBS_SID '_electrodePair_'  num2str(stimChans(1)) '_' num2str(stimChans(2)) ]),'png');
        
        
    end
end
%% try DBS subject b26b7
preSamps = 3;
postSamps = 3;
%fs = 48828;
stimChansVec = [7 6; 6 7; 7 8; 8 7; 8 6; 6 8; 3 5; 5 3; 7 10; 10 7]';
numTrials = size(stimChansVec,2);

meanMatAll_DBS_b26b7 = zeros(16,2,numTrials);
stdMatAll_DBS_b26b7 = zeros(16,2,numTrials);
numberStimsAll_DBS_b26b7 = zeros(numTrials,1);
stdEveryPoint_DBS_b26b7 = {};

i = 1;
DBS_SID = DBS_SIDS{2};
for stimChans = stimChansVec
    
    load(fullfile(DBS_DIR,DBS_SID, ['stimSpacingDBS-b26b7-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    
    % take off mean for DBS channels
    tSamps = 1:size(dataEpoched,1);
    stimChans_subj = stimChans;
    
    for chan = 1:16
        %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
        dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(tSamps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';
        
    end
    
    % calculate metrics of interest
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpoched,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    chanVec = [1:size(dataEpoched,2)];
    
    meanMat(stimChans,:) = nan;
    stdMat(stimChans,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_DBS_b26b7(:,:,i) = meanMat;
    stdMatAll_DBS_b26b7(:,:,i) = stdMat;
    numberStimsAll_DBS_b26b7(i) = numberStims;
    stdEveryPoint_DBS_b26b7{i} = stdCellEveryPoint;
    
    i = i + 1;
    
    if plotIt
        figure
        hold on
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure
        hax =axes;
        hold on
        hax.YScale = 'log';
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(i)])
        title({DBS_SID,['Electrode Pair ' num2str(stimChans(1)) ' ' num2str(stimChans(2))],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        
        set(gca,'YScale','log')
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1} v1 v2 v3],{'first phase','second phase','DBS/ECoG','- chan','+ chan'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' DBS_SID '_electrodePair_'  num2str(stimChans(1)) '_' num2str(stimChans(2)) ]),'png');
        
    end
end

%%

saveIt = 1;
if saveIt
    save('meansStds_8_25_2018.mat','meanMatAll_DBS_5e0cf','stdMatAll_DBS_5e0cf','numberStimsAll_DBS_5e0cf',...
        'meanMatAll_DBS_b26b7','stdMatAll_DBS_b26b7','numberStimsAll_DBS_b26b7',...
        'meanMatAll_2nd5','stdMatAll_2nd5','numberStimsAll_2nd5',...
        'meanMatAll_1st8','stdMatAll_1st8','numberStimsAll_1st8',...
        'stdEveryPoint_DBS_b26b7','stdEveryPoint_1st8','stdEveryPoint_2nd5','stdEveryPoint_DBS_b26b7');
end