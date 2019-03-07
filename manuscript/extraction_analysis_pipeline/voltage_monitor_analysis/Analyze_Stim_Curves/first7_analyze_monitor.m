%%
%close all;clear all;clc
Z_Constants_Resistivity
currentMatVec = [0.00175 0.00075 0.0035 0.00075 0.003 0.0025 0.00175];

plotIt = 0;
savePlot = 0;
saveData = 1;
discardBads = 1;

DATA_DIR = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\ECoG_Subjects\Voltage_Monitor\raw_stimMonitor';

vJumpMat = [];
vJumpCell = {};
vJumpAvgMat = [];
for ii = 1:length(SIDS)
    sid = SIDS{ii};
    
    load(fullfile(DATA_DIR, [sid '_stimOutput.mat']));
    
    [vJumpAvg,vJumpInd] = stimChan_calculate_jumpR(stim_data,fs);
    vJumpMat = [vJumpMat vJumpInd];
    vJumpCell{ii} = vJumpInd;
    vJumpAvgMat = [vJumpAvgMat vJumpAvg];
    
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
ylim([0 max([vJumpCell{:}])+0.5])
xlabel('Trial')
ylabel('Voltage (V)')
set(gca,'fontsize',18)
title('Concatenated Jump Voltages for all Subjects')

figCombined = figure;
figCombined.Units = "inches";
figCombined.Position = [0.5 0.5 10 4];

dividedVI = vJumpAvgMat./currentMatVec;
twoPointR = (2*.00115*dividedVI/(correction));

subplot(1,3,1)
% y = num2cell(1:numel(vJumpCell));
% x = cellfun(@(x, y) [x(:) y*ones(size(x(:)))],vJumpCell, y, 'UniformOutput', 0); % adding labels to the cells
% X = vertcat(x{:});
%boxplot(X(:,1), X(:,2),'PlotStyle','compact','widths',0.1,'outliersize',2)
%plot(vJumpAvgMat)
x= [1:7];
errorbar(x,vJumpAvgMat,stdVJump,'linewidth',2)
xlabel('Subject')
ylabel('Voltage (V)')
set(gca,'fontsize',14)
title({'Mean Jump Voltages +/-','Standard Deviation'})
xticks([1:7])
ylim([0 max(vJumpAvgMat)+0.5])
xlim([0 8])

subplot(1,3,2)
plot(dividedVI,'linewidth',2)
% y = num2cell(1:numel(dividedVICell));
% x = cellfun(@(x, y) [x(:) y*ones(size(x(:)))], dividedVICell, y, 'UniformOutput', 0); % adding labels to the cells
% X = vertcat(x{:});
%boxplot(X(:,1), X(:,2),'PlotStyle','compact')
xlabel('Subject')
ylabel('Resistance (ohms)')
set(gca,'fontsize',14)
title('Jump Voltage/Applied Current')
xticks([1:7])
ylim([0 max(dividedVI)+200])
xlim([0 8])

subplot(1,3,3)
plot(twoPointR,'linewidth',2)
% y = num2cell(1:numel(twoPointRCell));
% x = cellfun(@(x, y) [x(:) y*ones(size(x(:)))], twoPointRCell, y, 'UniformOutput', 0); % adding labels to the cells
% X = vertcat(x{:});
% boxplot(X(:,1), X(:,2),'PlotStyle','compact')
xlabel('Subject')
title('Resistivities')
ylabel('Resistivity (ohm-m)')
set(gca,'fontsize',14)
xticks([1:7])
ylim([0 max(twoPointR)+0.5])
xlim([0 8])

