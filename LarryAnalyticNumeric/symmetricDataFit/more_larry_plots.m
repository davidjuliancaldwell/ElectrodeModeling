

figure;imagesc(s1)
figure;imagesc(s2)
ss1=s1;
ss2=s2;
ss3=s3;
ss4=s4;
ss5=s5;
ss6=s6;
ss7=s7;
figure;imagesc(ss7)
figure;
subplot(2,4,1);imagesc(s1);hold on
subplot(2,4,2);imagesc(s2);hold on
subplot(2,4,3);imagesc(s3);hold on
subplot(2,4,4);imagesc(s4);hold on
subplot(2,4,5);imagesc(s5);hold on
subplot(2,4,6);imagesc(s6);hold on
subplot(2,4,7);imagesc(s7);hold on
caxis([-100 100]);
figure;
subplot(2,4,1);imagesc(s1);caxis([-50 50]);hold on
subplot(2,4,2);imagesc(s2);caxis([-50 50]);hold on
subplot(2,4,3);imagesc(s3);caxis([-50 50]);hold on
subplot(2,4,4);imagesc(s4);caxis([-50 50]);hold on
subplot(2,4,5);imagesc(s5);caxis([-50 50]);hold on
subplot(2,4,6);imagesc(s6);caxis([-50 50]);hold on
subplot(2,4,7);imagesc(s7);caxis([-50 50]);hold on
figure;
subplot(2,4,1);imagesc(theory1);caxis([-50 50]);hold on
subplot(2,4,2);imagesc(theory2);caxis([-50 50]);hold on
subplot(2,4,3);imagesc(theory3);caxis([-50 50]);hold on
subplot(2,4,4);imagesc(theory4);caxis([-50 50]);hold on
subplot(2,4,5);imagesc(theory5);caxis([-50 50]);hold on
subplot(2,4,6);imagesc(theory6);caxis([-50 50]);hold on
subplot(2,4,7);imagesc(theory7);caxis([-50 50]);hold on
figure;imagesc(ss1)
figure;imagesc(ss1);caxis([-70 70])
figure;
subplot(2,4,1);imagesc(ss1);caxis([-70 70]);hold on
subplot(2,4,2);imagesc(ss2);caxis([-70 70]);hold on
subplot(2,4,3);imagesc(ss3);caxis([-70 70]);hold on
subplot(2,4,4);imagesc(ss4);caxis([-70 70]);hold on
subplot(2,4,5);imagesc(ss5);caxis([-70 70]);hold on
subplot(2,4,6);imagesc(ss6);caxis([-70 70]);hold on
subplot(2,4,7);imagesc(ss7);caxis([-70 70]);hold on
figure;imagesc(ss1+ss2+ss3+ss4+ss5+ss6+ss7)
ss=ss1+ss2+ss3+ss4+ss5+ss6+ss7;
sss1=ss1;
sss2=ss2;
sss3=ss3;
sss4=ss4;
sss5=ss5;
sss6=ss6;
sss7=ss7;
ss1=sss1;
figure;imagesc(ss1+ss2+ss3+ss4+ss5+ss6+ss7)
ss1(1,:)
ss2(1,:)
ss3(1,:)
ss4(1,:)
ss5(1,:)
ss6(1,:)
ss7(1,:)
S(1,:)=0.8600;
S(1,2)=0.5*(1.6900+1.0400);
S(1,3)=(0.0900-0.1100+1.3000)/3;
S(1,4)=(0.15+.25+1.4200)/3;
S(1,5)=(0.1+.52+1.6200)/3;
S(1,6)=(0.25+.62+1.7800)/3;
S(1,7)=(0.26+.39+1.8600)/3;
S(1,8)=(0.21+.94+1.8100)/3;
S(1,9)=(-.06+1.06)/2;
S(1,10)=0.73;
S(1,11:14)=0;
ss1(2,:)
ss2(2,:)
ss3(2,:)
ss4(2,:)
ss5(2,:)
ss6(2,:)
ss7(2,:)
S(2,1)=0.9;
S(2,2)=(-0.02+1.21)/2;
S(2,3)=(.26+.3+1.58)/3;
S(2,4)=(.44+1.03+1.87)/3;
S(2,5)=(.61+1.78+2.3)/3;
S(2,6)=(.83+2.42+2.7)/3;
S(2,7)=(.81+2.81+2.83)/3;
S(2,8)=(.62+2.99+2.64)/3;
S(2,9)=1.65;
ss1(3,:)
ss2(3,:)
ss3(3,:)
ss4(3,:)
ss5(3,:)
ss6(3,:)
ss7(3,:)
S(3,1)=0.94;
S(3,2)=(-0.05+1.39)/2;
S(3,3)=(.35+.45+1.91)/3;
S(3,4)=(.71+1.69+2.53)/3;
S(3,5)=(1.21+2.87+3.12)/3;
S(3,6)=(1.83+4.25+3.84)/3;
S(3,7)=(2.32+5.23+4.38)/3;
S(3,8)=(1.51+5.73+3.95)/3;
S(3,9)=(.89+4.75)/2;
S(3,10)=(2.92+3.03)/2;
S(3,11)=2.61;
S(3,12)=1.88;
S(3,13)=1.24;
S(3,14)=0.93;
S(3,7)=(3.59+2.32+5.23+4.38)/4;
S(3,8)=(4.43+1.51+5.73+3.95)/4;
S(3,9)=(3.99+.89+4.75)/3;
ss1(4,:)
ss2(4,:)
ss3(4,:)
ss4(4,:)
ss5(4,:)
ss6(4,:)
ss7(4,:)
S(4,1)=.96;
S(4,2)=(-.23+2.25)/2;
S(4,3)=(.33+.65+2.22)/3;
S(4,4)=(.97+2.14+2.83)/3;
S(4,5)=(2+4.05+3.46)/3;
S(4,5)=(3.6+6.58+5.21)/3;
S(4,7)=(4.06+8.65+6.25+6.08)/4;
S(4,6)=(3.6+6.58+5.21)/3;
S(4,5)=(2+4.05+3.46)/3;
S(4,8)=(7.53+3.6+10.83+4.92)/4;
S(4,9)=(6.03+2.18+7.94)/3;
S(4,10)=(4.52+4.52)/2;
S(4,11)=3.12;
S(4,12)=1.79;
S(4,13)=1.03;
S(4,14)=.73;
ss1(5,:)
ss2(5,:)
ss3(5,:)
ss4(5,:)
ss5(5,:)
ss6(5,:)
ss7(5,:)
S(7,1)=(-0.07+.53)/2;
S(7,2)=(.13+-.44+.45)/3;
S(7,3)=(.77+.5+.08+.23+1.63)/5;
S(7,4)=(1.44+1.25+.71+2.32+2.91)/5;
S(7,5)=(2.39+2.46+2.89+5.08+4.88)/5;
S(7,6)=(4.49+4.67+5.24+9.42+7.5)/5;
S(7,7)=(6.53+10.05+9.71+7.58+8.55+14.73+10.66)/7;
S(7,8)=(10.88+13.4+11.26+11.06+10.3+18.07+11.24)/7;
S(7,9)=(10.48+11.23+10.3+4.94+13.67)/5;
S(7,10)=(5.71-1.64+5.96+6.56)/4;
S(7,11)=(3.12+2.08)/2;
S(7,12)=(1.34+2.64)/2;
S(7,13)=(.74+.86)/2;
S(7,14)=(.49+1.07)/2;
ss1(6,:)
ss2(6,:)
ss3(6,:)
ss4(6,:)
ss5(6,:)
ss6(6,:)
ss7(6,:)
S(6,1)=(-.32+0.87)/2;
S(6,2)=(-.2-0.77+1.27)/3;
S(6,3)=(.48+0.07-.41+.4+2.15)/5;
S(6,4)=(.93+.58+.12+2.23+3.27)/5;
S(6,5)=(2.3+1.84+2.24+4.83+5.82)/5;
S(6,6)=(5.92+5.3+7.12+10.96+10.27)/5;
S(6,7)=(19.1+17.93+17.9+12.4+19.94+30.16+25.78)/7;
S(6,8)=(49.1+37.95+38.42+34.1+36.65+58.06+39.85)/7;
S(6,9)=(26.52+21.45+21.36+14.12+33.68)/5;
S(6,10)=(9.69-4.88+7.54+10.3)/4;
S(6,11)=(1.57+1.11)/2;
S(6,12)=(.43+2.08)/2;
S(6,13)=(.08+.53)/2;
S(6,14)=(.22-.29)/2;
ss1(7,:)
ss2(7,:)
ss3(7,:)
ss4(7,:)
ss5(7,:)
ss6(7,:)
ss7(7,:)
S(7,1)=(-.55+.75)/2;
S(7,2)=(-.6-1.2+.93)/3;
S(7,3)=(-.21-.61-1.21+0.01+1.5)/5;
S(7,4)=(-.27-.55-1.13+1.56+2.69)/5;
S(7,5)=(.23-.35-.11+3.74+4.95)/5;
S(7,6)=(2.88+1.19+3.31+9.27+10.3)/5;
S(7,7)=(26.14+31.25+18.13+8.96+25.76+35.94+36.62)/7;
S(7,8)=100;
S(7,9)=(37.7+11.39+18.85+21.57+31.92)/5;
S(7,10)=(.5-4.35+3.07+8.12)/4;
S(7,11)=(-1.32-0.3)/2;
S(7,12)=(-.96-0.14)/2;
S(7,12)=(-.65-0.51)/2;
S(7,12)=(-.28-0.83)/2;
S(7,12)=(-.96-0.14)/2;
S(7,13)=(-.65-0.51)/2;
S(7,14)=(-.28-0.83)/2;
ss1(8,:)
ss2(8,:)
ss3(8,:)
ss4(8,:)
ss5(8,:)
ss6(8,:)
ss7(8,:)
S(8,1)=(-.83+.64)/2;
S(8,2)=(-1.01-1.66+.45)/3;
S(8,3)=(-1.31-1.4-2.14-0.71+.41)/5;
S(8,4)=(-1.64-1.89-2.66-0.31+.68)/5;
S(8,5)=(-3.34-2.93-3.04-0.13+1.42)/5;
S(8,6)=(-7.18-7.18-4.61-1.08+2.2)/5;
S(8,7)=(-1.84-7.48-19.21-28.57)/5;
S(8,7)=(-1.84-7.48-19.21-28.57-11.37-19.58-10.99)/5;
S(8,8)=-100;
S(8,9)=(-25.03-29.24-19.03-11.96-13.32)/5;
S(8,10)=(-4.74-4.88-5.96-2.87)/4;
S(8,11)=(-3.93-2.87)/2;
S(8,12)=(-2.17-2.03)/2;
S(8,13)=(-1.29-1.72)/2;
S(8,14)=(-.58-1.46)/2;
ss1(9,:)
ss2(9,:)
ss3(9,:)
ss4(9,:)
ss5(9,:)
ss6(9,:)
ss7(9,:)
S(9,1)=-1.07;
S(9,2)=-1.37;
S(9,3)=(-2.6-1.89)/2;
S(9,4)=(-3.95-1.99)/2;
S(9,5)=(-6.5-4.85)/2;
S(9,6)=(-12.6-10.05)/2;
S(9,7)=(-25.78-9.05-20.11-20.27)/4;
S(9,8)=(-33.68-32.59-33.03-33.26)/4;
S(9,9)=(-18.02-4.31-19.57)/3;
S(9,10)=(-4.57-4.49)/2;
S(9,10)=(-7.93-9.22-9.26)/3;
S(9,11)=(-4.57-4.49)/2;
S(9,12)=(-2.47-3.21)/2;
S(9,13)=(-1.51-2.37)/2;
S(9,14)=(-.83-1.92)/2;
ss1(10,:)
ss2(10,:)
ss3(10,:)
ss4(10,:)
ss5(10,:)
ss6(10,:)
ss7(10,:)
S(10,1)=-1.27;
S(10,2)=-1.58;
S(10,3)=(-3.11-2.18)/2;
S(10,4)=(-4.42-3.16)/2;
S(10,5)=(-6.57-4.99)/2;
S(10,6)=(-10.56-7.94)/2;
S(10,7)=(-14.94-6.38-11.15-11.23)/4;
S(10,8)=(-15.91-11.1-15.19-10.39)/4;
S(10,9)=(-11.35-9.55-12.01)/3;
S(10,10)=(-6.5-4.98-7.52)/3;
S(10,11)=(-3.51-5.22)/2;
S(10,12)=(-2.19-3.81)/2;
S(10,13)=(-1.43-2.87)/2;
S(10,14)=(-.88-2.14)/2;
ss1(11,:)
ss2(11,:)
ss3(11,:)
ss4(11,:)
ss5(11,:)
ss6(11,:)
ss7(11,:)
S(11,1)=-1.34;
S(11,2)=-1.65;
S(11,3)=(-2.87-2.21)/2;
S(11,4)=(-3.81-2.97)/2;
S(11,5)=(-5.21-4.15)/2;
S(11,6)=(-7.22-5.56)/2;
S(11,7)=(-8.9-6.41-6.37)/3;
S(11,7)=(-8.51-8.1-7.12)/3;
S(11,7)=(-8.9-6.41-6.37)/3;
S(11,8)=(-8.51-8.1-7.12)/3;
S(11,9)=(-6.97-7.61)/2;
S(11,10)=(-5.03-5.87)/2;
S(11,11)=-4.74;
S(11,12)=-3.72;
S(11,13)=-3.02;
S(11,14)=-2.28;
ss1(12,:)
ss2(12,:)
ss3(12,:)
ss4(12,:)
ss5(12,:)
ss6(12,:)
ss7(12,:)
S(12,1)=-1.37;
S(12,2)=-1.61;
S(12,3)=(-2.68-2.04)/2;
S(12,4)=(-3.18-2.69)/2;
S(12,5)=(-3.84-3.45)/2;
S(12,6)=(-4.85-4.07)/2;
S(12,7)=(-5.35-2.33-4.53)/3;
S(12,8)=(-5.39-5.42-4.59)/3;
S(12,9)=(-4.85-5.12)/2;
S(12,10)=(-3.99-4.45)/2;
S(12,11)=-3.91;
S(12,12)=-3.27;
S(12,13)=-2.76;
S(12,14)=-2.32;
figure;imagesc(S)
figure;
subplot(12,1,1);plot(S(1,:));hold on
subplot(12,1,2);plot(S(2,:));hold on
subplot(12,1,3);plot(S(3,:));hold on
subplot(12,1,4);plot(S(4,:));hold on
subplot(12,1,5);plot(S(5,:));hold on
subplot(12,1,6);plot(S(6,:));hold on
subplot(12,1,7);plot(S(7,:));hold on
subplot(12,1,8);plot(S(8,:));hold on
subplot(12,1,9);plot(S(9,:));hold on
subplot(12,1,10);plot(S(10,:));hold on
subplot(12,1,11);plot(S(11,:));hold on
subplot(12,1,12);plot(S(12,:));hold on
figure;
plot(S(1,:));hold on
plot(S(2,:));hold on
plot(S(3,:));hold on
plot(S(4,:));hold on
plot(S(5,:));hold on
plot(S(6,:));hold on
plot(S(7,:));hold on
plot(S(8,:));hold on
plot(S(9,:));hold on
plot(S(10,:));hold on
plot(S(11,:));hold on
plot(S(12,:));hold on
figure;
plot(S(1,:));hold on
plot(S(2,:));hold on
plot(S(3,:));hold on
plot(S(4,:));hold on
plot(S(5,:));hold on
plot(S(6,:));hold on
plot(S(7,:));hold on
plot(abs(S(8,:)),'r');hold on
plot(abs(S(9,:)),'r'),;hold on
plot(abs(S(10,:)),'r');hold on
plot(abs(S(11,:)),'r');hold on
plot(abs(S(12,:)),'r');hold on
figure;imagesc(log(abs(S)))
jp=7;
kp=8;
jm=8;
km=8;
for j=1:12;
for k=1:14;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
Sthy(j,k)=((100/dp)-(100/dm));
end;
end;
figure;imagesc(log(abs(Sthy)))
figure;imagesc(log(abs(S)))
figure;imagesc(log10(abs(S)))
figure;imagesc(log10(abs(Sthy)))
figure;imagesc(log10(abs(S)))
figure;imagesc((abs(S)))
figure;imagesc((abs(Sthy)))
ssthy=Sthy;
subplot(2,4,8);imagesc(ssthy);caxis([-50 50]);hold on
sexp=S;
subplot(2,4,8);imagesc(sexp);caxis([-50 50]);hold on
subplot(12,1,1);plot(Sthy(1,:),'r');hold on
subplot(12,1,2);plot(Sthy(2,:),'r');hold on
subplot(12,1,3);plot(Sthy(3,:),'r');hold on
subplot(12,1,4);plot(Sthy(4,:),'r');hold on
subplot(12,1,5);plot(Sthy(5,:),'r');hold on
subplot(12,1,6);plot(Sthy(6,:),'r');hold on
subplot(12,1,7);plot(Sthy(7,:),'r');hold on
subplot(12,1,8);plot(Sthy(8,:),'r');hold on
subplot(12,1,9);plot(Sthy(9,:),'r');hold on
subplot(12,1,10);plot(Sthy(10,:),'r');hold on
subplot(12,1,11);plot(Sthy(11,:),'r');hold on
subplot(12,1,12);plot(Sthy(12,:),'r');hold on
% figure;subplot(2,5,1);plot(Sthy(3,:),'r');hold on
% subplot(2,5,2);plot(Sthy(4,:),'r');hold on
% subplot(2,5,3);plot(Sthy(5,:),'r');hold on
% subplot(2,5,4);plot(Sthy(6,:),'r');hold on
% subplot(2,5,5);plot(Sthy(7,:),'r');hold on
% subplot(2,5,6);plot(Sthy(12,:),'r');hold on
% subplot(2,5,7);plot(Sthy(11,:),'r');hold on
% subplot(2,5,8);plot(Sthy(10,:),'r');hold on
% subplot(2,5,9);plot(Sthy(9,:),'r');hold on
% subplot(2,5,10);plot(Sthy(8,:),'r');hold on
% subplot(2,5,1);plot(S(3,:),'b');hold on
% subplot(2,5,2);plot(S(4,:),'b');hold on
% subplot(2,5,3);plot(S(5,:),'b');hold on
% subplot(2,5,4);plot(S(6,:),'b');hold on
% subplot(2,5,5);plot(S(7,:),'b');hold on
% subplot(2,5,6);plot(S(12,:),'b');hold on
% subplot(2,5,7);plot(S(11,:),'b');hold on
% subplot(2,5,8);plot(S(10,:),'b');hold on
% subplot(2,5,9);plot(S(9,:),'b');hold on
% subplot(2,5,10);plot(S(8,:),'b');hold on
% figure;subplot(2,5,1);plot(S(3,:),'b');hold on
% subplot(2,5,2);plot(S(4,:),'b');hold on
% subplot(2,5,3);plot(S(5,:),'b');hold on
% subplot(2,5,4);plot(S(6,:),'b');hold on
% subplot(2,5,5);plot(S(7,:),'b');hold on
% subplot(2,5,6);plot(S(12,:),'b');hold on
% subplot(2,5,7);plot(S(11,:),'b');hold on
% subplot(2,5,8);plot(S(10,:),'b');hold on
% subplot(2,5,9);plot(S(9,:),'b');hold on
% subplot(2,5,10);plot(S(8,:),'b');hold on
% subplot(2,5,1);plot(Sthy(3,:),'r');hold on
% subplot(2,5,2);plot(Sthy(4,:),'r');hold on
% subplot(2,5,3);plot(Sthy(5,:),'r');hold on
% subplot(2,5,4);plot(Sthy(6,:),'r');hold on
% subplot(2,5,5);plot(Sthy(7,:),'r');hold on
% subplot(2,5,6);plot(Sthy(12,:),'r');hold on
% subplot(2,5,7);plot(Sthy(11,:),'r');hold on
% subplot(2,5,8);plot(Sthy(10,:),'r');hold on
% subplot(2,5,9);plot(Sthy(9,:),'r');hold on
% subplot(2,5,10);plot(Sthy(8,:),'r');hold on
% figure;subplot(2,5,1);plot(S(3,:),'b');hold on
% subplot(2,5,2);plot(S(4,:),'b');hold on
% subplot(2,5,3);plot(S(5,:),'b');hold on
% subplot(2,5,4);plot(S(6,:),'b');hold on
% subplot(2,5,5);plot(S(7,:),'b');hold on
% subplot(2,5,6);plot(-S(12,:),'b');hold on
% subplot(2,5,7);plot(-S(11,:),'b');hold on
% subplot(2,5,8);plot(-S(10,:),'b');hold on
% subplot(2,5,9);plot(-S(9,:),'b');hold on
% subplot(2,5,10);plot(-S(8,:),'b');hold on
% subplot(2,5,1);plot(Sthy(3,:),'r');hold on
% subplot(2,5,2);plot(Sthy(4,:),'r');hold on
% subplot(2,5,3);plot(Sthy(5,:),'r');hold on
% subplot(2,5,4);plot(Sthy(6,:),'r');hold on
% subplot(2,5,5);plot(Sthy(7,:),'r');hold on
% subplot(2,5,6);plot(-Sthy(12,:),'r');hold on
% subplot(2,5,7);plot(-Sthy(11,:),'r');hold on
% subplot(2,5,8);plot(-Sthy(10,:),'r');hold on
% subplot(2,5,9);plot(-Sthy(9,:),'r');hold on
% subplot(2,5,10);plot(-Sthy(8,:),'r');hold on
% %%
% tenby14plots
