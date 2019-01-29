function [thy1] = compute_1layer_theory_coords_prolate(locs,stimChans)

plotIt = 0;

sizeData = size(locs,1);
thy1 = zeros(sizeData,1);

% default scale to 1 because will fitlm later
scale = 1;
%R = 7/100; % cm
locs = locs/1000;

%%
% for MNI, rotate around x axis
Around X-axis:
x = locs(:,1);
y = locs(:,2);
z = locs(:,3);
theta = (pi/2);
X = x;
Y = y*cos(theta) - z*sin(theta);
Z = y*sin(theta) + z*cos(theta);
locs = [x y z];
% Around Y-axis:
% X = x*cos(theta) + z*sin(theta);
% Y = y;
% Z = z*cos(theta) - x*sin(theta);
% Around Z-axis:
% X = x*cos(theta) - y*sin(theta);
% Y = x*sin(theta) + y*cos(theta);
% Z = z;

%%
[theta,rho,z]  = cart2pol(locs(:,1),locs(:,2),locs(:,3));

rho = rho(1:64);

b = 8;
a = 6;
c = (b.^2-a.^2).^(1/2);
delta = (z/(c*

if plotIt
    figure
    histogram(rho,10);
    ylabel('count');
    title('histogram of spherical rho values');
    xlabel('rho value');
    set(gca,'fontsize',14);
end

rhoS= median(rho);
% positive and negative stim channels
jp = stimChans(2);
jm = stimChans(1);


for j=1:sizeData
    Rp=norm(locs(j,:)-locs(jp,:));
    Rm=norm(locs(j,:)-locs(jm,:));
    su
    plusTerm = 1/Rp - (1/c)
    minusterm = 1/Rm
    numer = Rm + rhoS - rhoS*(locs(j,:)*locs(jm,:)')/(norm(locs(j,:))*norm(locs(jm,:)));
    
    denom = Rp + rhoS - rhoS*(locs(j,:)*locs(jp,:)')/(norm(locs(j,:))*norm(locs(jp,:)));
    thy1(j)=scale*(plusTerm - minusterm);
end

thy1 = real(thy1);

end