figure;

E=E1;
T=T1;
subject=1;
sc=sf(1);

e=E(1:8:57);t=T(1:8:57);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(1)=sc*ddd1;
subplot(2,4,subject);plot(1:8,e);hold on
subplot(2,4,subject);plot(1:8,ddd1*t,'r');hold on

e=E(2:8:58);t=T(2:8:58);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(2)=sc*ddd1;
subplot(2,4,subject);plot(9:16,e);hold on
subplot(2,4,subject);plot(9:16,ddd1*t,'r');hold on

e=E(3:8:59);t=T(3:8:59);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(3)=sc*ddd1;
subplot(2,4,subject);plot(17:24,e);hold on
subplot(2,4,subject);plot(17:24,ddd1*t,'r');hold on

e=E(4:8:60);t=T(4:8:60);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(4)=sc*ddd1;
subplot(2,4,subject);plot(25:32,e);hold on
subplot(2,4,subject);plot(25:32,ddd1*t,'r');hold on

e=E(5:8:61);t=T(5:8:61);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(5)=sc*ddd1;
subplot(2,4,subject);plot(33:40,e);hold on
subplot(2,4,subject);plot(33:40,ddd1*t,'r');hold on

e=E(6:8:62);t=T(6:8:62);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(6)=sc*ddd1;
subplot(2,4,subject);plot(41:48,e);hold on
subplot(2,4,subject);plot(41:48,ddd1*t,'r');hold on

e=E(7:8:63);t=T(7:8:63);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(7)=sc*ddd1;
subplot(2,4,subject);plot(49:56,e);hold on
subplot(2,4,subject);plot(49:56,ddd1*t,'r');hold on

e=E(8:8:64);t=T(8:8:64);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(8)=sc*ddd1;
subplot(2,4,subject);plot(57:64,e);hold on
subplot(2,4,subject);plot(57:64,ddd1*t,'r');hold on

c1=v;





E=E2;
T=T2;
subject=2;
sc=sf(2);

e=E(1:8:57);t=T(1:8:57);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(1)=sc*ddd1;
subplot(2,4,subject);plot(1:8,e);hold on
subplot(2,4,subject);plot(1:8,ddd1*t,'r');hold on

e=E(2:8:58);t=T(2:8:58);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(2)=sc*ddd1;
subplot(2,4,subject);plot(9:16,e);hold on
subplot(2,4,subject);plot(9:16,ddd1*t,'r');hold on

e=E(3:8:59);t=T(3:8:59);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(3)=sc*ddd1;
subplot(2,4,subject);plot(17:24,e);hold on
subplot(2,4,subject);plot(17:24,ddd1*t,'r');hold on

e=E(4:8:60);t=T(4:8:60);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(4)=sc*ddd1;
subplot(2,4,subject);plot(25:32,e);hold on
subplot(2,4,subject);plot(25:32,ddd1*t,'r');hold on

e=E(5:8:61);t=T(5:8:61);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(5)=sc*ddd1;
subplot(2,4,subject);plot(33:40,e);hold on
subplot(2,4,subject);plot(33:40,ddd1*t,'r');hold on

e=E(6:8:62);t=T(6:8:62);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(6)=sc*ddd1;
subplot(2,4,subject);plot(41:48,e);hold on
subplot(2,4,subject);plot(41:48,ddd1*t,'r');hold on

e=E(7:8:63);t=T(7:8:63);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(7)=sc*ddd1;
subplot(2,4,subject);plot(49:56,e);hold on
subplot(2,4,subject);plot(49:56,ddd1*t,'r');hold on

e=E(8:8:64);t=T(8:8:64);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(8)=sc*ddd1;
subplot(2,4,subject);plot(57:64,e);hold on
subplot(2,4,subject);plot(57:64,ddd1*t,'r');hold on

c2=v;





E=E3;
T=T3;
subject=3;
sc=sf(3);

e=E(1:8:57);t=T(1:8:57);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(1)=sc*ddd1;
subplot(2,4,subject);plot(1:8,e);hold on
subplot(2,4,subject);plot(1:8,ddd1*t,'r');hold on

e=E(2:8:58);t=T(2:8:58);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(2)=sc*ddd1;
subplot(2,4,subject);plot(9:16,e);hold on
subplot(2,4,subject);plot(9:16,ddd1*t,'r');hold on

e=E(3:8:59);t=T(3:8:59);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(3)=sc*ddd1;
subplot(2,4,subject);plot(17:24,e);hold on
subplot(2,4,subject);plot(17:24,ddd1*t,'r');hold on

e=E(4:8:60);t=T(4:8:60);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(4)=sc*ddd1;
subplot(2,4,subject);plot(25:32,e);hold on
subplot(2,4,subject);plot(25:32,ddd1*t,'r');hold on

e=E(5:8:61);t=T(5:8:61);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(5)=sc*ddd1;
subplot(2,4,subject);plot(33:40,e);hold on
subplot(2,4,subject);plot(33:40,ddd1*t,'r');hold on

e=E(6:8:62);t=T(6:8:62);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(6)=sc*ddd1;
subplot(2,4,subject);plot(41:48,e);hold on
subplot(2,4,subject);plot(41:48,ddd1*t,'r');hold on

e=E(7:8:63);t=T(7:8:63);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(7)=sc*ddd1;
subplot(2,4,subject);plot(49:56,e);hold on
subplot(2,4,subject);plot(49:56,ddd1*t,'r');hold on

e=E(8:8:64);t=T(8:8:64);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(8)=sc*ddd1;
subplot(2,4,subject);plot(57:64,e);hold on
subplot(2,4,subject);plot(57:64,ddd1*t,'r');hold on

c3=v;





E=E4;
T=T4;
subject=4;
sc=sf(4);

e=E(1:8:57);t=T(1:8:57);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(1)=sc*ddd1;
subplot(2,4,subject);plot(1:8,e);hold on
subplot(2,4,subject);plot(1:8,ddd1*t,'r');hold on

e=E(2:8:58);t=T(2:8:58);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(2)=sc*ddd1;
subplot(2,4,subject);plot(9:16,e);hold on
subplot(2,4,subject);plot(9:16,ddd1*t,'r');hold on

e=E(3:8:59);t=T(3:8:59);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(3)=sc*ddd1;
subplot(2,4,subject);plot(17:24,e);hold on
subplot(2,4,subject);plot(17:24,ddd1*t,'r');hold on

e=E(4:8:60);t=T(4:8:60);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(4)=sc*ddd1;
subplot(2,4,subject);plot(25:32,e);hold on
subplot(2,4,subject);plot(25:32,ddd1*t,'r');hold on

e=E(5:8:61);t=T(5:8:61);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(5)=sc*ddd1;
subplot(2,4,subject);plot(33:40,e);hold on
subplot(2,4,subject);plot(33:40,ddd1*t,'r');hold on

e=E(6:8:62);t=T(6:8:62);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(6)=sc*ddd1;
subplot(2,4,subject);plot(41:48,e);hold on
subplot(2,4,subject);plot(41:48,ddd1*t,'r');hold on

e=E(7:8:63);t=T(7:8:63);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(7)=sc*ddd1;
subplot(2,4,subject);plot(49:56,e);hold on
subplot(2,4,subject);plot(49:56,ddd1*t,'r');hold on

e=E(8:8:64);t=T(8:8:64);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(8)=sc*ddd1;
subplot(2,4,subject);plot(57:64,e);hold on
subplot(2,4,subject);plot(57:64,ddd1*t,'r');hold on

c4=v;





E=E5;
T=T5;
subject=5;
sc=sf(5);

e=E(1:8:57);t=T(1:8:57);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(1)=sc*ddd1;
subplot(2,4,subject);plot(1:8,e);hold on
subplot(2,4,subject);plot(1:8,ddd1*t,'r');hold on

e=E(2:8:58);t=T(2:8:58);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(2)=sc*ddd1;
subplot(2,4,subject);plot(9:16,e);hold on
subplot(2,4,subject);plot(9:16,ddd1*t,'r');hold on

e=E(3:8:59);t=T(3:8:59);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(3)=sc*ddd1;
subplot(2,4,subject);plot(17:24,e);hold on
subplot(2,4,subject);plot(17:24,ddd1*t,'r');hold on

e=E(4:8:60);t=T(4:8:60);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(4)=sc*ddd1;
subplot(2,4,subject);plot(25:32,e);hold on
subplot(2,4,subject);plot(25:32,ddd1*t,'r');hold on

e=E(5:8:61);t=T(5:8:61);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(5)=sc*ddd1;
subplot(2,4,subject);plot(33:40,e);hold on
subplot(2,4,subject);plot(33:40,ddd1*t,'r');hold on

e=E(6:8:62);t=T(6:8:62);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(6)=sc*ddd1;
subplot(2,4,subject);plot(41:48,e);hold on
subplot(2,4,subject);plot(41:48,ddd1*t,'r');hold on

e=E(7:8:63);t=T(7:8:63);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(7)=sc*ddd1;
subplot(2,4,subject);plot(49:56,e);hold on
subplot(2,4,subject);plot(49:56,ddd1*t,'r');hold on

e=E(8:8:64);t=T(8:8:64);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(8)=sc*ddd1;
subplot(2,4,subject);plot(57:64,e);hold on
subplot(2,4,subject);plot(57:64,ddd1*t,'r');hold on

c5=v;





E=E6;
T=T6;
subject=6;
sc=sf(6);

e=E(1:8:57);t=T(1:8:57);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(1)=sc*ddd1;
subplot(2,4,subject);plot(1:8,e);hold on
subplot(2,4,subject);plot(1:8,ddd1*t,'r');hold on

e=E(2:8:58);t=T(2:8:58);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(2)=sc*ddd1;
subplot(2,4,subject);plot(9:16,e);hold on
subplot(2,4,subject);plot(9:16,ddd1*t,'r');hold on

e=E(3:8:59);t=T(3:8:59);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(3)=sc*ddd1;
subplot(2,4,subject);plot(17:24,e);hold on
subplot(2,4,subject);plot(17:24,ddd1*t,'r');hold on

e=E(4:8:60);t=T(4:8:60);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(4)=sc*ddd1;
subplot(2,4,subject);plot(25:32,e);hold on
subplot(2,4,subject);plot(25:32,ddd1*t,'r');hold on

e=E(5:8:61);t=T(5:8:61);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(5)=sc*ddd1;
subplot(2,4,subject);plot(33:40,e);hold on
subplot(2,4,subject);plot(33:40,ddd1*t,'r');hold on

e=E(6:8:62);t=T(6:8:62);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(6)=sc*ddd1;
subplot(2,4,subject);plot(41:48,e);hold on
subplot(2,4,subject);plot(41:48,ddd1*t,'r');hold on

e=E(7:8:63);t=T(7:8:63);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(7)=sc*ddd1;
subplot(2,4,subject);plot(49:56,e);hold on
subplot(2,4,subject);plot(49:56,ddd1*t,'r');hold on

e=E(8:8:64);t=T(8:8:64);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(8)=sc*ddd1;
subplot(2,4,subject);plot(57:64,e);hold on
subplot(2,4,subject);plot(57:64,ddd1*t,'r');hold on

c6=v;





E=E7;
T=T7;
subject=7;
sc=sf(7);

e=E(1:8:57);t=T(1:8:57);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(1)=sc*ddd1;
subplot(2,4,subject);plot(1:8,e);hold on
subplot(2,4,subject);plot(1:8,ddd1*t,'r');hold on

e=E(2:8:58);t=T(2:8:58);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(2)=sc*ddd1;
subplot(2,4,subject);plot(9:16,e);hold on
subplot(2,4,subject);plot(9:16,ddd1*t,'r');hold on

e=E(3:8:59);t=T(3:8:59);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(3)=sc*ddd1;
subplot(2,4,subject);plot(17:24,e);hold on
subplot(2,4,subject);plot(17:24,ddd1*t,'r');hold on

e=E(4:8:60);t=T(4:8:60);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(4)=sc*ddd1;
subplot(2,4,subject);plot(25:32,e);hold on
subplot(2,4,subject);plot(25:32,ddd1*t,'r');hold on

e=E(5:8:61);t=T(5:8:61);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(5)=sc*ddd1;
subplot(2,4,subject);plot(33:40,e);hold on
subplot(2,4,subject);plot(33:40,ddd1*t,'r');hold on

e=E(6:8:62);t=T(6:8:62);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(6)=sc*ddd1;
subplot(2,4,subject);plot(41:48,e);hold on
subplot(2,4,subject);plot(41:48,ddd1*t,'r');hold on

e=E(7:8:63);t=T(7:8:63);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(7)=sc*ddd1;
subplot(2,4,subject);plot(49:56,e);hold on
subplot(2,4,subject);plot(49:56,ddd1*t,'r');hold on

e=E(8:8:64);t=T(8:8:64);
dlm=fitlm(t,e,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
v(8)=sc*ddd1;
subplot(2,4,subject);plot(57:64,e);hold on
subplot(2,4,subject);plot(57:64,ddd1*t,'r');hold on

c7=v;