function [] = plot_ind_fits_sphereCompare_bins(dataStruct,fitFlat,fitSphere,saveIt)

OUTPUT_DIR = getenv('output_dir');
masterPlot = figure('units','inches','position',[1 1 8 10]);

for index = 1:7
    
    subplot_total(index) = subplot(4,2,index);
    plot(dataStruct.meanData{index},'linewidth',2);
    hold on
    plot(fitSphere.calc{index}.bestVals,'linewidth',2)
    plot(fitFlat.calc{index}.bestVals,'linewidth',2)
    title(['subject ' num2str(index)],'fontweight','normal')
    
    set(gca,'fontsize',10)
end
ylabel('Voltage (V)')
xlabel('Electrode')
legend({'Data','Spherical Model','Flat Model'})

% annotate plot
arrayfun(@(x) pbaspect(x, [1 1 1]), subplot_total);
drawnow;
pos = arrayfun(@plotboxpos, subplot_total, 'uni', 0);
dim = cellfun(@(x) x.*[1 1 0.5 0.5], pos, 'uni',0);
for i = 1:7
   
    mseFlat  = sprintf('%0.2e',nansum(fitFlat.calc{i}.MSE));
    mseSphere = sprintf('%0.2e',nansum(fitSphere.calc{i}.MSE));
    
    annotation(masterPlot, 'textbox', dim{i}, 'String', {['RMSE_{flat} = ' mseFlat],...
        ['RMSE_{sphere} = ' mseSphere]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
end

for index = 1:7
    figSub(index) = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(dataStruct.meanData{index},'linewidth',2)
    hold on
    plot(fitSphere.calc{index}.bestVals,'linewidth',2)
    plot(fitFlat.calc{index}.bestVals,'linewidth',2)
    title(['subject ' num2str(index)])
    set(gca,'fontsize',18)
    ylabel('voltage (V)')
    legend({'data','spherical model','flat model'})
end

if saveIt
    figure(masterPlot)
    SaveFig(OUTPUT_DIR, sprintf('masterPlot_sphere_flat_compare_binned'), 'png', '-r600');
    
    
    for index = 1:7
        figure(figSub(index))
        SaveFig(OUTPUT_DIR, sprintf('sphere_flat_compare_subject_%d_binned',index), 'png', '-r600');
        
    end
end
end