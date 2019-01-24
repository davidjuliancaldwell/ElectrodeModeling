function [thy1,thy2,thy3] = compute_1layer_theory_coords_RushDriscoll(locs,stimChans,s1,s2,s3,a,b,c)

sizeData = size(locs,1);
thy1 = zeros(sizeData,1);
thy2 = zeros(sizeData,1);
thy3 = zeros(sizeData,1);


% positive and negative stim channels
jp = stimChans(2);
jm = stimChans(1);

% locs(:,1) = locs(:,1) + 0.5;
% locs(:,2) = locs(:,2) + 4;
% locs(:,3) = locs(:,3) + 6;

[az,el,r]  = cart2sph(locs(:,1),locs(:,2),locs(:,3));

for j=1:sizeData
    dp=norm(locs(j,:)-locs(jp,:));
    dm=norm(locs(j,:)-locs(jm,:));
    dotProdA = (r(j)*r(jm))*((cos(el(j))*cos(el(jm))*cos(az(j))*cos(az(jm)))+(cos(el(j))*cos(el(jm))*sin(az(j))*sin(az(jm)))+(sin(el(j))*sin(el(jm))));
    dotProdB = (r(j)*r(jp))*((cos(el(j))*cos(el(jp))*cos(az(j))*cos(az(jp)))+(cos(el(j))*cos(el(jp))*sin(az(j))*sin(az(jp)))+(sin(el(j))*sin(el(jp))));
    cosA = dotProdA/(r(j)*r(jm));
    cosB = dotProdB/(r(j)*r(jp));
    rInt = r(j);
    series1 = 0;
    series2 = 0;
    series3 = 0;
    for n = 1:100
        an = calculate_an(n,s1,s2,s3,a,b,c);
        sn = calculate_sn(n,s1,s2,s3,a,b,c);
        un = calculate_un(n,s1,s2,s3,a,b,c);
        tn = calculate_tn(n,s1,s2,s3,a,b,c);
        wn = calculate_wn(n,s1,s2,s3,a,b,c);
        
        legendreA = legendreP(n,cosA);
        legendreB = legendreP(n,cosB);
        legAB = (legendreB-legendreA);
        series3 = series3 + ((an*((rInt/c).^n)*(legAB)));
        series2 = series2 + (((sn*(rInt.^n)) + (un*(rInt.^(-(n+1)))))*(legAB));
        series1 = series1 + (((tn*(rInt.^n)) + (wn*(rInt.^(-(n+1)))))*(legAB));
    end
    thy1(j)=series1;
    thy2(j)=series2;
    thy3(j)=series3;
end

thy1 = real(thy1);
thy2 = real(thy2);
thy3 = real(thy3);


end