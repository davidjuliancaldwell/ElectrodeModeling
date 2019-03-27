function [] = compare_four_points(histStruct1,histStruct2)

saveIt = 0;
outputDir = getenv('OUTPUT_DIR');

bins = [0:0.1:10];

totalFig = figure;
numIndices = size(histStruct1.hist,2);
for index = 1:numIndices
    figure(totalFig);
    subplot(2,4,index);
    hold on
    histogram(histStruct1.hist{index}.vals,bins,'normalization','pdf');
    histogram(histStruct2.hist{index}.vals,bins,'normalization','pdf');
    
    set(gca,'fontsize',16)
    title(['Subject ' num2str(index)])
    xlim([0 10])
    
    
end

xlabel(['\rho_{apparent}'])
ylabel('probability')
legend({'Flat','Spherical'})

if saveIt
    SaveFig(outputDir,'total_4point_compare','png','-r600')
end

for index = 1:numIndices
    figure
    hold on
    
    histogram(histStruct1.hist{index}.vals,bins,'normalization','pdf');
    histogram(histStruct2.hist{index}.vals,bins,'normalization','pdf');    set(gca,'fontsize',14)
    title(['Subject ' num2str(index)])
    xlim([0 10])
    xlabel(['\rho_{apparent}'])
    legend({'Flat','Spherical'})
    
    if saveIt     
        SaveFig(outputDir,['subject_' num2str(index) '_4point_compare'],'png','-r600')
    end
    
    
end


end