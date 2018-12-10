%% 10-24-2016 - Quick DBS stim extraction - David Caldwell - script to look at stim spacing
% requires getEpochSignal.m , subtitle.m , numSubplots.m , vline.m
% djc - 2/8/2018 for 5e0cf
% 7.12.2018
% David.J.Caldwell
%% initialize output and meta dir
% clear workspace
close all; clear all; clc
SIDS = {'5e0cf','b26b7','80301','3972f','46c2'};
OUTPUT_DIR = pwd;

%%

% load in the datafile of interest!
% have to have a value assigned to the file to have it wait to finish
% loading...mathworks bug
sid = SIDS{4};
[structureData,filepath] = promptForTDTrecording;
Sing = structureData.Sing;
Stim = structureData.Stim;
DBSs = structureData.DBSs;
ECOG = structureData.ECOG;

filenameCell = strsplit(filepath,'\');
fileNameMat = strsplit(filenameCell{end},'.');
fileName = fileNameMat{1};

dbsElectrodes = DBSs.data;
ECOGelectrodes = ECOG.data;

switch sid
    case '5e0cf'
        dbsElectrodes = dbsElectrodes(:,1:4);
        ECOGelectrodes = ECOGelectrodes(:,1:8);
    case 'b26b7'
        dbsElectrodes = dbsElectrodes(:,1:8);
        ECOGelectrodes = ECOGelectrodes(:,1:8);
    case '80301'
    case '3972f'
        dbsElectrodes = [];
        ECOGelectrodes = ECOGelectrodes(:,1:8);
    case '46c2a'
        dbsElectrodes = [];
        ECOGelectrodes = ECOGelectrodes(:,1:8);
end

ecogFs = ECOG.info.SamplingRateHz;
dbsFs = DBSs.info.SamplingRateHz;

stimBox = Stim.data;
stimFs = Stim.info.SamplingRateHz;

stimProgrammed = Sing.data;

%%
% ui box for input for stimulation channels
prompt = {'how many channels did we record from? e.g 8 ', 'what were the stimulation channels? e.g 7 8 ', 'how long before each stimulation do you want to look? in ms e.g. 1', 'how long after each stimulation do you want to look? in ms e.g 5','process data to remove z>3 outliers?','subtract mean if DC coupled?','bad channels?','save plots?'};
dlgTitle = 'StimChans';
numLines = 1;
defaultans = {'8','5 6','1','5','n','n','','y'};
answer = inputdlg(prompt,dlgTitle,numLines,defaultans);
numChans = str2num(answer{1});
chans = str2num(answer{2});
preTime = str2num(answer{3});
postTime = str2num(answer{4});
zScoreThresh = answer{5};
meanSubtract = answer{6};
savePlot = answer{8};
badChans = str2num(answer{7});

%%
% first and second stimulation channel
stim1 = chans(1);
stim2 = chans(2);
stimChans = [stim1 stim2];
elecVec = [1:numChans];
badChans = [stimChans badChans];

% get sampling rates
fsData = DBSs.info.SamplingRateHz;
fsStim = Stim.info.SamplingRateHz;

data = [ECOGelectrodes,dbsElectrodes, ];

data = data(:,1:8);

if strcmp(meanSubtract,'y')
    data = data-repmat(mean(data,1), [size(data, 1), 1]);
end


%%
plotIt = 1;
savePlot = 0;
[stim1Epoched,t,fsStim,labels,pulseWidths,uniqueLabels,uniquePulseWidths,uniquePulseWidthLabels] = voltage_monitor_different_width(Stim,Sing,plotIt,savePlot,'','','');

%% find out which each of the programmed stimuli actually were set to be delivered
[sts,bursts] = get_epoch_indices(Sing.data,fsData,fsStim);


%% get the data epochs

dataEpoched = squeeze(getEpochSignal(data,sts-presamps,sts+postsamps+1));

% set the time vector to be set by the pre and post samps
t = (-presamps:postsamps)*1e3/fsData;

% get rid of bad channels
chansVec_goods = ones(numChans,1);
chansVec_goods(badChans) = 0;
dataEpoched(:,~chansVec_goods,:) = nan;


%% make the decision to scale it

% ui box for input
prompt = {'scale the y axis to the maximum stim pulse value? "y" or "n" '};
dlgTitle = 'Scale';
numLines = 1;
defaultans = {'n'};
answer = inputdlg(prompt,dlgTitle,numLines,defaultans);
scaling = answer{1};

if strcmp(scaling,'y')
    maxVal = max(dataEpoched(:));
    minVal = min(dataEpoched(:));
end


%% plot individual trials for each condition on a different graph

labels = max(singEpoched);

%%%%%%%%%%%%%%%%%%%% for stim param 12 at first pass
%labels = labels(sts<6e6);
%%%%%%%%%%%%%%%%%%%%

uniqueLabels = unique(labels);

% intialize counter for plotting
k = 1;

% make vector of stim channels
% determine number of subplot
subPlots = numSubplots(numChans);
p = subPlots(1);
q = subPlots(2);

% plot each condition separately e.g. 1000 uA, 2000 uA, and so on

for i=uniqueLabels
    figure('units','normalized','outerposition',[0 0 1 1]);
    dataInterest = dataEpoched(:,:,labels==i);
    for j = 1:numChans
        subplot(p,q,j);
        plot(t,squeeze(dataInterest(:,j,:)));
        xlim([min(t) max(t)]);
        
        % change y axis scaling if necessary
        if strcmp(scaling,'y')
            ylim([minVal maxVal]);
        end
        
        % put a box around the stimulation channels of interest if need be
        if ismember(j,stimChans)
            ax = gca;
            ax.Box = 'on';
            ax.XColor = 'red';
            ax.YColor = 'red';
            ax.LineWidth = 2;
            title(num2str(j),'color','red');
            
        else
            title(num2str(j));
            
        end
        vline(0);
        
    end
    
    % label axis
    xlabel('time in ms');
    ylabel('voltage in \muV');
    %subtitle(['Individual traces - Current set to ',num2str(uniqueLabels(k)),' \muA']);
    % subtitle(['Individual traces - Voltage set to ',num2str(uniqueLabels(k)),' V']);
    
    % get cell of raw values, can use this to analyze later
    dataEpochedCell{k} = dataInterest;
    
    % get averages to plot against each for later
    % cell function, can use this to analyze later
    dataAvgs{k} = mean(dataInterest,3);
    %increment counter
    k = k + 1;
    
    if savePlot
        SaveFig(OUTPUT_DIR,['stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_' 'individualRecordings']);
    end
    
end

%% plot averages for 3 conditions on the same graph

k = 1;
figure('units','normalized','outerposition',[0 0 1 1]);
for k = 1:length(dataAvgs)
    
    tempData = dataAvgs{k};
    
    for j = 1:numChans
        s = subplot(p,q,j);
        plot(t,squeeze(tempData(:,j)),'linewidth',2);
        hold on;
        xlim([min(t) max(t)]);
        
        
        % change y axis scaling if necessary
        if strcmp(scaling,'y')
            ylim([minVal maxVal]);
        end
        
        
        if ismember(j,stimChans)
            ax = gca;
            ax.Box = 'on';
            ax.XColor = 'red';
            ax.YColor = 'red';
            ax.LineWidth = 2;
            title(num2str(j),'color','red')
            
        else
            title(num2str(j));
            
        end
        
        vline(0);
        
    end
    gcf;
end
xlabel('time in ms');
ylabel('voltage in \muV');
%subtitle(['Averages for all conditions']);
legLabels = {[num2str(uniqueLabels(1))]};

k = 2;
if length(uniqueLabels>1)
    for i = uniqueLabels(2:end)
        legLabels{end+1} = [num2str(uniqueLabels(k))];
        k = k+1;
    end
    
end

legend(s,legLabels);


if savePlot
    SaveFig(OUTPUT_DIR,['stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_' 'averageRecordings']);
end

%% histograms
elecVec = [1:size(dataEpoched,2)];
middlePts1st = squeeze(dataEpoched(83,:,:));
middlePts2nd = squeeze(dataEpoched(139,:,:));

mean1st = abs(mean(middlePts1st,2));
mean2nd = abs(mean(middlePts2nd,2));
std1st = std(middlePts1st,[],2);
std2nd = std(middlePts2nd,[],2);

figure
hold on
errorbar(elecVec,mean1st,std1st,'o')
errorbar(elecVec,mean2nd,std2nd,'o')
xlabel('Electrode')
ylabel('\muV')
title(['Mean and std for middle of recorded pulses - stim chans ' num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
%vline(9,'k')
vline(stimChans(1),'g')
vline(stimChans(2),'b')
legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
%%
if savePlot
    SaveFig(OUTPUT_DIR,['stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_' 'meanStd']);
end

%% save it - djc 2/8/2018
saveData = 1;
if saveData
    OUTPUT_DIR = pwd;
    fs = fsData;
    save(sprintf(['stimSpacingDBS-%s-stim_%d-%d'], sid, stimChans(1),stimChans(2)),...
        'dataEpoched','dataEpochedCell','stimChans','t','singEpoched',...
        'stim1Epoched','middlePts1st','middlePts2nd','fsData','fsStim','uniquePulseWidthLabels');
end