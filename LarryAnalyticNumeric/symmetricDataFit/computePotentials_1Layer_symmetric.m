function [l1,tp] = computePotentials_1Layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,jLength,kLength)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for j=1:jLength;
    for k=1:kLength;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        
        % Calculate voltages for 1-layer point-electrodes
        %rhoA=0.7;
        scaleA=(i0*rhoA)/(2*pi);
        tp(j,k)=1000*scaleA*((100/dp)-(100/dm));
    end;
end;

l1 = reshape(tp',1,[]);
l1(stimChans)=NaN;
tp(stimChans) = NaN;


end

