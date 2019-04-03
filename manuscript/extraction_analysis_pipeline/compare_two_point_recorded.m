%close all;clear all;clc
loadData = 0;
chanInt = 14;
subj = 1;
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
fig_compare.Units = "inches"
fig_compare.Position = [1 1 8 8];
subplot(2,2,1)
plot(first_7_struct.t,squeeze(first_7_struct.data{subj}(:,chanInt,:)))
title('Raw epoched data')
xlabel('Time (ms)')


subplot(2,2,2)
plot(squeeze(first_7_struct.phaseSigAll{subj}{chanInt}{1}))
title('Raw extracted first phase')
xlabel('Sample')

subplot(2,2,3)
plot(squeeze(first_7_struct.meanEveryTrial{subj}(chanInt,1,:)))
title('Mean first phase for every trial')
xlabel('Trial')

subplot(2,2,4)
plot(squeeze(vJumpCell{subj}))
xlabel('Trial')
title('Jump voltage for every trial')
