%% updated 6-15-2018 loop through 3ada8b
%% initialize output and meta dir
% clear workspace
close all; clear all; clc

% set input output working directories
Z_ConstantsStimSpacing;

% subject directory, change as needed
SUB_DIR = fullfile(myGetenv('subject_dir'));

%% load in subject

% this is from my z_constants

sid = SIDS{6};

stimChannels = [
    3 4;
    4 3;
    4 12;
    12 4;
    20 4;
    4 20;
    5 7;
    7 5;
    13 12;
    12 13;
    14 11;
    11 14
    15 10;
    10 15
    16 9;
    9 16;
    ];

% ui box for input for stimulation channels
prompt = {'how many channels did we record from? e.g 48 ',...
    'how long before each stimulation do you want to look? in ms e.g. 1',...
    'how long after each stimulation do you want to look? in ms e.g 5',...
    'how many trials?'};
dlg_title = 'StimChans';
num_lines = 1;
defaultans = {'92','1','5','16'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
numChans = str2num(answer{1});
preTime = str2num(answer{2});
postTime = str2num(answer{3});
numTrials = str2num(answer{4});


for trial = 1:numTrials
    switch sid
        case '3ada8b'
            
            fileInt = strcat('stimGeometry-',num2str(trial),'.mat');
            load(fullfile(SUB_DIR,sid,'data\d10\MATLAB_conversions\3ada8b_stimGeometry',fileInt));
            fsStim = Stim.info.SamplingRateHz;
            stim = Stim.data;
            fsData = ECO1.info.SamplingRateHz;
            preSamps = round(preTime/1000 * fsData); % pre time in sec
            postSamps = round(postTime/1000 * fsData); % post time in sec,
            
            data1= ECO1.data;
            data2= ECO2.data;
            data3= ECO3.data;
            
            fsSing = Sing.info.SamplingRateHz;
            
            sing = Sing.data;
            data = [data1 data2 data3];
            data = data(:,1:numChans,:);
            
    end
    
    stimChans = stimChannels(trial,:);
    %
    sSing = Sing.info.SamplingRateHz;
    
    % stim data
    stim = Stim.data;
    
    % current data
    sing = Sing.data;
    
    % for stim geometry 6, stim pair 3 and 4
    % sing = sing(1:4.5e6,:);
    % stim = stim(1:4.5e6,:);
    % Sing.data = Sing.data(1:4.5e6,:);
    % Stim.data = Stim.data(1:4.5e6,:);
    % data = data(1:(4.5e6/2),:);
    
    
    %% stimulation voltage monitor
    plotIt = 0;
    savePlot = 0;
    [stimEpoched,t,fs,labels,uniqueLabels] = voltage_monitor(Stim,Sing,plotIt,savePlot,'','','');
    
    %% extract average signals
    
    [sts,bursts] = get_epoch_indices(sing,fsData,fsSing);
    
    dataEpoched = squeeze(getEpochSignal(data,sts-preSamps,sts+postSamps+1));
    % set the time vector to be set by the pre and post samps
    t = (-preSamps:postSamps)*1e3/fsData;
    
    %% plot epoched signals
    scaling = 'y';
    %plot_unique_epochs(dataEpoched,t,uniqueLabels,labels,stimChans,scaling)

    %% extract averages, means, and standard deviations
    count = 1;
    
    preSampsExtract = 3;
    postSampsExtract = 3;
    plotIt = 0;

    for i = uniqueLabels
        dataEpochedInt = dataEpoched(:,:,labels==i);
        [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpochedInt,'fs',fsData,'preSamps',preSampsExtract,'postSamps',postSampsExtract,'plotIt',plotIt);
        
        meanMat(stimChans,:) = nan;
        stdMat(stimChans,:) = nan;
        extractCell{stimChans(1)}{1} = nan;
        extractCell{stimChans(1)}{2}= nan;
        extractCell{stimChans(2)}{1}= nan;
        extractCell{stimChans(2)}{2}= nan;
        stdCellEveryPoint{stimChans(1)} = {nan,nan};
        stdCellEveryPoint{stimChans(2)} =  {nan,nan};
        
        meanMatAll(:,:,count) = meanMat;
        stdMatAll(:,:,count) = stdMat;
        numberStimsAll(count) = numberStims;
        stdEveryPoint{count} = stdCellEveryPoint;
        
        
        count = count + 1;
    end
    
    
    %% 2d plot
    
     plot_2d_heatmap(meanMatAll(1:64,:,:),64,uniqueLabels,stimChans)
     saveIt = 1;
     
     if saveIt
     SaveFig(OUTPUT_DIR,[sid '_stimulationChannels_' num2str(stimChans(1)) '_' num2str(stimChans(2))])   
     end
     
    
    
    %%
    saveIt = 1;
    if saveIt
        
        save(fullfile(OUTPUT_DIR, [sid '_' num2str(stimChans(1)) '_' num2str(stimChans(2))]),...
            'dataEpoched','meanMatAll',...
            'stimEpoched','fsStim','fsData','stdMatAll','stimChans','t');
    end
    
    clearvars dataEpoched meanMatAll stimEpoched fsStim fsData stdMatAll stimChans t
end