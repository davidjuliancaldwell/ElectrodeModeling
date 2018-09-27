jLength = 8;
kLength = 8;
numChans = jLength*kLength;
rho1_mean = [];
rho1_std = [];
rho1_median = [];

for index = 1:numSubjs
    channelSelect = logical(zeros(numChans,1));
    channelSelect([stimChansVec{index}]) = 1;
    dataScreened = dataSelect(:,index);
    dataScreened(channelSelect) = nan;
    
    rho1 = four_point_histogram_calculation(stimChansIndices(1,index),stimChansIndices(2,index),...
        stimChansIndices(3,index),stimChansIndices(4,index),currentMat(index),jLength,kLength,dataScreened);
    rho1 = rho1(~isnan(rho1) & ~isinf(rho1));
    rho1_hist_vec{index} = rho1;
    rho1_mean(index) = mean(rho1(:));
    rho1_std(index) = std(rho1(:));
    rho1_median(index) = median(rho1(:));
end;
%%
bins = [0:0.1:10];
figure;
for index = 1:numSubjs
    subplot(2,4,index);histogram(rho1_hist_vec{index},bins,'normalization','pdf');
    set(gca,'fontsize',14)
    title(['Subject ' num2str(index)])
        xlim([0 10])

end
xlabel(['\rho_{apparent}'])
ylabel('probability')
%%
figure
for index = 1:numSubjs
    subplot(2,4,index);
    rhoInt = rho1_hist_vec{index};
    rhoInt = rhoInt(~isinf(rhoInt) & ~isnan(rhoInt));
    rhoInt = rhoInt(rhoInt>=0 & rhoInt<=10);
    
    [peakRho,peakStd,peakDensity,xi] = rho_kernel_density(rhoInt,plotIt);
    histogram(rho1_hist_vec{index},bins,'normalization','pdf');
    xlim([0 10])
    ylim([0 0.7])
    hold on
    plot(xi,peakDensity,'linewidth',4)
    set(gca,'fontsize',14)
    title(['Subject ' num2str(index)])
        vline(peakRho,'r',['rho A = ' num2str(peakRho)])

end
xlabel(['\rho_{apparent}'])
ylabel('probability')



