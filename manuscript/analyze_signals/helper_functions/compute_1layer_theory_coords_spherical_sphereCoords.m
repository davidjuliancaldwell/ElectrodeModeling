function [thy1] = compute_1layer_theory_coords_spherical_sphereCoords(locs,stimChans)

sizeData = size(locs,1);
thy1 = zeros(sizeData,1);

% default scale to 1 because will fitlm later 
scale = 1;

% positive and negative stim channels
jp = stimChans(2);
jm = stimChans(1);

% locs(:,1) = locs(:,1) + 0.5;
% locs(:,2) = locs(:,2) + 4;
% locs(:,3) = locs(:,3) + 6;

locs = locs/1000;

[az,el,r]  = cart2sph(locs(:,1),locs(:,2),locs(:,3));
r = r(1:64);
%R = 7/100; % cm
R = median(r);

for j=1:sizeData
    dp=norm(locs(j,:)-locs(jp,:));
    dm=norm(locs(j,:)-locs(jm,:));
    dotProdNumer = (r(j)*r(jm))*((cos(el(j))*cos(el(jm))*cos(az(j))*cos(az(jm)))+(cos(el(j))*cos(el(jm))*sin(az(j))*sin(az(jm)))+(sin(el(j))*sin(el(jm))));
     dotProdDenom = (r(j)*r(jp))*((cos(el(j))*cos(el(jp))*cos(az(j))*cos(az(jp)))+(cos(el(j))*cos(el(jp))*sin(az(j))*sin(az(jp)))+(sin(el(j))*sin(el(jp))));

    numer = dm + R - R*dotProdNumer/(r(j)*r(jm));
    denom = dp + R - R*dotProdDenom/(r(j)*r(jp));
    thy1(j)=scale*((2/dp)-(2/dm)+(1/R)*log(numer/denom));
end

thy1 = real(thy1);


end