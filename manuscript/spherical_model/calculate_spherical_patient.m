
%% resistivity analysis for all subjects
%
% David.J.Caldwell 11.23.2018
%close all;clear all;clc

plotIt = 1;
saveIt = 1;
shrinkStruct = 1;
eliminateBadChannels = 0;
getRidOfFullData = 1;

%% load in the data and define common constants, run single subject fits
[subStruct] = prepare_data_single_subj(eliminateBadChannels);

if getRidOfFullData
    % clean up sub struct for saving
    field = {'data','extractCell','stdEveryPoint','meanEveryTrial'};
    subStruct = rmfield(subStruct,field);
end

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


%% 4 point histograms using the CT coordinates
histStructCoords = four_point_histograms_individual_coords(subStruct,plotIt,saveIt);

%%
histStructCoordsSpherical = four_point_histograms_individual_coords_spherical(subStruct,plotIt,saveIt);
%%
compare_four_points(histStructCoords,histStructCoordsSpherical)
%% average E/T, then fit