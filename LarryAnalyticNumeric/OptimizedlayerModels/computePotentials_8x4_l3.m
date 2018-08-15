function [l3] = computePotentials_8x4_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for j=1:4;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        
        % Calculate voltages for 3-layer V-electrodes
        x=dp/100;
        Ntheta1=eh1+eh2;
        Denom=1-eh1-eh2+ed;
        theta1=Ntheta1./Denom;
        A=scale*(1.+2*theta1).*beta;
        integral=sum(A.*besselj(0,alpha*x).*sin(alpha*a));
        Vp=step*integral;
        x=dm/100;
        Ntheta1=eh1+eh2;
        Denom=1-eh1-eh2+ed;
        theta1=Ntheta1./Denom;
        A=scale*(1.+2*theta1).*beta;
        integral=sum(A.*besselj(0,alpha*x).*sin(alpha*a));
        Vm=-step*integral;
        thy(j,k)=Vp+Vm;
    end;
end;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3 = l3 + offset;
l3(stimChans)=NaN;
l3(isinf(l3)) = NaN;


end

