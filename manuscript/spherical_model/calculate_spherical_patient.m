
%% resistivity analysis for all subjects
%
% David.J.Caldwell 11.23.2018
close all;clear all;clc

plotIt = 0;
saveIt = 0;
eliminateBadChannels = 0;
getRidOfFullData = 0;
prolateBool = 0;

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
fitIndGlobalCoordsSphere = fit_individual_global_coords_spherical(subStruct);

%% fit the individual subject data with rhoA for different bins using coordinates
fitIndBinsCoordsSphere = fit_individual_coords_spherical(subStruct,plotIt,saveIt);

%%
plot_ind_fits(subStruct,fitIndGlobalCoords,fitIndBinsCoords,saveIt)
%%
plot_ind_fits(subStruct,fitIndGlobalCoordsSphere,fitIndBinsCoordsSphere,saveIt)

%%
plot_ind_fits_sphereCompare(subStruct,fitIndGlobalCoords,fitIndGlobalCoordsSphere,saveIt)
%%
plot_ind_fits_sphereCompare_bins(subStruct,fitIndBinsCoords,fitIndBinsCoordsSphere,saveIt)

%%
compare_bins(fitIndBinsCoords,fitIndBinsCoordsSphere)
%% 4 point histograms using the CT coordinates
histStructCoords = four_point_histograms_individual_coords(subStruct,plotIt,saveIt);

%%
histStructCoordsSpherical = four_point_histograms_individual_coords_spherical(subStruct,plotIt,saveIt);
%%
compare_four_points(histStructCoords,histStructCoordsSpherical)
%% average E/T, then fit

fitStruct = fit_all_at_once(subStruct);
%%
fitStructSpherical = fit_all_at_once_spherical(subStruct);

%%
figure
hold on
plot(fitStruct.calc.data,fitStruct.calc.bestVals,'o')
x(1) = min(fitStruct.calc.data);
x(2) = max(fitStruct.calc.data);
%func1 = @(x)((x - fitStruct.calc.offset)/fitStruct.calc.rhoAcalc);
%y = func1(x);
y = x;
plot(x,y);
xlabel('theory')
ylabel('experiment')
set(gca,'fontsize',18)
title('Flat')

figure
plot(fitStruct.calc.data)
hold on
plot(fitStruct.calc.bestVals)
legend({'data','theory'})
set(gca,'fontsize',18)
title('Flat')

figure
hold on
plot(fitStructSpherical.calc.data,fitStructSpherical.calc.bestVals,'o')
x(1) = min(fitStructSpherical.calc.data);
x(2) = max(fitStructSpherical.calc.data);
%func1 = @(x)((x - fitStruct.calc.offset)/fitStruct.calc.rhoAcalc);
%y = func1(x);
y = x;
plot(x,y);
xlabel('theory')
ylabel('experiment')
set(gca,'fontsize',18)
title('Spherical')

figure
plot(fitStruct.calc.data)
hold on
plot(fitStruct.calc.bestVals)
legend({'data','theory'})
title('Spherical')
set(gca,'fontsize',18)

