%%
close all;clear all;clc
Z_Constants_Resistivity
DATA_DIR = 'G:\My Drive\GRIDLabDavidShared\SharedForDavidLarryStephen\StimWaveFormData';

figure

for i = 1:length(SIDS)
    sid = SIDS{i};
    
    load(fullfile(DATA_DIR, [sid '_stimMonitor.mat']));
    
    plotIt = 0;
    savePlot = 0;
    [stim1Epoched,t,fs] = voltage_monitor_first7(Stim,Sing,plotIt,savePlot);
    %stimChan_calculate(stim1Epoched_500uA,fs)
    
    subplot(2,4,i)
    plot(t,mean(stim1Epoched(:,:),2),'linewidth',2)
    
    set(gca,'fontsize',14)
    xlim([0 4])
    title(['Subject ' num2str(i)])
    stim_data = stim1Epoched; 
    save(fullfile(OUTPUT_DIR,[sid '_stimOutput.mat']),'stim_data','t','fs')
end

xlabel('Time (ms)');
ylabel('Voltage (V)');