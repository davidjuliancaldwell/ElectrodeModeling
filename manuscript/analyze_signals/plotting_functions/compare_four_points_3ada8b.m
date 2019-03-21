function [] = compare_four_points_3ada8b(histStruct1,histStruct2,subStruct)

saveIt = 1;
outputDir = getenv('OUTPUT_DIR');

bins = [0:0.1:10];

totalFig = figure;
totalFig.Units = "inches";
totalFig.Position = [1 1 8 10];
numIndices = size(histStruct1.hist,2);
for index = 1:numIndices
    figure(totalFig);
    subplot(4,4,index);
    hold on
    histogram(histStruct1.hist{index}.vals,bins,'normalization','pdf');
    histogram(histStruct2.hist{index}.vals,bins,'normalization','pdf');
    
    set(gca,'fontsize',12)
    title([ num2str(subStruct.stimChans(index,1)) ' ' num2str(subStruct.stimChans(index,2))])
    xlim([0 10])
    
    
end

xlabel(['\rho_{apparent}'])
ylabel('probability')
legend({'Flat','Spherical'})

if saveIt
    SaveFig(outputDir,'3ada8b_4point_compare','png','-r600')
    SaveFig(outputDir,'3ada8b_4point_compare','eps')
    
end

for index = 1:numIndices
    figure
    hold on
    
    histogram(histStruct1.hist{index}.vals,bins,'normalization','pdf');
    histogram(histStruct2.hist{index}.vals,bins,'normalization','pdf');    set(gca,'fontsize',14)
    title(['Stim Chans ' num2str(subStruct.stimChans(index,1)) ' ' num2str(subStruct.stimChans(index,2))])
    xlim([0 10])
    xlabel(['\rho_{apparent}'])
    legend({'Flat','Spherical'})
    
    if saveIt
        SaveFig(outputDir,['3ada8b_' num2str(index) '_4point_compare'],'png','-r600')
        SaveFig(outputDir,['3ada8b_' num2str(index) '_4point_compare'],'eps')
        
    end
    
    
end


end