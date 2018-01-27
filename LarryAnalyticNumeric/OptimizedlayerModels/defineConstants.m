function [alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);

h2=h1+d;
step=0.05/R;
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

end

