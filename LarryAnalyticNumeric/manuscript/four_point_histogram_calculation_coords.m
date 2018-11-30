function [rho1] = four_point_histogram_calculation_coords(i0,locs,stimChans,data)
%% function to compute four point model free histograms using the coordinate values
% David.J.Caldwell 9.26.2018

deltaT = nan(numChans,numChans);
deltaE = deltaT;
sizeData = size(data,2);

T1 = compute_1layer_theory_coords(locs,stimChans,sizeData);

for j=1:numChans
    for k=1:numChans
        deltaT(j,k)=T1(j)-T1(k);
        deltaE(j,k)=data(j)-data(k);
    end
end
%%
rho1=(2*pi./i0)*(deltaE./deltaT);

end