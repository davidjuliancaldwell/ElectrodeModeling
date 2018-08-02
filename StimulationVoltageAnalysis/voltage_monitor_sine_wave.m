function [stim1Epoched,t,fsStim,labels,uniqueLabels] = voltage_monitor_sine_wave(Stim,Sing,plotIt,savePlot,titleToUse,OUTPUT_DIR,saveName)

%VOLTAGE_MONITOR Summary of this function goes here
%   Detailed explanation goes here

% build a burst table with the timing of stimuli
bursts = [];

% first channel of current
Sing1 = Sing.data(:,1);
fsSing = Sing.info.SamplingRateHz;
fsStim = Stim.info.SamplingRateHz;

samplesOfPulse = round(2*fsStim/1e3);

Sing1Mask = Sing1~=0;
dmode = diff([0 Sing1Mask' 0 ]);

dmode(end-1) = dmode(end);

bursts(2,:) = find(dmode==1);
bursts(3,:) = find(dmode==-1);

singEpoched = squeeze(getEpochSignal(Sing1,(bursts(2,:)-1),(bursts(3,:))+1));
t = (0:size(singEpoched,1)-1)/fsSing;
t = t*1e3;

if plotIt
    figure
    plot(t,singEpoched)
    xlabel('Time (ms)');
    ylabel('Current to be delivered (\muA)')
    title('Current to be delivered for all trials')
end


%% Plot stims with info from above, and find the delay!

stim1stChan = Stim.data(:,1);
stim1Epoched = squeeze(getEpochSignal(stim1stChan,(bursts(2,:)-1),(bursts(3,:))+120));

% put around 0
stim1Epoched = stim1Epoched - repmat(stim1Epoched(1,:),size(stim1Epoched,1),1);
t = (0:size(stim1Epoched,1)-1)/fsStim;
t = t*1e3;

% delay looks to be 7 samples

%% DJC - 10-28-2016 - normalize to baseline

labels = max(singEpoched);
uniqueLabels = unique(labels);
%
% get the delay in stim times - looks to be 7 samples or so
delay = round(0.2867*fsStim/1e3);

%delay = 0; %%%% setting delay = 0 to show better plots

% plot the appropriately delayed signal
if plotIt
    stimTimesBegin = bursts(2,:)-1+delay;
    stimTimesEnd = bursts(3,:)-1+delay+120;
    stim1Epoched = squeeze(getEpochSignal(stim1stChan,stimTimesBegin,stimTimesEnd));
    
    for i = uniqueLabels
        stim1EpochedInt = stim1Epoched(:,labels==i);
        t = (0:size(stim1EpochedInt,1)-1)/fsStim;
        t = t*1e3;
        figure
        plot(t,mean(stim1EpochedInt,2),'linewidth',2)
        xlabel('Time (ms)');
        ylabel('Voltage (V)');
        title(titleToUse)
        set(gca,'fontsize',14)
        xlim([0 4])
        if savePlot
            SaveFig(OUTPUT_DIR,[saveName]);
        end
    end
end


% % redefine delay for
end

