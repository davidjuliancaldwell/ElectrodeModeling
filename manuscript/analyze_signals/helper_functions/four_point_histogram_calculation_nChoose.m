function [rho1] = four_point_histogram_calculation_nChoose(jp,kp,jm,km,i0,stimChans,jLength,kLength,data)
%% function to compute four point model free histograms
% David.J.Caldwell 9.26.2018

sizeData = size(data,1);
goodChans = [1:sizeData];
logicalVec = true(length(goodChans),1);
logicalVec(stimChans) = 0;
goodChans = goodChans(logicalVec);
rhoA = 1;
offset = 0;


numChans = jLength*kLength;
T1 = nan(jLength,kLength);

for j=1:jLength
    for k=1:kLength
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        T1(j,k)=((100/dp)-(100/dm));
    end
end

T1=reshape(T1',[numChans,1]);
combos = nchoosek(goodChans,2);
deltaT = nan(size(combos,1),1);
deltaE = deltaT;

index = 1;
for combo = combos'
        deltaT(index)=T1(combo(1))-T1(combo(2));
        deltaE(index)=data(combo(1))-data(combo(2));
        index = index + 1;
end

rho1=(2*pi./i0)*(deltaE./deltaT);

end