function [] = plot_ind_fits_3ada8b(dataStruct,fitGlobal,fitBins,saveIt)

OUTPUT_DIR = getenv('output_dir');
masterPlot = figure('units','normalized','outerposition',[0 0 1 1]);

for index = 1:16
    
    subplot(4,4,index)
    plot(dataStruct.meanData{index},'linewidth',2)
    hold on
    plot(fitBins.calc{index}.bestVals,'linewidth',2)
    plot(fitGlobal.calc{index}.bestVals,'linewidth',2)
    title(['subject ' num2str(index)])
    set(gca,'fontsize',18)
end
ylabel('voltage (V)')
legend({'data','binned best fits','global best fits'})

for index = 1:16
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
    SaveFig(OUTPUT_DIR, sprintf('3ada8b_masterPlot_binned_sphere'), 'png', '-r600');
    
        SaveFig(OUTPUT_DIR, sprintf('3ada8b_masterPlot_binned_sphere'), 'eps');

    for index = 1:16
        figure(figSub(index))
        SaveFig(OUTPUT_DIR, sprintf('binGlobal_sphere_compare_3ada8b_%d',index), 'png', '-r600');
        SaveFig(OUTPUT_DIR, sprintf('binGlobal_sphere_compare_3ada8b_%d',index), 'eps');
    end
end

end