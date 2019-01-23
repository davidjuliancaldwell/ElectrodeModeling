function [] = plot_ind_fits(dataStruct,fitGlobal,fitBins,saveIt)

figure

for index = 1:7
    
    subplot(2,4,index)
    plot(dataStruct.meanData{index},'linewidth',2)
    hold on
    plot(fitBins.calc{index}.bestVals,'linewidth',2)
    plot(fitGlobal.calc{index}.bestVals,'linewidth',2)
    title(['subject ' num2str(index)])
    set(gca,'fontsize',18)
end
ylabel('voltage (V)')
legend({'data','binned best fits','global best fits'})

for index = 1:7
    figure
    plot(dataStruct.meanData{index},'linewidth',2)
    hold on
    plot(fitBins.calc{index}.bestVals,'linewidth',2)
    plot(fitGlobal.calc{index}.bestVals,'linewidth',2)
    title(['subject ' num2str(index)])
    set(gca,'fontsize',18)
    ylabel('voltage (V)')
    legend({'data','binned best fits','global best fits'})
end
if saveIt
end

end