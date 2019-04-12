%%
%
% David.J.Caldwell 10.10.2018
%% initialize output and meta dir
% clear workspace, get rid of extraneous information
close all; clear all; clc
saveIt = 0;

% load in the datafile of interest!
% have to have a value assigned to the file to have it wait to finish
% loading...mathworks bug

structureData = uiimport('-file');
%%

if size(structureData.ECO1.data,1) == size(structureData.ECO3.data,1)
    data = 4.*[structureData.ECO1.data structureData.ECO2.data structureData.ECO3.data]; % add in factor of 4 10.10.2018
else
    data = 4.*[structureData.ECO1.data(1:end-1,:) structureData.ECO2.data(1:end-1,:) structureData.ECO3.data]; % add in factor of 4 10.10.2018
    
end

data = data(:,1:99);
dataCopy = data;
data(:,1:16) = dataCopy(:,17:32);
data(:,17:32) = dataCopy(:,1:16);
fsData = structureData.ECO1.info.SamplingRateHz;
Sing = structureData.Sing;
Stim = structureData.Stim;

clearvars structureData

%%
% ui box for input for stimulation channels
prompt = {'how many channels did we record from? e.g 64 ', 'what were the stimulation channels? e.g 28 29 ',...
    'how long before each stimulation do you want to look? in ms e.g. 1',...
    'how long after each stimulation do you want to look? in ms e.g 5',...
    'what is the subject ID?'};
dlgTitle = 'StimChans';
numLines = 1;
defaultans = {'99','21 23 24','1000','1000',''};
answer = inputdlg(prompt,dlgTitle,numLines,defaultans);
numChans = str2num(answer{1});
stimChans = str2num(answer{2});
preTime = str2num(answer{3});
postTime = str2num(answer{4});
sid = answer{5};
preSamps = round(preTime/1000 * fsData); % pre time in sec
postSamps = round(postTime/1000 * fsData); % post time in sec,

%%

for reref = 0:0
    % get sampling rates
    fsStim = Stim.info.SamplingRateHz;
    fsSing = Sing.info.SamplingRateHz;
    
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
        boolLabels = labels==uniq;
        average = 1;
        %chanIntList = 3;
        trainDuration = [];
        modePlot = 'avg';
        xlims = [-10 150];
        ylims = [-1.5 1.5];
        
        small_multiples_time_series(1e-6.*dataEpoched(:,:,boolLabels),1e-3*t,'type1',stimChans,'type2',0,'xlims',xlims,'ylims',ylims,'modePlot',modePlot,'highlightRange',trainDuration)
        
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

