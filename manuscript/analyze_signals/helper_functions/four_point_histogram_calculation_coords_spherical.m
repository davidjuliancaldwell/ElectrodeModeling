function [rho1] = four_point_histogram_calculation_coords_spherical(i0,locs,stimChans,data,rFixed)
%% function to compute four point model free histograms using the coordinate values
% David.J.Caldwell 9.26.2018


sizeData = size(data,1);
goodChans = [1:sizeData];
logicalVec = true(length(goodChans),1);
logicalVec(stimChans) = 0;
goodChans = goodChans(logicalVec);

T1 = compute_1layer_theory_coords_spherical(locs,stimChans,rFixed);

combos = nchoosek(goodChans,2);
deltaT = nan(size(combos,1),1);
deltaE = deltaT;

index = 1;
for combo = combos'
        deltaT(index)=T1(combo(1))-T1(combo(2));
        deltaE(index)=data(combo(1))-data(combo(2));
        index = index + 1;
end

%%
rho1=(4*pi./i0)*(deltaE./deltaT);

end