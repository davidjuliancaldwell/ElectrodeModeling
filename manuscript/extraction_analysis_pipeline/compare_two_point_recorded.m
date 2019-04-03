close all;clear all;clc
loadData = 1;
chanInt = 53;
subj = 4;
cd(fileparts(which('first7_analyze_monitor')));
currentWD = pwd;
dataDir = fullfile(currentWD,'..','..','..','data');
if loadData
    %first7_analyze_monitor
    load(fullfile(dataDir,'twoPointData.mat'));
    load(fullfile(dataDir,'recorded_voltages_v2.mat'));
end

%%
fig_compare = figure;
fig_compare.Units = "inches";
fig_compare.Position = [1 1 8 8];
subplot(2,2,1)
plot(first_7_struct.t,1e3*squeeze(first_7_struct.data{subj}(:,chanInt,:)))
set(gca,'fontsize',12)
xlabel('Time (ms)')
ylabel('Voltage (mV)')
titlePar = title('Raw epoched data','fontweight','normal');
set(titlePar,'FontSize',14);

subplot(2,2,2)
plot(1e3*squeeze(first_7_struct.phaseSigAll{subj}{chanInt}{1}))
set(gca,'fontsize',12)
xlabel('Sample')
ylabel('Voltage (mV)')
titlePar = title('Raw extracted first phase','fontweight','normal');
set(titlePar,'FontSize',14)

subplot(2,2,3)
plot(1e3*squeeze(first_7_struct.meanEveryTrial{subj}(chanInt,1,:)))
set(gca,'fontsize',12)
xlabel('Trial')
ylabel('Voltage (mV)')
titlePar = title('Mean first phase for every trial','fontweight','normal');
set(titlePar,'FontSize',14)

subplot(2,2,4)
plot(squeeze(vJumpCell{subj}))
set(gca,'fontsize',12)
xlabel('Trial')
ylabel('Voltage (mV)')
titlePar = title('Jump voltage for every trial','fontweight','normal','FontSize',14);
set(titlePar,'FontSize',14)
