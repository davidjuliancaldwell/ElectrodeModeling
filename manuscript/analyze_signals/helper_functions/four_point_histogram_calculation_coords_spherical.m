function [rho1] = four_point_histogram_calculation_coords_spherical(i0,locs,stimChans,data)
%% function to compute four point model free histograms using the coordinate values
% David.J.Caldwell 9.26.2018
sizeData = size(data,1);

deltaT = nan(sizeData,sizeData);
deltaE = deltaT;

T1 = compute_1layer_theory_coords_spherical(locs,stimChans);

for j=1:sizeData
    for k=1:sizeData
        deltaT(j,k)=T1(j)-T1(k);
        deltaE(j,k)=data(j)-data(k);
    end
end
%%
rho1=(4*pi./i0)*(deltaE./deltaT);

end