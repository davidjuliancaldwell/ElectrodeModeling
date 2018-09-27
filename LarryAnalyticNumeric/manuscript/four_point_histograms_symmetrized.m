jLength = 15;
kLength = 15;
numChans = jLength*kLength;

% which data?!?
dataInt = gridDataAvg;

dataScreened = dataInt(:);

rho1 = four_point_histogram_calculation(stimChansIndicesSym(1),stimChansIndicesSym(2),...
    stimChansIndicesSym(3),stimChansIndicesSym(4),1e3,jLength,kLength,dataScreened);
    rho1 = rho1(~isnan(rho1) & ~isinf(rho1));
    
    rho1_sym_mean = mean(rho1(:));
    rho1_sym_std = std(rho1(:));
    rho1_sym_median = median(rho1(:));

rho1_hist_vec_sym = rho1;

%%
bins = [0:0.1:10];
figure;
histogram(rho1_hist_vec_sym,bins,'normalization','pdf');
set(gca,'fontsize',14)
title(['Average data'])
xlim([0 10])


xlabel(['\rho_{apparent}'])
ylabel('count')
%%
figure

rhoInt = rho1_hist_vec_sym;
rhoInt = rhoInt(~isinf(rhoInt) & ~isnan(rhoInt));
rhoInt = rhoInt(rhoInt>=0 & rhoInt<=10);

[peakRho,peakStd,peakDensity,xi] = rho_kernel_density(rhoInt,plotIt);
histogram(rho1_hist_vec_sym,bins,'normalization','pdf');
xlim([0 10])
ylim([0 0.7])
hold on
plot(xi,peakDensity,'linewidth',4)
set(gca,'fontsize',14)
title(['Symmetric Data'])
vline(peakRho,'r',['rho A = ' num2str(peakRho)])

xlabel(['\rho_{apparent}'])
ylabel('probability')

