%% resistivity analysis 
%
% David.J.Caldwell 9.26.2018

close all;clear all;clc

%% load in the data and define common constants 
prepare_data
workingDirec = pwd;
plotIt = 1;
saveIt = 0;

%% symmetrize the data
symmetrize_data

%% 4 point histograms for the individual

%%%%%%%%%%%%%%%%%%  upper low cut off for gaussian mixture model %%%%%%%%%%
lowerCut = 2;
upperCut = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

four_point_histograms_individual


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

 