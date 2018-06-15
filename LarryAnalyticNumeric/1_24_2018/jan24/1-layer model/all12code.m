clear all
load('all12.mat')
for m=5:15;
rhoA=0.1*m;
figure;

% 1 0b5a2e
i0=0.00175;
% Calculate distances
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

% Calculate voltages for 1-layer point-electrodes
%rhoA=0.7;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=-scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(1+32:8+32)=tp(5,1:8);
ltp(1+40:8+40)=tp(6,1:8);
ltp(1+48:8+48)=tp(7,1:8);
ltp(1+56:8+56)=tp(8,1:8);
ltp(22)=NaN;
ltp(30)=NaN;
subplot(3,4,1);plot(-m0b5a2e);hold on;
subplot(3,4,1);plot(ltp,'r');hold on;

% 2 702d24
i0=0.00075;
% Calculate distances
jp=2;
kp=5;
jm=2;
km=6;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.6;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(1+32:8+32)=tp(5,1:8);
ltp(1+40:8+40)=tp(6,1:8);
ltp(1+48:8+48)=tp(7,1:8);
ltp(1+56:8+56)=tp(8,1:8);
ltp(13)=NaN;
ltp(14)=NaN;
subplot(3,4,2);plot(m702d24);hold on;
subplot(3,4,2);plot(ltp,'r');hold on;

% 3 7dbdec
i0=0.0035;
% Calculate distances
jp=2;
kp=3;
jm=2;
km=4;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.6;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(1+32:8+32)=tp(5,1:8);
ltp(1+40:8+40)=tp(6,1:8);
ltp(1+48:8+48)=tp(7,1:8);
ltp(1+56:8+56)=tp(8,1:8);
ltp(11)=NaN;
ltp(12)=NaN;
subplot(3,4,3);plot(m7dbdec);hold on;
subplot(3,4,3);plot(ltp,'r');hold on;

% 4 9ab7ab
i0=0.00075;
% Calculate distances
jp=8;
kp=3;
jm=8;
km=4;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.6;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(1+32:8+32)=tp(5,1:8);
ltp(1+40:8+40)=tp(6,1:8);
ltp(1+48:8+48)=tp(7,1:8);
ltp(1+56:8+56)=tp(8,1:8);
ltp(59)=NaN;
ltp(60)=NaN;
subplot(3,4,4);plot(m9ab7ab);hold on;
subplot(3,4,4);plot(ltp,'r');hold on;

% 5 c91479
i0=0.003;
% Calculate distances
jp=7;
kp=7;
jm=7;
km=8;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);

% Calculate voltages for 1-layer point-electrodes
%rhoA=0.6;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(1+32:8+32)=tp(5,1:8);
ltp(1+40:8+40)=tp(6,1:8);
ltp(1+48:8+48)=tp(7,1:8);
ltp(1+56:8+56)=tp(8,1:8);
ltp(55)=NaN;
ltp(56)=NaN;
subplot(3,4,5);plot(-mc91479);hold on;
subplot(3,4,5);plot(ltp,'r');hold on;

% 6 d5cd55
i0=0.0025;
% Calculate distances
jp=7;
kp=6;
jm=8;
km=6;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);

% Calculate voltages for 1-layer point-electrodes
%rhoA=0.6;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(1+32:8+32)=tp(5,1:8);
ltp(1+40:8+40)=tp(6,1:8);
ltp(1+48:8+48)=tp(7,1:8);
ltp(1+56:8+56)=tp(8,1:8);
ltp(54)=NaN;
ltp(62)=NaN;
subplot(3,4,6);plot(md5cd55);hold on;
subplot(3,4,6);plot(ltp,'r');hold on;

% 7 ecb43e
i0=0.00175;
% Calculate distances
jp=7;
kp=8;
jm=8;
km=8;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.6;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(1+32:8+32)=tp(5,1:8);
ltp(1+40:8+40)=tp(6,1:8);
ltp(1+48:8+48)=tp(7,1:8);
ltp(1+56:8+56)=tp(8,1:8);
ltp(56)=NaN;
ltp(64)=NaN;
subplot(3,4,7);plot(mecb43e);hold on;
subplot(3,4,7);plot(ltp,'r');hold on;


clear all
load('all12.mat')

% 8 2012
i0=0.0005;
% Calculate distances
jp=3;
kp=4;
jm=2;
km=4;
for j=1:4;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
rhoA=0.7;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(20)=NaN;
ltp(12)=NaN;
subplot(3,4,8);plot(m2012(1,:));hold on;
subplot(3,4,8);plot(ltp,'r');hold on;

% 9 2804
i0=0.0005;
% Calculate distances
jp=4;
kp=4;
jm=1;
km=4;
for j=1:4;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.9;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(28)=NaN;
ltp(4)=NaN;
subplot(3,4,9);plot(m2804(1,:));hold on;
subplot(3,4,9);plot(ltp,'r');hold on;

% 10 2318
i0=0.0005;
% Calculate distances
jp=3;
kp=7;
jm=3;
km=2;
for j=1:4;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.9;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(23)=NaN;
ltp(18)=NaN;
subplot(3,4,10);plot(m2318(1,:));hold on;
subplot(3,4,10);plot(ltp,'r');hold on;

% 11 2219
i0=0.0005;
% Calculate distances
jp=3;
kp=6;
jm=3;
km=3;
for j=1:4;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.9;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(22)=NaN;
ltp(19)=NaN;
subplot(3,4,11);plot(m2219(1,:));hold on;
subplot(3,4,11);plot(ltp,'r');hold on;

% 12 2120
i0=0.0005;
% Calculate distances
jp=3;
kp=5;
jm=3;
km=4;
for j=1:4;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
%rhoA=0.9;
scaleA=(i0*rhoA)/(2*pi);
tp(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;
ltp(1:8)=tp(1,1:8);
ltp(1+8:8+8)=tp(2,1:8);
ltp(1+16:8+16)=tp(3,1:8);
ltp(1+24:8+24)=tp(4,1:8);
ltp(21)=NaN;
ltp(20)=NaN;
subplot(3,4,12);plot(m2120(1,:));hold on;
subplot(3,4,12);plot(ltp,'r');hold on;

end;