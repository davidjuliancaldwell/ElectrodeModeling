
%% resistivity analysis for all subjects
%
% David.J.Caldwell 11.23.2018
%close all;clear all;clc

plotIt = 1;
saveIt = 0;
shrinkStruct = 1;
eliminateBadChannels = 0;
loadLarry = 1;

%% load in the data and define common constants, run single subject fits
[subStruct] = prepare_data_single_subj(eliminateBadChannels);

%% fit the individual subject data with one rhoA and coordinates
fitIndGlobalCoords = fit_individual_global_coords(subStruct);

%% fit the individual subject data with rhoA for different bins using coordinates
fitIndBinsCoords = fit_individual_coords(subStruct,plotIt,saveIt);


%% fit the individual subject data with one rhoA and spherical

fitIndGlobalCoordsSphereCart = fit_individual_global_coords_spherical(subStruct);
 %%
fitIndGlobalCoordsSphere = fit_individual_global_coords_spherical_sphereCoords(subStruct);

%% 
fitIndGlobalRushDriscoll = fit_individual_global_coords_RushDriscoll(subStruct);


%% fit the individual subject data with rhoA for different bins using coordinates
fitIndBinsCoordsSphere = fit_individual_coords_spherical(subStruct,plotIt,saveIt);

%%
plot_ind_fits(subStruct,fitIndGlobalCoords,fitIndBinsCoords,saveIt)
%%
plot_ind_fits(subStruct,fitIndGlobalCoordsSphereCart,fitIndBinsCoordsSphere,saveIt)

%%
plot_ind_fits_sphereCompare(subStruct,fitIndGlobalCoords,fitIndGlobalCoordsSphereCart,saveIt)
%%
plot_ind_fits_sphereCompare(subStruct,fitIndBinsCoords,fitIndBinsCoordsSphere,saveIt)
