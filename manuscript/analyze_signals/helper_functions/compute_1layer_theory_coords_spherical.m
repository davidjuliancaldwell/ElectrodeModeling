function [thy1,correctionFactor] = compute_1layer_theory_coords_spherical(locs,stimChans)

plotIt = 0;

sizeData = size(locs,1);
thy1 = zeros(sizeData,1);
correctionFactor = zeros(sizeData,1);

% default scale to 1 because will fitlm later
scale = 1;
%R = 7/100; % cm
locs = locs/1000;
[az,el,r]  = cart2sph(locs(:,1),locs(:,2),locs(:,3));

r = r(1:64);

if plotIt
    figure
    histogram(r,10);
    ylabel('count');
    title('histogram of spherical r values');
    xlabel('r value');
    set(gca,'fontsize',14);
end

R= median(r);
% positive and negative stim channels
jp = stimChans(2);
jm = stimChans(1);


for j=1:sizeData
    dp=norm(locs(j,:)-locs(jp,:));
    dm=norm(locs(j,:)-locs(jm,:));
    numer = dm + R - R*(locs(j,:)*locs(jm,:)')/(norm(locs(j,:))*norm(locs(jm,:)));
    
    denom = dp + R - R*(locs(j,:)*locs(jp,:)')/(norm(locs(j,:))*norm(locs(jp,:)));
    thy1(j)=scale*((2/dp)-(2/dm)+(1/R)*log(numer/denom));
    correctionFactor(j)  = (1/R)*log(numer/denom);
    correctionFactorTopBottom(j) = log(numer) - log(denom);
end

thy1 = real(thy1);

end