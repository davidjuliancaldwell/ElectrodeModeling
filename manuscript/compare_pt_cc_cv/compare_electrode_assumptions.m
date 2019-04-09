R = 1;
rho = 1;
I = 1;
r = [10^-1:0.001:10^1];

% pt
pt = pt_function(I,rho,r);

% cc
cc = cc_function(I,rho,r,R);

% cv
cv = cv_function(I,rho,r,R);

%%
figTotal = figure;
figTotal.Units = "inches";
figTotal.Position = [1 1 8 5];
loglog(r,pt,'linewidth',2)
hold on
loglog(r,cv,'linewidth',2)
loglog(r,cc,'linewidth',2)

legend({'Point Electrode','Constant Voltage','Constant Current'})
title('Electrode Models and Predicted Voltages','Fontweight','normal')
xlabel('Distance in terms of electrode radius')
ylabel('Electric potential (arbitrary units)')
set(gca,'fontsize',12)
%%
function V = pt_function(I,rho,r)
V = zeros(size(r,2),1);
V = (I.*rho)./(2.*pi.*r);
end


function V = cv_function(I,rho,r,R)
V = zeros(size(r,2),1);
scalev =(I*rho)/(4*R);
logicalR = r<=R;
V_o = I/rho;
V(logicalR) = V_o;
%V(~logicalR) = ((2.*I)./(rho.*pi).*asin(R./r(r>R)));
V(~logicalR) = (scalev*(2*(I*rho)/pi).*asin(R./r(r>R)));
end


function V = cc_function(I,rho,r,R)
V = zeros(size(r,2),1);
step1 = 0.001/R;
index = 1;
alpha = 0+0.001:step1:50/R;
beta=1./alpha;
scalec=(I*rho)/(pi*R);

for ii = r
    z = 0;
    tempBessel = sum(beta.*besselj(0,alpha.*ii).*besselj(1,alpha.*R).*exp(-alpha*z));
    %V(index) = ((I.*rho)/(pi.*R)).*tempBessel;
    V(index) = scalec.*step1*tempBessel;
    
    index = index + 1;
end
end


% function V = cc_function(I,rho,r,R)
% V = zeros(size(r,2),1);
% index = 1;
% for ii = r
%     alpha = 0.001:0.01:100;
%     tempBessel = sum((1./(alpha)).*besselj(0,alpha.*ii).*besselj(1,alpha.*R));
%     V(index) = ((I.*rho)/(pi.*R)).*tempBessel;
%     index = index + 1;
% end
% end
