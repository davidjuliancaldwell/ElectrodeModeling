%%
close all;clear all;clc
Z_Constants_Resistivity
plotIt = 0;

%% go through first seven subjects first
fs = 12207;
preSamps = 3;
postSamps = 3;
figTotal = figure;

% data for further analysis
meanMatAll_1st7 = zeros(64,2,7);
stdMatAll_1st7 = zeros(64,2,7);
numberStimsAll_1st7 = zeros(7,1);

for i = 1:length(SIDS)
    sid = SIDS{i};
    stimChans_subj = stimChans(i,:);
    load(fullfile([sid '_StimulationAndCCEPs.mat']))
    ECoGData = permute(ECoGData,[1 3 2]);
    [meanMat,stdMat,extractCell,numberStims] = voltage_extract_avg(ECoGData,fs,preSamps,postSamps);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    
    meanMatAll_1st7(:,:,i) = meanMat;
    stdMatAll_1st7(:,:,i) = stdMat;
    numberStimsAll_1st7(i) = numberStims;
    
    if plotIt
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
        
        figure(figTotal)
        subplot(4,2,i)
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
        
        title(['Subject ' num2str(i)])
    end
end
if plotIt
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
plotIt = 1
meanMatAll_2nd5 = zeros(110,2,5);
stdMatAll_2nd5 = zeros(110,2,5);
numberStimsAll_2nd5 = zeros(5,1);
chansVec = [1:110];
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

    [meanMat,stdMat,extractCell,numberStims] = voltage_extract_avg(ECoGData,fs,preSamps,postSamps);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    
    meanMatAll_2nd5(:,:,i) = meanMat;
    stdMatAll_2nd5(:,:,i) = stdMat;
    numberStimsAll_2nd5(i) = numberStims;
    
    i = i + 1;
    
    
    pair_inds = strsplit(char(pair),'_');
    
    %pair_title = strrep(pair,'_','\_');
    
    if plotIt
        chanVec = [1:32];
        figure
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        title(['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}])
        
        figure(figTotal)
        subplot(2,3,i)
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        
        title(['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}])
    end
end
if plotIt
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
end
%% try DBS subject
preSamps = 3;
postSamps = 3;
stimChansVec = [2 3; 3 2; 3 4; 4 3; 4 5; 5 4; 5 6; 6 5; 6 7; 7 6]';
numTrials = size(stimChansVec,2);

meanMatAll_DBS = zeros(12,2,numTrials);
stdMatAll_DBS = zeros(12,2,numTrials);
numberStimsAll_DBS = zeros(numTrials,1);

stimChansVec = [2 3; 3 2; 3 4; 4 3; 4 5; 5 4; 5 6; 6 5; 6 7; 7 6]';
i = 1;
for stimChans = stimChansVec
    
    
    %stimChans = [2 3];
    load(fullfile(DBS_DIR, ['stimSpacingDBS-5e0cf-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    
    % take off mean for DBS channels
    t_samps = 1:size(dataEpoched,1);
    stimChans_subj = stimChans;
    
    for chan = 1:12
        %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
        dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(t_samps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';
        
    end
    
    % calculate metrics of interest
    [meanMat,stdMat,extractCell,numberStims] = voltage_extract_avg(dataEpoched/1e6,fs,preSamps,postSamps);
    chanVec = [1:size(dataEpoched,2)];
    
    meanMat(stimChans,:) = nan;
    stdMat(stimChans,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    
    meanMatAll_DBS(:,:,i) = meanMat;
    stdMatAll_DBS(:,:,i) = stdMat;
    numberStimsAll_DBS(i) = numberStims;
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
    end
end

%%

saveIt = 1;
if saveIt
    save('meansStds.mat','meanMatAll_DBS','stdMatAll_DBS','numberStimsAll_DBS',...
        'meanMatAll_2nd5','stdMatAll_2nd5','numberStimsAll_2nd5',...
        'meanMatAll_1st7','stdMatAll_1st7','numberStimsAll_1st7');
end