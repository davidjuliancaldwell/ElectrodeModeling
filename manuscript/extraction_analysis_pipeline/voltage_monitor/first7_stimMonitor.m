%%
close all;clear all;clc
Z_Constants_Resistivity

plotIt = 0;
savePlot = 0;
saveData = 1;
discardBads = 1;

DATA_DIR = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\ECoG_Subjects\Voltage_Monitor\raw_stimMonitor';

figAverage = figure;
figAverage.Units = "inches";
figAverage.Position = [0.5 0.5 8 4];

figInd = figure;
figInd.Units = "inches";
figInd.Position = [0.5 0.5 8 4];

for ii = 1:length(SIDS)
    sid = SIDS{ii};
    
    load(fullfile(DATA_DIR, [sid '_stimMonitor.mat']));
    
    
    [stim1Epoched,t,fs] = voltage_monitor_first7(Stim,Sing,plotIt,savePlot);
    
    if discardBads
        medianPeak = median(max(stim1Epoched,[],1));
        badTrials = find(max(stim1Epoched,[],1)>1.5*medianPeak | max(stim1Epoched,[],1)<0.5*medianPeak );
        stim1Epoched(:,badTrials) = [];
    end
    %stimChan_calculate(stim1Epoched_500uA,fs)
    numTrials = size(stim1Epoched,2);
    
    figure(figAverage)
    subplot(2,4,ii)
    plot(t,mean(stim1Epoched(:,:),2),'linewidth',2)
    set(gca,'fontsize',14)
    xlim([0 2])
    ylim([-2 6])
    text(0.1,-1.5,['N = ' num2str(numTrials)],'fontsize',10)
    title(['Subject ' num2str(ii)])
    
    figure(figInd)
    subplot(2,4,ii)
    plot(t,stim1Epoched(:,:),'linewidth',0.5,'color',[0.5 0.5 0.5])
    set(gca,'fontsize',14)
    xlim([0 2])
    ylim([-2 6])
    text(0.1,-1.5,['N = ' num2str(numTrials)],'fontsize',10)
    
    title(['Subject ' num2str(ii)])
    
    stim_data = stim1Epoched;
    
    if saveData
        save(fullfile(OUTPUT_DIR,[sid '_stimOutput.mat']),'stim_data','t','fs')
    end
end

figure(figAverage)
xlabel('Time (ms)');
ylabel('Voltage (V)');

figure(figInd)
xlabel('Time (ms)');
ylabel('Voltage (V)');