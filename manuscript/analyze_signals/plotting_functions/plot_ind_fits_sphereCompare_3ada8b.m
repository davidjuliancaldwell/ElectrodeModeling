function [] = plot_ind_fits_sphereCompare_3ada8b(dataStruct,fitFlat,fitSphere,saveIt)

OUTPUT_DIR = getenv('output_dir');
masterPlot = figure('units','inches','position',[1 1 8 10]);

for index = 1:16
    
     subplot_total(index) = subplot(4,4,index);
    plot(dataStruct.meanData{index},'linewidth',2);
    hold on
    plot(fitSphere.calc{index}.bestVals,'linewidth',2)
    plot(fitFlat.calc{index}.bestVals,'linewidth',2)
    title([ num2str(dataStruct.stimChans(index,1)) ' ' num2str(dataStruct.stimChans(index,2))],'fontweight','normal')
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
for i = 1:16
    
    rhoAflat = sprintf('%0.2f',fitFlat.calc{i}.rhoAcalc);
    rhoAsphere = sprintf('%0.2f',fitSphere.calc{i}.rhoAcalc);
    mseFlat  = sprintf('%0.2e',fitFlat.calc{i}.MSE);
    mseSphere = sprintf('%0.2e',fitSphere.calc{i}.MSE);
    
    
    annotation(masterPlot, 'textbox', dim{i}, 'String', {['\rho_{A} flat = ' rhoAflat ],['RMSE_{flat} = ' mseFlat],...
        ['\rho_{A} spherical = ' rhoAsphere],['RMSE_{sphere} = ' mseSphere]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none','Fontsize',8);
    
    
    %     annotation(figTotal, 'textbox', dim{i}, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec(i))]...
    %         },...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
end

for index = 1:16
    figSub(index) = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(dataStruct.meanData{index},'linewidth',2)
    hold on
    plot(fitSphere.calc{index}.bestVals,'linewidth',2)
    plot(fitFlat.calc{index}.bestVals,'linewidth',2)
    title([ num2str(dataStruct.stimChans(index,1)) ' ' num2str(dataStruct.stimChans(index,2))],'fontweight','normal')
    set(gca,'fontsize',18)
    ylabel('voltage (V)')
    legend({'data','spherical model','flat model'})
end

if saveIt
    figure(masterPlot)
    SaveFig(OUTPUT_DIR, sprintf('3ada8b_sphere_flat_compare_binned'), 'png', '-r600');
    SaveFig(OUTPUT_DIR, sprintf('3ada8b_sphere_flat_compare_binned'), 'eps');
    
    
    for index = 1:7
        figure(figSub(index))
        SaveFig(OUTPUT_DIR, sprintf('sphere_flat_compare_3ada8b_%d_binned',index), 'png', '-r600');
        SaveFig(OUTPUT_DIR, sprintf('sphere_flat_compare_3ada8b_%d_binned',index), 'eps');
        
    end
end
end