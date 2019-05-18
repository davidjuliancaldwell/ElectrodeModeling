%% script to analyze extracted epoched stim geometry data for subject 010dcb in particular
% David.J.Caldwell 10.10.2018

close all; clear all; clc % clear workspace, get rid of extraneous information

myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.mat')); %gets all mat files in struct
%
numChans = 100;
stimChans = [];
preTime = 100; % pretime and post time in ms
postTime = 200; % pretime and post time in ms
saveIt = 1; % save plots
sid = '010dcb'; % subject id
stimChansVec = {[11 12],[11 89 90]}; % cell of stimulation channel combinations
dataChanCell = {};
labelsCell = {};
chanInt = 16; % which channel is of interest?

tBegin = 15; % what time to begin looking for EPs (ms)
tEnd = 65; % what time to stop looking for EPs (ms)
rerefMode = 'none';
avgTrials = 0;
numAvg = 3;
smooth = 1;

for ii = [1:2]
    stimChans = stimChansVec{ii};
    baseFileName = myFiles(ii).name;
    myFolder = myFiles(ii).folder;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    load(fullFileName);
    
    %  look at first 20
    dataTemp = dataEpoched(:,chanInt,1:20);
    dataTemp = dataTemp - repmat(mean(dataTemp(t<0,:,:),1),[size(dataTemp,1),1]);
    dataChanCell{ii} = dataTemp;
    
    dataTempCell{1} =  dataTemp;
    
    [signalPP,pkLocs,trLocs] =  extract_PP_peak_to_peak_single_trial(1,dataTempCell,t,...
        [],tBegin,tEnd,rerefMode,[],smooth,avgTrials,numAvg);
    
    signalPPblockST{ii} = signalPP;
    pkLocsBlockST{ii} = pkLocs;
    trLocsBlockST{ii} = trLocs;
    
end
%%
figure
hold on
for ii = [1:2]
    histogram(signalPPblockST{ii}{1}) % plot histograms
end
%
figure
hold on
for ii = [1:2]
    plot(t,mean(squeeze(dataChanCell{ii}),2),'linewidth',2) % plot mean voltage
end
legend({'[4,5]','[4 7 8]','[5 7 8]'});
xlabel('Time (ms)')
ylabel(['Voltage (\mu V)'])
set(gca,'fontsize',14)

%%
totalVec = [];
labelTotal = [];
% build up data structure for MATLAB statistical tests
for ii = 1:2
    pkPk = signalPPblockST{ii}{1};
    totalVec = [totalVec pkPk];
    labelTotal = [labelTotal repmat(ii,[1,size(pkPk,2)])];
end

% kruskal wallis stats
[p,tbl,stats] = kruskalwallis(totalVec,labelTotal);
[c,m,h,gnames] = multcompare(stats)

% anova stats
% [p,tbl,stats] = anova1(totalVec,labelTotal);
% [c,m,h,gnames] = multcompare(stats)


