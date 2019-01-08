function [] = plot_symm_fits(dataStruct,fitGlobal,fitBins,saveIt)

figure

dataInt = dataStruct.gridDataLRUDavg;
dataInt = dataInt(:);

plot(dataInt,'linewidth',2)
hold on
plot(fitBins.bestVals,'linewidth',2)
plot(fitGlobal.bestVals,'linewidth',2)
title('Symmetrized Data')
set(gca,'fontsize',18)
ylabel('voltage (V)')
legend({'data','binned best fits','global best fits'})

if saveIt
end

end