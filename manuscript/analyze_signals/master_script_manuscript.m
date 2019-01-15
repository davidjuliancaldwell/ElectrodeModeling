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

%% symmetry
symmetryStruct = symmetrize_data(subStruct,plotIt,saveIt);

%% shrink symmetric structure

if shrinkStruct
    symmetryStruct = shrink_symmetry(symmetryStruct);
end

if loadLarry
    load('G:\My Drive\FilesForAndFromLarry\1-9-2019-data\jan9\collapseDatasets.mat')
    dUDLR = rot90(symmetryStruct.gridDataLRUDavgShrunk,-1);
    dUD = rot90(symmetryStruct.gridDataLRavgShrunk,-1);
    figure
    plot(UDLR(:),'linewidth',2)
    hold on
    plot(dUDLR(:),'linewidth',2)
    legend({'Larry','David'})
    title('LRUD')
    
    figure
        figure
    plot(UD2(:),'linewidth',2)
    hold on
    plot(dUD(:),'linewidth',2)
    legend({'Larry','David'})
    title('UD')
end



%% 4 point histograms for the individual
histStruct = four_point_histograms_individual(subStruct,plotIt,saveIt);

%% 4 point histograms using the CT coordinates
histStructCoords = four_point_histograms_individual_coords(subStruct,plotIt,saveIt);

%% fit the individual subject data with one rhoA
fitIndGlobal = fit_individual_global(subStruct);

%% fit the individual subject data with one rhoA and coordinates
fitIndGlobalCoords = fit_individual_global_coords(subStruct);

%% fit the individual subject data with rhoA for different bins
fitIndBins = fit_individual(subStruct,plotIt,saveIt);

%% fit the individual subject data with rhoA for different bins using coordinates
fitIndBinsCoords = fit_individual_coords(subStruct,plotIt,saveIt);

%% plot the binned fits, original data, and global fit for each subject
plot_ind_fits(subStruct,fitIndGlobal,fitIndBins,saveIt)

plot_ind_fits(subStruct,fitIndGlobalCoords,fitIndBinsCoords,saveIt)

plot_ind_fits_subjects_grouped

%% 4 point histograms for the symmetrized data
histStructSym = four_point_histograms_symmetrized(symmetryStruct,plotIt,saveIt);

%% fit the averaged data (defined as dataInt above) with one rhoA
fitSymGlobal = fit_symmetrized_global(symmetryStruct);

%% fit the averaged data (defined as dataInt above) with rhoA by bins
fitSymBins = fit_symmetrized(symmetryStruct,plotIt,saveIt);

%% plot the binned fits, original data, and global fit for total
plot_symm_fits(symmetryStruct,fitSymGlobal,fitSymBins,saveIt)

%% fitlm on waveforms to get idea of slope/capacitance
%voltageSlopeStruct = fit_slope_recorded_voltage(subStruct,plotIt,saveIt);

