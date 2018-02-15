%%
close all;clear all;clc
Z_Constants_Resistivity

%% go through first seven subjects first
fs = 12207;
preSamps = 3;
postSamps = 3;
figTotal = figure;
for i = 1:length(SIDS)
    sid = SIDS{i};
    stimChans_subj = stimChans(i,:);
    load(fullfile([sid '_StimulationAndCCEPs.mat']))
    ECoGData = permute(ECoGData,[1 3 2]);
    [meanMat,stdMat,extractCell] = voltage_extract_avg(ECoGData,fs,preSamps,postSamps);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    
    
    chanVec = [1:size(ECoGData,2)];
    figure
    errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
    hold on
    errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    title(['Subject ' num2str(i)])
    
    figure(figTotal)
    subplot(4,2,i)
    errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
    hold on
    errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
    
    title(['Subject ' num2str(i)])
end
legend('first phase','second phase')
xlabel('electrode')
ylabel('Voltage (V)')
%% now go through the next 5 spacing


for i = 1:5
    
    
    
end

%% try DBS subject 
DBS_DIR = 'G:\My Drive\GRIDLabDavidShared\DBS\5e0cf';
stimChans = [2 3];
load(fullfile(DBS_DIR, ['stimSpacingDBS-5e0cf-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));

% take off mean for DBS channels
t_samps = 1:size(dataEpoched,1);

for chan = 1:12
    %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
    dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(t_samps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';

end


% calculate metrics of interest 
[meanMat,stdMat,extractCell] = voltage_extract_avg(dataEpoched,fs,preSamps,postSamps);
    chanVec = [1:size(dataEpoched,2)];


figure
hold on
errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
xlabel('Electrode')
ylabel('\muV')
title(['Mean and std for middle of recorded pulses - stim chans ' num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
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
ylabel('\muV')
title(['Mean and std for middle of recorded pulses - stim chans ' num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
vline(9,'k')
vline(stimChans(1),'g')
vline(stimChans(2),'b')
legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')

