
%% resistivity analysis for all subjects
%
% David.J.Caldwell 11.23.2018
%close all;clear all;clc

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
%%
figure
for index = 1:7
    subplot(2,1,1)
    hold on
    plot(subStruct.CTlocsSpherical{index}(:,3))
    ylim([40 85])
    title('CT')
    subplot(2,1,2)
    hold on
    plot(subStruct.MNIlocsSpherical{index}(:,3))
    title('MNI')
    ylim([40 95])
    xlabel('electrode')
    
end
legend({'1','2','3','4','5','6','7'})

%% fit the individual subject data with one rhoA and coordinates
fitIndGlobalCoords = fit_individual_global_coords(subStruct);

%% fit the individual subject data with rhoA for different bins using coordinates
fitIndBinsCoords = fit_individual_coords(subStruct,plotIt,saveIt);


%% fit the individual subject data with one rhoA and spherical

fitIndGlobalCoordsSphereCart = fit_individual_global_coords_spherical(subStruct);
%%
fitIndGlobalCoordsSphere = fit_individual_global_coords_spherical_sphereCoords(subStruct);

%%
%fitIndGlobalRushDriscoll = fit_individual_global_coords_RushDriscoll(subStruct);


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

