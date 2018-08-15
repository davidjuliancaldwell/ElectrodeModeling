a=0.00115;
R=0.00115;
i0=5e-3;

n=13;
m=33;
rhoN=0.5+0.02*n;    
rhoM=0.5+0.02*m;
X(m)=rho;
rhoA=1;
rho1=0.55;
rho2=rhoN;
rho3=rhoM;

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
norm(symmetric-thy3)
figure;subplot(1,3,1);imagesc(symmetric./thyP)
hold on;subplot(1,3,2);imagesc(symmetric./thy3)
hold on;subplot(1,3,3);imagesc(thy3./thyP)
%%
figure
load('america');

bigMatrix = [symmetric; thyP; thy3];
maxAbs = max(abs(bigMatrix(:)));
cLims = ([-maxAbs; maxAbs])

subplot(1,3,1)
 imagesc(symmetric);
 set(gca,'xtick',[],'ytick',[])
colormap(cm)
caxis(cLims)
set(gca,'fontsize',16)
title('symmetrized averaged data')

subplot(1,3,2)
 imagesc(thyP);
 set(gca,'xtick',[],'ytick',[])
set(gca,'fontsize',16)
title({'one layer point',' electrode theory'})
title({'one layer point electrode theory'})

caxis(cLims)

subplot(1,3,3)
imagesc(thy3);
 set(gca,'xtick',[],'ytick',[])
title({'three layer finite',' sized electrode theory'})
title({'three layer finite sized electrode theory'})

set(gca,'fontsize',16)
c = colorbar
c.Label.String = 'mean square error (mV^2)'
ylabel('electrode')
xlabel('electrode')
caxis(cLims)

%subtitle(['symmetrized averaged data and theoretical predictions for CSF = ' num2str(h1) ' mm'])


