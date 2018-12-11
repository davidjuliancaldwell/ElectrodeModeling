%% resistivity analysis for all subjects 
%
% David.J.Caldwell 11.23.2018
%close all;clear all;clc

cd(fileparts(which('prepare_data_single_subj')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','data');
folderCoords = fullfile(locationsDir,'..','coordinates');

totalData = load(fullfile(folderData,'recorded_voltages.mat'));

plotIt = 1;
saveIt = 0;
%% define additional grid electrode locations just for first 7
prepare_electrode_mapping

%% load in the data and define common constants, run single subject fits
prepare_data_single_subj

%% prepare data for symmetry
prepare_data_symmetry

%% symmetrize the data
symmetrize_data

%% fit the individual subject data with one rhoA 

fit_individual_global

%% fit the individual subject data with rhoA for different bins
fit_individual

%% 4 point histograms for the symmetrized data

%%%%%%%%%%%%%%%%%% which symmetrized data to use? %%%%%%%%%%%%%%%%%%%%%%%%%
dataInt = gridDataAvg; % this just selects the averaged data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

four_point_histograms_symmetrized 
%% fit the averaged data (defined as dataInt above) with one rhoA
fit_symmetrized_global 

%% fit the averaged data (defined as dataInt above) with rhoA by bins
fit_symmetrized

 