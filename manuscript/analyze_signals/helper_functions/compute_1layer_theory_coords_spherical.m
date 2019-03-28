function [thy1,correctionFactor,thy1scaled,correctionFactorScaled] = compute_1layer_theory_coords_spherical(locs,stimChans)

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
    
    % scale to be all on the "sphere"
    vecP = locs(jp,:);
    vecM = locs(jm,:);
    vecInt = locs(j,:);
    
    vecInt = vecInt*R/norm(vecInt);
    vecM = vecM*R/norm(vecM);
    vecP = vecP*R/norm(vecP);

    numerScaled = dm + R - R*(vecInt*vecM')/(norm(vecInt)*norm(vecM));
    denomScaled = dp + R - R*(vecInt*vecP')/(norm(vecInt)*norm(vecP));
    
    thy1scaled(j)=scale*((2/dp)-(2/dm)+(1/R)*log(numerScaled/denomScaled));
    correctionFactorScaled(j)  = (1/R)*log(numerScaled/denomScaled);
    correctionFactorTopBottomScaled(j) = log(numerScaled) - log(denomScaled);
end

thy1 = real(thy1);
thy1scaled = real(thy1scaled);
end