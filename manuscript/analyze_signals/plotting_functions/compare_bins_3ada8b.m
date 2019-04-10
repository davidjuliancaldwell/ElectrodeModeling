function [] = compare_bins_3ada8b(fitStruct1,fitStruct2,subStruct)

saveIt = 0;
outputDir = getenv('OUTPUT_DIR');

bins = (repmat([1:8],2,1)+[0;1])';
binCenter = mean(bins,2);

totalFig = figure;
totalFig.Units = "Inches";
totalFig.Position = [1 1 8 10];
numIndices = size(fitStruct1.calc,2);

for index = 1:numIndices
    
    subplot(4,4,index)
    plot(binCenter(1:5),fitStruct1.calc{index}.rhoAcalc(1:5),'-o','linewidth',2)
    hold on
    plot(binCenter(1:5),fitStruct2.calc{index}.rhoAcalc(1:5),'-o','linewidth',2)
    
    title([num2str(subStruct.stimChans(index,1)) ' ' num2str(subStruct.stimChans(index,2))],'Fontweight','normal')
    set(gca,'fontsize',10)
    ylim([0 8])
    xlim([0 6])
    yticks([0 1 2 3 4 5 6 7 8])
    xticks([0 1 2 3 4 5 6])
    
end
xlabel('Bin (cm)')
ylabel('\rho_{apparent} (ohm-m)')
sgtitle('Flat vs Spherical One Layer Binned Apparent Resistivity','fontsize',12)
legend({'Flat','Spherical'});
if saveIt
    SaveFig(outputDir,'3ada8b_bin_compare','png','-r600')
    SaveFig(outputDir,'3ada8b_bin_compare','eps','-r600')
    SaveFig(outputDir,'3ada8b_bin_compare','svg','-r600')
end

end
