%% setup workspace
close all;clear all;clc

Z_Constants_Resistivity
cd(fileparts(which('stimWaveform_analysis_master_script')));
locationsDir = pwd;

%% global parameters
preSamps = 3; % for voltage extaction algorithm
postSamps = 3; % for voltage extraction algorithm
plotIt = 0; % plot and save plots
preExtract = 1; % how many ms before for extracting
postExtract = 10; % how many ms after stim to extract

% have processed off mean before below! 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ECoG BELOW HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subj_first_7_waveform

%%
saveIt = 0;
if saveIt
    Folder = fullfile(locationsDir, '..','..','data');
    save(fullfile(Folder, 'recorded_voltages_onlyProcessed.mat'),'first_7_struct','-v7.3')
end