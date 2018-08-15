% fit row by row

clear all
load('all12.mat')

% Plot the data
figure;plot(m0b5a2e);hold on;

% Calculate the unscaled voltages
% 1 0b5a2e
i0=0.00175;
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
theory1(j,k)=((100/dp)-(100/dm));
end;
end;

T1=reshape(theory1',[64,1]);
T1(22)=0;
T1(30)=0;

E1=m0b5a2e;
E1(22)=0;
E1(30)=0;

figure;plot(T1(57:64),E1(57:64))
P=polyfit(T1(57:64),E1(57:64),1);
yfit1=P(1)*T1(57:64)+P(2);
hold on;plot(T1(57:64),yfit1,'r')
s5764=P(1);
o5764=P(2);

figure;plot(T1(49:56),E1(49:56))
P=polyfit(T1(49:56),E1(49:56),1);
yfit1=P(1)*T1(49:56)+P(2);
hold on;plot(T1(49:56),yfit1,'r')
s4956=P(1);
o4956=P(2);

figure;plot(T1(41:48),E1(41:48))
P=polyfit(T1(41:48),E1(41:48),1);
yfit1=P(1)*T1(41:48)+P(2);
hold on;plot(T1(41:48),yfit1,'r')
s4148=P(1);
o4148=P(2);

figure;plot(T1(33:40),E1(33:40))
P=polyfit(T1(33:40),E1(33:40),1);
yfit1=P(1)*T1(33:40)+P(2);
hold on;plot(T1(33:40),yfit1,'r')
s3340=P(1);
o3340=P(2);

figure;plot(T1(25:32),E1(25:32))
P=polyfit(T1(25:32),E1(25:32),1);
yfit1=P(1)*T1(25:32)+P(2);
hold on;plot(T1(25:32),yfit1,'r')
s2532=P(1);
o2532=P(2);

figure;plot(T1(17:24),E1(17:24))
P=polyfit(T1(17:24),E1(17:24),1);
yfit1=P(1)*T1(17:24)+P(2);
hold on;plot(T1(17:24),yfit1,'r')
s1724=P(1);
o1724=P(2);

figure;plot(T1(9:16),E1(9:16))
P=polyfit(T1(9:16),E1(9:16),1);
yfit1=P(1)*T1(9:16)+P(2);
hold on;plot(T1(9:16),yfit1,'r')
s0916=P(1);
o0916=P(2);

figure;plot(T1(1:8),E1(1:8))
P=polyfit(T1(1:8),E1(1:8),1);
yfit1=P(1)*T1(1:8)+P(2);
hold on;plot(T1(1:8),yfit1,'r')
s0108=P(1);
o0108=P(2);