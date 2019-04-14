DATA_DIR = 'G:\My Drive\GRIDLabDavidShared\3f2113\100msBefore300after';

stimChans = [12 52];
load(fullfile(DATA_DIR,['stim_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']));
%%
average = 1;
%chanIntList = 3;
trainDuration = [];
modePlot = 'avg';
xlims = [-10 150];
ylims = [-0.1 0.1];

small_multiples_time_series(dataEpochedHigh(:,1:64,:),1e-3*t,'type1',stimChans,'type2',0,'xlims',xlims,'ylims',ylims,'modePlot',modePlot,'highlightRange',trainDuration)
