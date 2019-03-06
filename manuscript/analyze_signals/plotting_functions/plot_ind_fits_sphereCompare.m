function [] = plot_ind_fits_sphereCompare(dataStruct,fitFlat,fitSphere,saveIt)

OUTPUT_DIR = getenv('output_dir');
masterPlot = figure('units','inches','position',[1 1 8 6]);

for index = 1:7
    
    subplot(2,4,index)
    plot(dataStruct.meanData{index},'linewidth',2)
    hold on
    plot(fitSphere.calc{index}.bestVals,'linewidth',2)
    plot(fitFlat.calc{index}.bestVals,'linewidth',2)
    title(['subject ' num2str(index)])
    set(gca,'fontsize',8)
end
ylabel('Voltage (V)')
xlabel('Electrode')
legend({'Data','Spherical Model','Flat Model'})

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