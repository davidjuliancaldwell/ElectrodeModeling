function [thy1] = compute_1layer_theory_coords_spherical(locs,stimChans)

sizeData = size(locs,1);
thy1 = zeros(sizeData,1);

% default scale to 1 because will fitlm later 
scale = 1;
%R = 7/100; % cm

[az,el,r]  = cart2sph(locs(:,1),locs(:,2),locs(:,3));
R= median(r);
% positive and negative stim channels
jp = stimChans(2);
jm = stimChans(1);

locs = locs/1000;

for j=1:sizeData
    dp=norm(locs(j,:)-locs(jp,:));
    dm=norm(locs(j,:)-locs(jm,:));
    numer = dm + R - R*(locs(j,:)*locs(jm,:)')/(norm(locs(j,:))*norm(locs(jm,:)));

    denom = dp + R - R*(locs(j,:)*locs(jp,:)')/(norm(locs(j,:))*norm(locs(jp,:)));
    thy1(j)=scale*((2/dp)-(2/dm)+(1/R)*log(numer/denom));
end

thy1 = real(thy1);

end