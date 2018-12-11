function [rho1] = four_point_histogram_calculation(jp,kp,jm,km,i0,jLength,kLength,data)
%% function to compute four point model free histograms
% David.J.Caldwell 9.26.2018

numChans = jLength*kLength;
theory1 = nan(jLength,kLength);
deltaT = nan(numChans,numChans);
deltaE = deltaT;


for j=1:jLength
    for k=1:kLength
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory1(j,k)=((100/dp)-(100/dm));
    end
end

T1=reshape(theory1',[numChans,1]);


for j=1:numChans
    for k=1:numChans
        deltaT(j,k)=T1(j)-T1(k);
        deltaE(j,k)=data(j)-data(k);
    end
end
%%
rho1=(2*pi./i0)*(deltaE./deltaT);

end