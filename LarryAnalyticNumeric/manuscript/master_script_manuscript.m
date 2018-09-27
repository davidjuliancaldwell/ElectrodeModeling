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
four_point_histograms_individual

%% 4 point histograms for the symmetrized data
four_point_histograms_symmetrized 

%% fit the individual data
fit_individual_global

%% 
fit_individual

%% fit the combined data
fit_symmetrized_global 



 