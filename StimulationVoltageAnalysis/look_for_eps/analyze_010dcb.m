
% David.J.Caldwell 10.10.2018
%% initialize output and meta dir
% clear workspace, get rid of extraneous information

close all; clear all; clc
myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.mat')); %gets all mat files in struct
%
numChans = 128;
stimChans = [];
preTime = 100;
postTime = 200;
saveIt = 1;
sid = '010dcb';
stimChansVec = {[4,5],[4 7 8],[5 7 8]};

dataChanCell = {};
labelsCell = {};
chanInt = 16;

tBegin = 15;
tEnd = 65;
rerefMode = 'none';
avgTrials = 0;
numAvg = 3;
smooth = 1;

for ii = [1:3]
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
for ii = [1:3]
    histogram(signalPPblockST{ii}{1})
end

%
figure
hold on
for ii = [1:3]
    plot(t,mean(squeeze(dataChanCell{ii}),2),'linewidth',2)
end
legend({'[4,5]','[4 7 8]','[5 7 8]'});
xlabel('Time (ms)')
ylabel(['Voltage (\mu V)'])
set(gca,'fontsize',14)


%%
totalVec = [];
labelTotal = [];
for ii = 1:3
    pkPk = signalPPblockST{ii}{1};
    totalVec = [totalVec pkPk];
    labelTotal = [labelTotal repmat(ii,[1,size(pkPk,2)])];
end

[p,tbl,stats] = kruskalwallis(totalVec,labelTotal);
[c,m,h,gnames] = multcompare(stats)



