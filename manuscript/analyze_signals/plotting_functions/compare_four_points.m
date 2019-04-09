function [] = compare_four_points(histStruct1,histStruct2)

saveIt = 0;
outputDir = getenv('OUTPUT_DIR');

bins = [0:0.1:10];

totalFig = figure;
totalFig.Units = "Inches";
totalFig.Position = [1 1 8 10];
numIndices = size(histStruct1.hist,2);
for index = 1:numIndices
    figure(totalFig);
    subplot(4,2,index);
    hold on
    histogram(histStruct1.hist{index}.vals,bins);
    stringMedianMad1 = sprintf(['Median = ' sprintf('%0.2f',histStruct1.hist{index}.median) '\n',...
        'MAD = ' sprintf('%0.2f',histStruct1.hist{index}.mad)]);
    
    histogram(histStruct2.hist{index}.vals,bins);
    stringMedianMad2 = sprintf(['Median = ' sprintf('%0.2f',histStruct2.hist{index}.median) '\n',...
        'MAD = ' sprintf('%0.2f',histStruct2.hist{index}.mad)]);
    
    set(gca,'fontsize',12)
    title(['Subject ' num2str(index)],'FontWeight','Normal')
    xlim([0 8])
    
    
    h1 = vline(histStruct1.hist{index}.median,'k',stringMedianMad1);
    h1.Color = [0,0.4470,0.7410];
    %  h1.Color = [1,1,1];
    
    h2 = vline(histStruct2.hist{index}.median,'k',stringMedianMad2);
    h2.Color = [0.8500, 0.3250, 0.0980];
    %    h2.Color = [1,1,1];
    
    stringV2 = findobj(gca,'Type','text');
    stringV2(1).Color = [0,0.4470,0.7410];
    stringV2(2).Color = [0.8500, 0.3250, 0.0980];
    
end

xlabel(['\rho_{apparent} (ohm-m)'])
ylabel('Count')
legend({'Flat','Spherical'})

if saveIt
    SaveFig(outputDir,'total_4point_compare','png','-r600')
    SaveFig(outputDir,'total_4point_compare','eps','-r600')
    
end

for index = 1:numIndices
    figure
    hold on
    
    histogram(histStruct1.hist{index}.vals,bins);
    histogram(histStruct2.hist{index}.vals,bins);
    set(gca,'fontsize',14)
    title(['Subject ' num2str(index)],'FontWeight','Normal')
    xlim([0 10])
    xlabel(['\rho_{apparent}'])
    legend({'Flat','Spherical'})
    ylabel('Count')
    if saveIt
        SaveFig(outputDir,['subject_' num2str(index) '_4point_compare'],'png','-r600')
        SaveFig(outputDir,['subject_' num2str(index) '_4point_compare'],'eps','-r600')
        
    end
    
    
end


end