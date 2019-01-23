function [] = plot_ind_fits(dataStruct,fitGlobal,fitBins,saveIt)

OUTPUT_DIR = getenv('output_dir');
masterPlot = figure('units','normalized','outerposition',[0 0 1 1]);

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
    figSub(index) = figure('units','normalized','outerposition',[0 0 1 1]);
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
    figure(masterPlot)
    SaveFig(OUTPUT_DIR, sprintf('masterPlot_binned_compare'), 'png', '-r600');
    
    
    for index = 1:7
        figure(figSub(index))
            SaveFig(OUTPUT_DIR, sprintf('binGlobal_compare_subject_%d',index), 'png', '-r600');

    end
end

end