% calculate and save the distances

jp=3;
kp=6;
jm=4;
km=6;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
Dp(j,k)=dp;
Dm(j,k)=dm;
end;
end;

% reshape the distances before plotting

DP=reshape(Dp',[64,1]);
DM=reshape(Dm',[64,1]);

% make the plots

figure;plot(DP,E1)
figure;plot(DM,E1)
figure;plot(DP,T1)
figure;plot(DM,T1)

% make the over plots

figure;
plot(DP,E1);hold on;
plot(DM,E1,'r')

figure;
plot(DP,T1);hold on;
plot(DM,T1,'r')

% pause to enjoy the results





% back to work!