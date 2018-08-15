a=0.00115;
R=0.00115;
i0=1;

rhoA=1;
rho1=.6;
rho2=1;
rho3=1;

k1=(rho2-rho1)/(rho2+rho1);
k2=(rho3-rho2)/(rho3+rho2);
h1=0.001;
d=0.0035;
h2=h1+d;
step=0.05/R;              
alpha=0+R:step:50/R;
beta=1./alpha;
eh1=k1*exp(-2*alpha*h1);
eh2=k2*exp(-2*alpha*h2);
ed=k1*k2*exp(-2*alpha*d);
% Calculate voltages
jp=7;
kp=8;
jm=8;
km=8;
for j=2:12;
for k=3:12;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
scaleA=(i0*rhoA)/(2*pi);
Tp(j,k)=scaleA*((100/dp)-(100/dm));
% Calculate voltages for 3-layer v-electrodes
scaleC=(i0*rho1)/(2*pi*a);
x=dp/100;
Ntheta1=eh1+eh2;
Denom=1-eh1-eh2+ed;
theta1=Ntheta1./Denom;
A=scaleC*(1.+2*theta1).*beta;
integral=sum(A.*besselj(0,alpha*x).*sin(alpha*a));
Vp=step*integral;
x=dm/100;
Ntheta1=eh1+eh2;
Denom=1-eh1-eh2+ed;
theta1=Ntheta1./Denom;
A=scaleC*(1.+2*theta1).*beta;
integral=sum(A.*besselj(0,alpha*x).*sin(alpha*a));
Vm=-step*integral;
T3(j,k)=Vp+Vm;
end;
end;
Tp(7,8)=1e-6;
Tp(8,8)=1e-6;
T3(7,8)=1e-6;
T3(8,8)=1e-6;
ratio=Tp(3:12,4:12)./T3(3:12,4:12);
bins=[0:.01:2];
figure;
subplot(2,2,4);hist(ratio,bins);hold on
subplot(2,2,1);imagesc(Tp(3:12,4:12));hold on
subplot(2,2,2);imagesc(T3(3:12,4:12));hold on
subplot(2,2,3);imagesc(ratio);hold on
