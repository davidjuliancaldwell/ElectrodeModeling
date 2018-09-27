function [peakRho,peakStd,peakDensity,xi] = rho_kernel_density(signal,plotIt)
% expects time x channels

[peakDensity,xi] = ksdensity(signal,'Support',[0 10]);
[maxDensity,peakIndex,peakStd] = findpeaks(peakDensity,'sortstr','descend','npeaks',1);
peakRho = (xi(peakIndex));

end