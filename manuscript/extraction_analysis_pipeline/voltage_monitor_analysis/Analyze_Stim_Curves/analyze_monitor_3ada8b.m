%%
close all;clear all;clc
Z_Constants_Resistivity
currentMatVec = repmat(5e-4,1,16);

plotIt = 0;
savePlot = 0;
saveData = 1;
%% now go through 3ada8b

% vector to loop through
stimChansVec = [
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

preSamps = 3;
postSamps = 3;
figTotal =  figure('units','Inches','outerposition',[1 1 8 10]);

numStimChans = size(stimChansVec,1);
numCurrents = size(currentMatVec,2);

ii = 1;

vJumpMat = [];
vJumpCell = {};
vJumpAvgMat = [];
for stimChans = stimChansVec'
    
    fprintf(['running for 3ada8b stim chans ' num2str(stimChans(1)) '\n']);
    load(fullfile('G:\My Drive\CDrive-Output-Pistachio\stimSpacing\outputData', ['3ada8b_' num2str(stimChans(1)) '_' num2str(stimChans(2))]),'dataEpoched','t','stimEpoched','fsData');
    
    % convert t back to ms
    t = t/1e3;
    if ii == 1
        stimEpoched = stimEpoched(:,3:end);
    end
    
    fs = fsData;
    
        [vJumpAvg,vJumpInd] = stimChan_calculate_jumpR(stimEpoched,fs);
    vJumpMat = [vJumpMat vJumpInd];
    vJumpCell{ii} = vJumpInd;
    vJumpAvgMat = [vJumpAvgMat vJumpAvg];
    
    ii = ii + 1;
 
end

%%
figure
plot(vJumpMat)
xlabel('Trial')
ylabel('Voltage (V)')
set(gca,'fontsize',14)
title('Concatenated Jump Voltages for all Subjects')

%correction = 0.98;
correction = 1;

figJump = figure;
figJump.Units = "inches";
figJump.Position = [0.5 0.5 8 4];
hold on
for ii = 1:length(vJumpCell)
    plot(vJumpCell{ii})
    dividedVICell{ii} = vJumpCell{ii}/currentMatVec(ii);
    twoPointRCell{ii} = 2*.00115*dividedVICell{ii}/(correction);
    stdVJump(ii) = std(vJumpCell{ii});
end
legend(num2str([1:7]'));
CT = cbrewer('qual','dark2',7);
colormap(CT)
%ylim([0 max([vJumpCell{:}])+0.5])
xlabel('Trial')
ylabel('Voltage (V)')
set(gca,'fontsize',18)
title('Concatenated Jump Voltages for all Subjects')
%%
figCombined = figure;
figCombined.Units = "inches";
figCombined.Position = [0.5 0.5 8.5 4];

dividedVI = vJumpAvgMat./currentMatVec;
twoPointR = (2*.00115*dividedVI/(correction));

subplot(1,3,1)
% y = num2cell(1:numel(vJumpCell));
% x = cellfun(@(x, y) [x(:) y*ones(size(x(:)))],vJumpCell, y, 'UniformOutput', 0); % adding labels to the cells
% X = vertcat(x{:});
%boxplot(X(:,1), X(:,2),'PlotStyle','compact','widths',0.1,'outliersize',2)
%plot(vJumpAvgMat)
x= [1:16];
errorbar(x,vJumpAvgMat,stdVJump,'linewidth',2)
xlabel('Electrode Pair')
ylabel('Voltage (V)')
set(gca,'fontsize',12)
%title({'Mean Jump Voltages +/-','Standard Deviation'})
xticks([1:2:16])
ylim([0 max(vJumpAvgMat)+0.5])
xlim([0 16])

subplot(1,3,2)
plot(dividedVI,'linewidth',2)
% y = num2cell(1:numel(dividedVICell));
% x = cellfun(@(x, y) [x(:) y*ones(size(x(:)))], dividedVICell, y, 'UniformOutput', 0); % adding labels to the cells
% X = vertcat(x{:});
%boxplot(X(:,1), X(:,2),'PlotStyle','compact')
xlabel('Electrode Pair')
ylabel('Resistance (ohms)')
set(gca,'fontsize',12)
%title('Jump Voltage/Applied Current')
xticks([1:2:16])
ylim([0 max(dividedVI)+200])
xlim([0 16])

subplot(1,3,3)
plot(twoPointR,'linewidth',2)
% y = num2cell(1:numel(twoPointRCell));
% x = cellfun(@(x, y) [x(:) y*ones(size(x(:)))], twoPointRCell, y, 'UniformOutput', 0); % adding labels to the cells
% X = vertcat(x{:});
% boxplot(X(:,1), X(:,2),'PlotStyle','compact')
xlabel('Electrode Pair')
%title('Resistivities')
ylabel('Resistivity (ohm-m)')
set(gca,'fontsize',12)
xticks([1:2:16])
ylim([0 max(twoPointR)+0.5])
xlim([0 16])

