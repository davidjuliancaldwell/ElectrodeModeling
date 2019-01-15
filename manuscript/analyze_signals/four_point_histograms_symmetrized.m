function histStruct = four_point_histograms_symmetrized(subStruct,plotIt,saveIt)

jLength = size(subStruct.gridDataLRUDavgShrunk,1);
kLength = size(subStruct.gridDataLRUDavgShrunk,2);
numChans = jLength*kLength;

data = subStruct.gridDataLRUDavgShrunk;
stimChansIndices = subStruct.stimChansIndicesShrunk;

rho1 = four_point_histogram_calculation(stimChansIndices(1),stimChansIndices(2),...
    stimChansIndices(3),stimChansIndices(4),1,jLength,kLength,data);
rho1 = rho1(~isnan(rho1) & ~isinf(rho1));

histStruct.mean = mean(rho1(:));
histStruct.std = std(rho1(:));
histStruct.median = median(rho1(:));
histStruct.vals = rho1;

rho1_hist_vec_sym = rho1;

%%
if plotIt
    bins = [0:0.1:10];
    figure;
    histogram(rho1,bins,'normalization','pdf');
    set(gca,'fontsize',14)
    title(['Average data'])
    xlim([0 10])
    xlabel(['\rho_{apparent}'])
    ylabel('count')
    if saveIt
    end
end

end

