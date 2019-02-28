%%
close all;clear all;clc
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


figure
hold on
for ii = 1:length(vJumpCell)
    plot(vJumpCell{ii})
end
legend(num2str([1:7]'));
CT = cbrewer('qual','dark2',7);
colormap(CT)
xlabel('Trial')
ylabel('Voltage (V)')
set(gca,'fontsize',18)
title('Concatenated Jump Voltages for all Subjects')

figure
correction = 0.98;
dividedVI = vJumpAvgMat./currentMatVec;
twoPointR = (2*.00115*dividedVI/(correction));

subplot(1,3,1)
plot(vJumpAvgMat)
xlabel('Subject')
ylabel('Voltage (V)')
set(gca,'fontsize',14)
title('Mean Jump Voltages')

subplot(1,3,2)
plot(dividedVI)
xlabel('Subject')
ylabel('Resistance (ohms)')
set(gca,'fontsize',14)
title('Jump Voltage/Applied Current')

subplot(1,3,3)
plot(twoPointR)
xlabel('Subject')
title('Resistivities')
ylabel('Resistivity (ohm-m)')
set(gca,'fontsize',14)

