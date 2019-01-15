function [] = plot_ind_fits_vert_horiz(dataStruct,fitInd,fitAvg,saveIt)

figure
horiz = [1,6,7];
vert = [2,3,4,5];

for subPlotIndex = 1:2
    for index = 1:7
        
        subplot(2,2,subplotIndex)
        plot(dataStruct.meanData{index},'linewidth',2)
        hold on
        plot(fitAvg.calc{index}.bestVals,'linewidth',2)
        plot(fitInd.calc{index}.bestVals,'linewidth',2)
        title(['subject ' num2str(index)])
        set(gca,'fontsize',18)
    end
end

for subPlotIndex = 3:4
    for index = 1:2
        
        subplot(2,2,subplotIndex)
        plot(dataStruct.meanData{index},'linewidth',2)
        hold on
        plot(fitAvg.calc{index}.bestVals,'linewidth',2)
        plot(fitInd.calc{index}.bestVals,'linewidth',2)
        title(['subject ' num2str(index)])
        set(gca,'fontsize',18)
    end
end
ylabel('voltage (V)')
legend({'data','binned best fits','global best fits'})

if saveIt
end

end