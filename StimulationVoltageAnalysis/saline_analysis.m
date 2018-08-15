close all;clear all;clc
Z_Constants_Resistivity
SALINE_DATA = 'G:\My Drive\GRIDLabDavidShared\stripTest\stripTest';

% Also, please see attached for what I believe are the stimulation notes from that saline strip testing day, which explain each trial. Strip test 5 is a working 500 uA trial, Strip Test 6 is a working 50 uA trial. There are others in there too. 
% 
% The data files (only 30 mb or so!), have the data of interest in structures.
% 
% Sing.data(:,1) - this is the current that the TDT was set to deliver
% Stim.data(:,1) - this is the voltage monitored by the TDT for  the output
% Stim.info.SamplingRateHz - this will tell you the sampling rate at which the stimulation monitor output box was being recorded. The same variable will give you that information for any other structure component as well. 
% Wave.data(:,1) - this would be the ECoG recordings from channel 1 on the strip 
%% - 500 uA trial
load(fullfile(SALINE_DATA, ['stripTest-5.mat']));

plotIt = 1;
savePlot = 1;
[stim1Epoched_500uA,t,fs] = voltage_monitor(Stim,Sing,plotIt,savePlot,'500 \muA Voltage Output',OUTPUT_DIR,'500uA_saline');
%stimChan_calculate(stim1Epoched_500uA,fs)

%% - 50 uA trial 
load(fullfile(SALINE_DATA, ['stripTest-6.mat']));
plotIt = 1;
savePlot = 1;
[stim1Epoched_50uA,t,fs] = voltage_monitor(Stim,Sing,plotIt,savePlot,'50 \muA Voltage Output',OUTPUT_DIR,'50uA_saline');
