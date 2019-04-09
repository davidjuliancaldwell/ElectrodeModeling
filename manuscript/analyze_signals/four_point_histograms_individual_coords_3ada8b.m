function histStruct = four_point_histograms_individual_coords_3ada8b(subStruct,plotIt,saveIt)

numIndices = size(subStruct.meanMat,3);
bins = [0:0.25:10];

for index = 1:numIndices
    % setup temporary structure
    stimChans = subStruct.stimChans(index,:);
    current = subStruct.currentMat(index);
    meanMat = subStruct.meanMat(:,:,index);
    meanMat = meanMat(1:64,:);
    locs = subStruct.locs{index};
    
    numChans = size(meanMat,1);
    channelSelect = logical(zeros(numChans,1));
    channelSelect(subStruct.badTotal{index}) = 1;
    dataScreened = meanMat(:,1);
    dataScreened(channelSelect) = nan;
    
    [rho1] = four_point_histogram_calculation_coords(current,locs,stimChans,dataScreened);
    rho1 = rho1(~isnan(rho1) & ~isinf(rho1));
    rho1 = rho1(rho1<=10 & rho1>0);
    rhoHist.vals = rho1;
    rhoHist.mean = mean(rho1(:));
    rhoHist.std = std(rho1(:));
    rhoHist.median = median(rho1(:));
    rhoHist.mad = mad(rho1(:),1);
    
    fprintf(['3ada8b Stim Chans ' num2str(stimChans(1)) ' ' num2str(stimChans(2)) ' flat mean = ' num2str(rhoHist.mean), ' std = ' num2str(rhoHist.std) ' median = ' num2str(rhoHist.median), ' MAD = ' num2str(rhoHist.mad) '\n'])
    
    histStruct.hist{index} = rhoHist;
    
    % plot histogram
    if plotIt
        figure
        histogram(rhoHist.vals,bins,'normalization','pdf');
        set(gca,'fontsize',14)
        title(['Subject ' num2str(subStruct.subjectNum(index))])
        xlim([0 10])
        xlabel(['\rho_{apparent}'])
        if saveIt
        end
    end
end

if plotIt
    figTotal = figure;
    figTotal.Units = "inches";
    figTotal.Position = [1 1 8 10];
    for index = 1:numIndices
        subplot(4,4,index);histogram(histStruct.hist{index}.vals,bins,'normalization','pdf');
        set(gca,'fontsize',16)
        title(['Stim Chans ' num2str(subStruct.stimChans(index,1)) ' ' num2str(subStruct.stimChans(index,2))])
        xlim([0 10])
    end
    
    xlabel(['\rho_{apparent}'])
    ylabel('probability')
    if saveIt
    end
end

end
