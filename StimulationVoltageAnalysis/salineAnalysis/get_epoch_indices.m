function [sts,bursts] = get_epoch_indices(sing,fsData,fsSing)

% build a burst table with the timing of stimuli
bursts = [];

% first channel of current
Sing1 = sing(:,1);

Sing1Mask = Sing1~=0;
dmode = diff([0 Sing1Mask' 0 ]);

dmode(end-1) = dmode(end);

bursts(2,:) = find(dmode==1);
bursts(3,:) = find(dmode==-1);

% get the delay in stim times - looks to be 7 samples or so
delay = round(0.2867*fsSing/1e3);

% try and account for delay for the stim times
stimTimes = bursts(2,:)-1+delay;

% sampling rate conversion between stim and data
fac = fsSing/fsData;

% find times where stims start in terms of data sampling rate
sts = round(stimTimes / fac);

% looks like there's an additional 14 sample delay between the stimulation being set to
% be delivered....and the ECoG recording. which would be 2.3 ms?

delay2 = 14;
sts = round(stimTimes / fac) + delay2;
%sts = round(stimTimes / fac);

end