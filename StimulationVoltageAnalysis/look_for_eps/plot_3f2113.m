close all;clear all;clc

DATA_DIR = 'G:\My Drive\GRIDLabDavidShared\3f2113\100msBefore300after';
OUTPUT_DIR = 'G:\My Drive\GRIDLabDavidShared\ECoGOptimization_Grant_2018';
stimChansVec = [12 52; 28 29; 28 36; 20 44; 4 60];

saveFig = 1;
average = 1;
trainDuration = [];
modePlot = 'avg';
xlims = [-10 150];
ylims = [-0.15 0.15];
reref = 1;
numChans = 80;

for stimChans = stimChansVec'
    load(fullfile(DATA_DIR,['stim_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']));
    
    if all(stimChans == [12 52]')
        rerefs = [1:3 6:8 25:32 33:40];
    elseif all(stimChans == [28 29]')
        rerefs = [1:16 49:64];
    elseif all(stimChans == [28 36]')
        rerefs = [1:16 49:64];
    elseif all(stimChans == [20 44]')
        rerefs = [1:8 57:64];
    elseif all(stimChans == [4 60]')
        rerefs = [25:40];
    end
    
    
    if reref
        rerefChans = dataEpochedHigh(:,rerefs,:);
        rerefChans = mean(rerefChans,2);
        dataEpochedHigh = dataEpochedHigh - repmat(rerefChans,1,numChans);
    end
    
    small_multiples_time_series(dataEpochedHigh(:,1:64,:),1e-3*t,'type1',stimChans,'type2',0,'xlims',xlims,'ylims',ylims,'modePlot',modePlot,'highlightRange',trainDuration)
    if saveFig
        SaveFig(OUTPUT_DIR,['3f2113_' num2str(stimChans(1)) '_' num2str(stimChans(2))],'eps')
    end
    %    small_multiples_time_series(dataEpochedHigh(:,65:80,:),1e-3*t,'type1',stimChans,'type2',0,'xlims',xlims,'ylims',ylims,'modePlot',modePlot,'highlightRange',trainDuration)
    
end