function [l1,l3] = computePotentials_8x4(jp,kp,jm,km,rhoA,alpha,beta,eh1,eh2,step,ed,i0,scale,a,stimChans)
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
        
        % Calculate voltages for 1-layer point-electrodes
        %rhoA=0.7;
        scaleA=(i0*rhoA)/(2*pi);
        tp(j,k)=scaleA*((100/dp)-(100/dm));
        
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

l1(1:8)=tp(1,1:8);
l1(1+8:8+8)=tp(2,1:8);
l1(1+16:8+16)=tp(3,1:8);
l1(1+24:8+24)=tp(4,1:8);
l1(stimChans(1))=NaN;
l1(stimChans(2))=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(stimChans(1))=NaN;
l3(stimChans(2))=NaN;


end

