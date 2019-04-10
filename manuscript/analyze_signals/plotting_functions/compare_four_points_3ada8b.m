function [] = compare_four_points_3ada8b(histStruct1,histStruct2,subStruct)

saveIt = 1;
outputDir = getenv('OUTPUT_DIR');

bins = [0:0.2:10];

totalFig = figure;
totalFig.Units = "inches";
totalFig.Position = [1 1 8 10];
numIndices = size(histStruct1.hist,2);
for index = 1:numIndices
    subplotTotal(index) = subplot(4,4,index);
    hold on
    
    histogram(histStruct1.hist{index}.vals,bins);
    stringMedianMad1 = sprintf(['Median = ' sprintf('%0.2f',histStruct1.hist{index}.median) '\n',...
        'MAD = ' sprintf('%0.2f',histStruct1.hist{index}.mad)]);
    
    histogram(histStruct2.hist{index}.vals,bins);
    stringMedianMad2 = sprintf(['Median = ' sprintf('%0.2f',histStruct2.hist{index}.median) '\n',...
        'MAD = ' sprintf('%0.2f',histStruct2.hist{index}.mad)]);
    
    set(gca,'fontsize',10)
    title([num2str(subStruct.stimChans(index,1)) ' ' num2str(subStruct.stimChans(index,2))],'Fontweight','normal')
    xlim([0 8])
    
    h1 = vline(histStruct1.hist{index}.median,'k',stringMedianMad1);
    h1.Color = [0,0.4470,0.7410];
    %  h1.Color = [1,1,1];
    
    h2 = vline(histStruct2.hist{index}.median,'k',stringMedianMad2);
    h2.Color = [0.8500, 0.3250, 0.0980];
    %    h2.Color = [1,1,1];
    
    stringV2 = findobj(gca,'Type','text');
    stringV2(2).Color = [0,0.4470,0.7410];
    stringV2(1).Color = [0.8500, 0.3250, 0.0980];    
end

xlabel(['\rho_{apparent} (ohm-m)'])
ylabel('Count')
legend({'Flat','Spherical'})

if saveIt
    SaveFig(outputDir,'3ada8b_4point_compare','png','-r600')
    SaveFig(outputDir,'3ada8b_4point_compare','eps','-r600')
    
end

if saveIt
    SaveFig(outputDir,'3ada8b_4point_compare','png','-r600')
    SaveFig(outputDir,'3ada8b_4point_compare','eps')
    
end

for index = 1:numIndices
    figure
    hold on
    
    histogram(histStruct1.hist{index}.vals,bins);
    histogram(histStruct2.hist{index}.vals,bins);    set(gca,'fontsize',14)
    title(['Stim Chans ' num2str(subStruct.stimChans(index,1)) ' ' num2str(subStruct.stimChans(index,2))],'Fontweight','normal')
    xlim([0 10])
    xlabel(['\rho_{apparent}'])
    ylabel('Count')
    legend({'Flat','Spherical'})
    
    if saveIt
        SaveFig(outputDir,['3ada8b_' num2str(index) '_4point_compare'],'png','-r600')
        SaveFig(outputDir,['3ada8b_' num2str(index) '_4point_compare'],'eps')
        
    end
    
    
end


end