function [l1] = computePotentials_8x4_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset)
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
        
    end;
end;

l1(1:8)=tp(1,1:8);
l1(1+8:8+8)=tp(2,1:8);
l1(1+16:8+16)=tp(3,1:8);
l1(1+24:8+24)=tp(4,1:8);
l1 = l1 + offset;
l1(stimChans)=NaN;

end

