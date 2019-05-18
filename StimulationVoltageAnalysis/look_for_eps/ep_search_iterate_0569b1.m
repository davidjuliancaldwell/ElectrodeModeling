%% script to iterate through all of the files in a directory once they are converted
% David.J.Caldwell 10.10.2018
%% initialize output and meta dir
% clear workspace, get rid of extraneous information
close all; clear all; clc
myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.mat')); %gets all mat files in struct

numChans = 100;
preTime = 100; % pre time in ms
postTime = 200; % post time in ms
saveIt = 0;
sid = '0569b1'; % subject id
stimChansVec = {[11 12],[11 89 90]};
%%
for ii = 1:length(myFiles)
    %for ii = [1:3]
    stimChans = stimChansVec{ii};
    baseFileName = myFiles(ii).name;
    myFolder = myFiles(ii).folder;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    load(fullfile(myDir,['stimGeometry-' num2str(ii) '.mat'])); % stim geometry converted file
    
    for reref = 0:0 % are you referencing? boolean
        
        %%
        
        if size(ECO1.data,1) == size(ECO3.data,1)
            data = 4.*[ECO1.data ECO2.data ECO3.data]; % add in factor of 4 10.10.2018
        else
            data = 4.*[ECO1.data(1:end-1,:) ECO2.data(1:end-1,:) ECO3.data]; % add in factor of 4 10.10.2018
        end
        
        data = data(:,1:numChans);
        
        fsData = ECO1.info.SamplingRateHz;
        
        % get sampling rates
        fsStim = Stim.info.SamplingRateHz;
        fsSing = Sing.info.SamplingRateHz;
        preSamps = round(preTime/1000 * fsData); % pre time in sec
        postSamps = round(postTime/1000 * fsData); % post time in sec,
        
        % stim data
        stim = Stim.data;
        
        % current data
        sing = Sing.data;
        %%
        % deal with rereferencing
        
        if reref
            rerefChans = data(:,[71 72 73 74 75 76 77 78 79 85 86 87 88 89 90 4 18]);
            rerefChans = mean(rerefChans,2);
            data = data - repmat(rerefChans,1,numChans);
        end
        
        %% stimulation voltage monitor
        plotIt = 0;
        savePlot = 0;
        [stim1Epoched,t,fs,labels,uniqueLabels] = voltage_monitor_pos_neg(Stim,Sing,plotIt,savePlot,'','','');
        
        %% extract average signals
        
        [sts,bursts] = get_epoch_indices(sing,fsData,fsSing);
        
        dataEpoched = 1e6.*squeeze(getEpochSignal(data,sts-preSamps,sts+postSamps+1));
        % set the time vector to be set by the pre and post samps
        t = (-preSamps:postSamps)*1e3/fsData;
        
        %% plot epoched signals
        plot_EPs_fromEpochedData(dataEpoched,t,uniqueLabels,labels,stimChans)
        
        %%
        for uniq = uniqueLabels
            %   if uniq >=1500
            if uniq>1000 % if stim level > 1500 uA
                boolLabels = labels==uniq;
                average = 1;
                %chanIntList = 3;
                trainDuration = [];
                modePlot = 'avg';
                xlims = [-10 150];
                ylims = [-0.1 0.1];              
                small_multiples_time_series(1e-6.*dataEpoched(:,:,boolLabels),1e-3*t,'type1',stimChans,'type2',0,'xlims',xlims,'ylims',ylims,'modePlot',modePlot,'highlightRange',trainDuration)
                sgtitle(['File ' num2str(ii) ' current ' num2str(uniq)])
            end
        end
        %%
        if saveIt
            if reref
                save([sid '_EP_' regexprep(num2str(stimChans),'  ','_','emptymatch'),'_reref'],'stim1Epoched','dataEpoched','t','uniqueLabels','labels')
            else
                save([sid '_EP_' regexprep(num2str(stimChans),'  ','_','emptymatch')],'stim1Epoched','dataEpoched','t','uniqueLabels','labels')
            end
        end
        
    end
end
