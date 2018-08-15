clear all
load('all12.mat')

rhoA=0.9;
rho1=0.6;
rho2=2;
rho3=2;
h1=0.001;

figure;

% 1 0b5a2e
i0=0.00175;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(1+32:8+32)=tp(5,1:8);
l1(1+40:8+40)=tp(6,1:8);
l1(1+48:8+48)=tp(7,1:8);
l1(1+56:8+56)=tp(8,1:8);
l1(22)=NaN;
l1(30)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(1+32:8+32)=thy(5,1:8);
l3(1+40:8+40)=thy(6,1:8);
l3(1+48:8+48)=thy(7,1:8);
l3(1+56:8+56)=thy(8,1:8);
l3(22)=NaN;
l3(30)=NaN;

subplot(3,4,1);plot(m0b5a2e);hold on;
subplot(3,4,1);plot(l3,'r');hold on;
subplot(3,4,1);plot(l1,'c');hold on;


% 2 702d24
i0=0.00075;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(1+32:8+32)=tp(5,1:8);
l1(1+40:8+40)=tp(6,1:8);
l1(1+48:8+48)=tp(7,1:8);
l1(1+56:8+56)=tp(8,1:8);
l1(13)=NaN;
l1(14)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(1+32:8+32)=thy(5,1:8);
l3(1+40:8+40)=thy(6,1:8);
l3(1+48:8+48)=thy(7,1:8);
l3(1+56:8+56)=thy(8,1:8);
l3(13)=NaN;
l3(14)=NaN;

subplot(3,4,2);plot(m702d24);hold on;
subplot(3,4,2);plot(l3,'r');hold on;
subplot(3,4,2);plot(l1,'c');hold on;



% 3 7dbdec
i0=0.0035;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(1+32:8+32)=tp(5,1:8);
l1(1+40:8+40)=tp(6,1:8);
l1(1+48:8+48)=tp(7,1:8);
l1(1+56:8+56)=tp(8,1:8);
l1(11)=NaN;
l1(12)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(1+32:8+32)=thy(5,1:8);
l3(1+40:8+40)=thy(6,1:8);
l3(1+48:8+48)=thy(7,1:8);
l3(1+56:8+56)=thy(8,1:8);
l3(11)=NaN;
l3(12)=NaN;

subplot(3,4,3);plot(m7dbdec);hold on;
subplot(3,4,3);plot(l3,'r');hold on;
subplot(3,4,3);plot(l1,'c');hold on;



% 4 9ab7ab
i0=0.00075;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(1+32:8+32)=tp(5,1:8);
l1(1+40:8+40)=tp(6,1:8);
l1(1+48:8+48)=tp(7,1:8);
l1(1+56:8+56)=tp(8,1:8);
l1(59)=NaN;
l1(60)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(1+32:8+32)=thy(5,1:8);
l3(1+40:8+40)=thy(6,1:8);
l3(1+48:8+48)=thy(7,1:8);
l3(1+56:8+56)=thy(8,1:8);
l3(59)=NaN;
l3(60)=NaN;

subplot(3,4,4);plot(m9ab7ab);hold on;
subplot(3,4,4);plot(l3,'r');hold on;
subplot(3,4,4);plot(l1,'c');hold on;



% 5 c91479
i0=0.003;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(1+32:8+32)=tp(5,1:8);
l1(1+40:8+40)=tp(6,1:8);
l1(1+48:8+48)=tp(7,1:8);
l1(1+56:8+56)=tp(8,1:8);
l1(55)=NaN;
l1(56)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(1+32:8+32)=thy(5,1:8);
l3(1+40:8+40)=thy(6,1:8);
l3(1+48:8+48)=thy(7,1:8);
l3(1+56:8+56)=thy(8,1:8);
l3(55)=NaN;
l3(56)=NaN;

subplot(3,4,5);plot(mc91479);hold on;
subplot(3,4,5);plot(-l3,'r');hold on;
subplot(3,4,5);plot(-l1,'c');hold on;




% 6 d5cd55
i0=0.0025;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(1+32:8+32)=tp(5,1:8);
l1(1+40:8+40)=tp(6,1:8);
l1(1+48:8+48)=tp(7,1:8);
l1(1+56:8+56)=tp(8,1:8);
l1(54)=NaN;
l1(62)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(1+32:8+32)=thy(5,1:8);
l3(1+40:8+40)=thy(6,1:8);
l3(1+48:8+48)=thy(7,1:8);
l3(1+56:8+56)=thy(8,1:8);
l3(54)=NaN;
l3(62)=NaN;

subplot(3,4,6);plot(md5cd55);hold on;
subplot(3,4,6);plot(l3,'r');hold on;
subplot(3,4,6);plot(l1,'c');hold on;




% 7 ecb43e
i0=0.00175;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(1+32:8+32)=tp(5,1:8);
l1(1+40:8+40)=tp(6,1:8);
l1(1+48:8+48)=tp(7,1:8);
l1(1+56:8+56)=tp(8,1:8);
l1(56)=NaN;
l1(64)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(1+32:8+32)=thy(5,1:8);
l3(1+40:8+40)=thy(6,1:8);
l3(1+48:8+48)=thy(7,1:8);
l3(1+56:8+56)=thy(8,1:8);
l3(56)=NaN;
l3(64)=NaN;

subplot(3,4,7);plot(mecb43e);hold on;
subplot(3,4,7);plot(l3,'r');hold on;
subplot(3,4,7);plot(l1,'c');hold on;




clear all
load('all12.mat')

rhoA=0.9;
rho1=0.6;
rho2=2;
rho3=2;
h1=0.001;

% 8 2012
i0=0.0005;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(20)=NaN;
l1(12)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(20)=NaN;
l3(12)=NaN;

subplot(3,4,8);plot(m2012(1,:));hold on;
subplot(3,4,8);plot(l3,'r');hold on;
subplot(3,4,8);plot(l1,'c');hold on;



% 9 2804
i0=0.0005;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(28)=NaN;
l1(4)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(28)=NaN;
l3(4)=NaN;

subplot(3,4,9);plot(m2804(1,:));hold on;
subplot(3,4,9);plot(l3,'r');hold on;
subplot(3,4,9);plot(l1,'c');hold on;



% 10 2318
i0=0.0005;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(23)=NaN;
l1(18)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(23)=NaN;
l3(18)=NaN;

subplot(3,4,10);plot(m2318(1,:));hold on;
subplot(3,4,10);plot(l3,'r');hold on;
subplot(3,4,10);plot(l1,'c');hold on;




% 11 2219
i0=0.0005;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(22)=NaN;
l1(19)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(22)=NaN;
l3(19)=NaN;

subplot(3,4,11);plot(m2318(1,:));hold on;
subplot(3,4,11);plot(l3,'r');hold on;
subplot(3,4,11);plot(l1,'c');hold on;



% 12 2120
i0=0.0005;

% Definitions
a=0.00115;
R=0.00115;
%rho1=0.6;
%rho2=2.5;
%rho3=2.5;
scale=(i0*rho1)/(2*pi*a);
k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
%h1=0.01;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);

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
l1(21)=NaN;
l1(20)=NaN;

l3(1:8)=thy(1,1:8);
l3(1+8:8+8)=thy(2,1:8);
l3(1+16:8+16)=thy(3,1:8);
l3(1+24:8+24)=thy(4,1:8);
l3(21)=NaN;
l3(20)=NaN;

subplot(3,4,12);plot(m2120(1,:));hold on;
subplot(3,4,12);plot(l3,'r');hold on;
subplot(3,4,12);plot(l1,'c');hold on;