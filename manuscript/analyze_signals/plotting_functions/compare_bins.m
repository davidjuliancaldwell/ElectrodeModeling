function [] = compare_bins(fitStruct1,fitStruct2)

saveIt = 0;
outputDir = getenv('OUTPUT_DIR');

bins = (repmat([1:8],2,1)+[0;1])';
binCenter = mean(bins,2);

totalFig = figure;
totalFig.Units = "Inches";
totalFig.Position = [1 1 8 5];
numIndices = size(fitStruct1.calc,2);

for index = 1:numIndices
    
    subplot(2,4,index)
    plot(binCenter(1:5),fitStruct1.calc{index}.rhoAcalc(1:5),'-o','linewidth',2)
    hold on
    plot(binCenter(1:5),fitStruct2.calc{index}.rhoAcalc(1:5),'-o','linewidth',2)
    
    title(['Subject ' num2str(index)],'Fontweight','Normal')
    set(gca,'fontsize',12)
    ylim([0 6])
    xlim([0 6])
    yticks([0 1 2 3 4 5 6])
    xticks([0 1 2 3 4 5 6])
    
end
xlabel('Bin (cm)')
ylabel('\rho_{apparent} (ohm-m)')
sgtitle('Flat vs Spherical One Layer Binned Apparent Resistivity','fontsize',16)
legend({'Flat','Spherical'});
if saveIt
    SaveFig(outputDir,'total_bin_compare','png','-r600')
    SaveFig(outputDir,'total_bin_compare','eps','-r600')
end

end
