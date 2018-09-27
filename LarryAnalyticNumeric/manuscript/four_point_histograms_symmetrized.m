jLength = 15;
kLength = 15;
numChans = jLength*kLength;

dataScreened = dataInt(:);

rho1 = four_point_histogram_calculation(stimChansIndicesSym(1),stimChansIndicesSym(2),...
    stimChansIndicesSym(3),stimChansIndicesSym(4),1,jLength,kLength,dataScreened);
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
%%

numComponents = 2;

dataToFit = rho1_hist_vec_sym;
dataToFit = dataToFit(dataToFit>lowerCut & dataToFit<upperCut);
GMModel = fitgmdist(dataToFit,numComponents);
x1 = [0:0.001:10]';
figure
hold on
for i = 1:numComponents
    mu = GMModel.mu(i);
    sigma = GMModel.Sigma(:,:,i);
    pd{i} = makedist('Normal','mu',mu,'sigma',sigma);
    plot(x1,pdf(pd{i},x1),'linewidth',2)
    vline(mu,'k',[{'mu = ' num2str(mu),'sigma = ' num2str(sigma)}])
end
histogram(rho1_hist_vec_sym,bins,'normalization','pdf')
title(['Subject ' num2str(index)])

%Plot the data over the fitted Gaussian mixture model contours.

