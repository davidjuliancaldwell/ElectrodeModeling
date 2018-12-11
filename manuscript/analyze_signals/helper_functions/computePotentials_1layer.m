function [l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,jLength,kLength)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

tp = nan(jLength,kLength);

for j=1:jLength
    for k=1:kLength
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        
        % Calculate voltages for 1-layer point-electrodes
        scaleA=(i0*rhoA)/(2*pi);
        tp(j,k)=scaleA*((100/dp)-(100/dm));
    end
end

tp = tp';
l1 = tp(:);

l1 = l1 + offset;
l1(stimChans)=NaN;
l1(isinf(l1)) = NaN;

tp = reshape(l1,jLength,kLength);

end

