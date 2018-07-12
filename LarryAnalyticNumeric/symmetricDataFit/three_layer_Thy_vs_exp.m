a=0.00115;
R=0.00115;
i0=5e-3;

rhoA=.9;
rho1=.9;
rho2=.9;
rho3=.9;

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
jp=5;
kp=7;
jm=6;
km=7;
for j=1:10;
for k=1:13;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
scaleA=(i0*rhoA)/(2*pi);
thyP(j,k)=1000*scaleA*((100/dp)-(100/dm));
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
thy3(j,k)=1000*(Vp+Vm);
end;
end;
thy3(5,7)=0;
thy3(6,7)=0;
thyP(5,7)=0;
thyP(6,7)=0;
%%
figure;subplot(3,3,1);imagesc(thy3);hold on;
subplot(3,3,2);imagesc(thyP)
subplot(3,3,3);imagesc(symmetric)
subplot(3,3,4);imagesc(symmetric-thy3);hold on;
subplot(3,3,5);imagesc(symmetric-thyP)
subplot(3,3,6);imagesc(thy3-thyP)
subplot(3,3,7);plot(symmetric-thy3);hold on;
subplot(3,3,8);plot(symmetric-thyP)
subplot(3,3,9);plot(thy3-thyP)