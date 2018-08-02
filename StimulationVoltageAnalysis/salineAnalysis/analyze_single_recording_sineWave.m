%%
% script to quickly analyze recorded stimulation from saline stimulation
% briefly, it takes output from the "stimGeometry" TDT project, and
% generates plots and extracts the peak voltages in the waveforms
%
%
% David.J.Caldwell - 6-14-2018
% requires getEpochSignal.m , subtitle.m , numSubplots.m , vline.m
% GRAPHICS SHOULD WORK FOR BEFORE MATLAB 2014b

%% initialize output and meta dir
% clear workspace, get rid of extraneous information
close all; clear all; clc

% load in the datafile of interest!
% have to have a value assigned to the file to have it wait to finish
% loading...mathworks bug

structureData = uiimport('-file');
%%
data = [structureData.ECO1.data structureData.ECO2.data(:,1:31)];
fsData = structureData.ECO1.info.SamplingRateHz;
Sing = structureData.Sing;
Stim = structureData.Stim;

clearvars structureData

%%
% ui box for input for stimulation channels
prompt = {'how many channels did we record from? e.g 64 ', 'what were the stimulation channels? e.g 28 29 ', 'how long before each stimulation do you want to look? in ms e.g. 1', 'how long after each stimulation do you want to look? in ms e.g 5'};
dlgTitle = 'StimChans';
numLines = 1;
defaultans = {'64','28 29','1','1000'};
answer = inputdlg(prompt,dlgTitle,numLines,defaultans);
numChans = str2num(answer{1});
stimChans = str2num(answer{2});
preTime = str2num(answer{3});
postTime = str2num(answer{4});
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
        rerefChans = data(:,65:67);
        rerefChans = mean(rerefChans,2);
        data = data - repmat(rerefChans,1,numChans);
    end
    
    
    %% stimulation voltage monitor
    plotIt = 0;
    savePlot = 0;
    [stim1Epoched,t,fs,labels,uniqueLabels] = voltage_monitor(Stim,Sing,plotIt,savePlot,'','','');
    
    %% extract average signals
    
    [sts,bursts] = get_epoch_indices(sing,fsData,fsSing);
    
    dataEpoched = squeeze(getEpochSignal(data,sts-preSamps,sts+postSamps+1));
    % set the time vector to be set by the pre and post samps
    t = (-preSamps:postSamps)*1e3/fsData;
    
    %% plot epoched signals
    scaling = 'y';
    plot_unique_epochs(dataEpoched,t,uniqueLabels,labels,stimChans,scaling)
    
    
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
    %%
    saveIt = 0;
    if saveIt
        if reref
            save(['salineAnalysis_sineWave_' regexprep(num2str(stimChans),'  ','_','emptymatch'),'_reref'],'meanMatAll','stdMatAll','stim1Epoched','dataEpoched','t','uniqueLabels')
        else
            save(['salineAnalysis_sineWave' regexprep(num2str(stimChans),'  ','_','emptymatch')],'meanMatAll','stdMatAll','stim1Epoched','dataEpoched','t','uniqueLabels')
            
        end
    end
end

