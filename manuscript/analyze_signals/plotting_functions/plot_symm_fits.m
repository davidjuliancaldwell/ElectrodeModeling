function [] = plot_symm_fits(dataStruct,fitGlobal,fitBins,saveIt)

figure

conditionsInt = {'Avg','LRavg','UDavg','LRUDavg'};
counter = 1;

for conditionsIntSelect = conditionsInt
    conditionsIntSelect = conditionsIntSelect{:};
    dataInt = eval(['subStruct.gridData' conditionsIntSelect 'Shrunk']);
    
    subplot(2,2,counter)
    dataIntLRUD = dataStruct.gridDataLRUDavgShrunk;
    dataIntLRUD = dataIntLRUD(:);
    
    plot(dataInt,'linewidth',2)
    hold on
    plot(fitBins.bestVals,'linewidth',2)
    plot(fitGlobal.bestVals,'linewidth',2)
    title('Symmetrized Data')
    set(gca,'fontsize',18)
    
end

ylabel('V/I')
legend({'data','binned best fits','global best fits'})

if saveIt
end

end