%% resistivity analysis for all subjects
%
% David.J.Caldwell 11.23.2018
close all;clear all;clc

plotIt = 1;
saveIt = 0;

%% load in the data and define common constants, run single subject fits
[subStruct] = prepare_data_single_subj();

%% symmetry
symmetryStruct = symmetrize_data(subStruct,plotIt,saveIt);


%% 4 point histograms for the individual
histStruct = four_point_histograms_individual(subStruct,plotIt,saveIt);

%% 4 point histograms using the CT coordinates
histStructCoords = four_point_histograms_individual_coords(subStruct,plotIt,saveIt);

%% fit the individual subject data with one rhoA
fitIndGlobal = fit_individual_global(subStruct);

%% fit the individual subject data with rhoA for different bins
fitIndBins = fit_individual(subStruct,plotIt,saveIt);

%% if plotit
if plotIt
    
    figure
    
    for index = 1:numIndices
        
        subplot(2,4,index)
        plot(dataSelect(:,index),'linewidth',2)
        hold on
        plot(fitValsVec(:,index),'linewidth',2)
        plot(bestVals(:,index),'linewidth',2)
        title(['subject ' num2str(index)])
        set(gca,'fontsize',18)
    end
    ylabel('voltage (V)')
    legend({'data','binned best fits','global best fits'})
    
end

%% 4 point histograms for the symmetrized data

histStructSym = four_point_histograms_symmetrized(symmetryStruct,plotIt,saveIt);
%% fit the averaged data (defined as dataInt above) with one rhoA
fitSymGlobal = fit_symmetrized_global(symmetryStruct,plotIt,saveIt);

%% fit the averaged data (defined as dataInt above) with rhoA by bins
fitSymBins = fit_symmetrized(symmetryStruct,plotIt,saveIt);

%% fitlm on waveforms to get idea of slope/capacitance

voltageSlopeStruct = fit_slope_recorded_voltage(subStruct,plotIt,saveIt);

