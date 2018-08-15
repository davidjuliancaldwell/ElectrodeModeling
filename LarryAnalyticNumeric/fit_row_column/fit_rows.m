E=E1;T=T1;
dlm=fitlm(T,E,'Intercept', false);ddd1=dlm.Coefficients.Estimate(1);
sf(1)*ddd1

E=E2;T=T2;
dlm=fitlm(T,E,'Intercept', false);ddd2=dlm.Coefficients.Estimate(1);
sf(2)*ddd2

E=E3;T=T3;
dlm=fitlm(T,E,'Intercept', false);ddd3=dlm.Coefficients.Estimate(1);
sf(3)*ddd3

E=E4;T=T4;
dlm=fitlm(T,E,'Intercept', false);ddd4=dlm.Coefficients.Estimate(1);
sf(4)*ddd4

E=E5;T=T5;
dlm=fitlm(T,E,'Intercept', false);ddd5=dlm.Coefficients.Estimate(1);
sf(5)*ddd5

E=E6;T=T6;
dlm=fitlm(T,E,'Intercept', false);ddd6=dlm.Coefficients.Estimate(1);
sf(6)*ddd6

E=E7;T=T7;
dlm=fitlm(T,E,'Intercept', false);ddd7=dlm.Coefficients.Estimate(1);
sf(7)*ddd7


figure;plot(E1)
hold on;plot(ddd1*T1,'r')

figure;plot(E2)
hold on;plot(ddd2*T2,'r')

figure;plot(E3)
hold on;plot(ddd3*T3,'r')

figure;plot(E4)
hold on;plot(ddd4*T4,'r')

figure;plot(E5)
hold on;plot(ddd5*T5,'r')

figure;plot(E6)
hold on;plot(ddd6*T6,'r')

figure;plot(E7)
hold on;plot(ddd7*T7,'r')


%Some statistics/numbers:

%Compare the two
%.8342 .6505 .7282 .6763 .6384 1.0370 .8328  <= fit all together
%.8989 .6700 1.112 .9809 .4629 0.9075 .8522  <= mean of row-by-row fits


%fit all the electrodes together
values=[.8342 .6505 .7282 .6763 .6384 1.0370 .8328];
mean(values)
std(values)



%fit the electrodes row-by-row

v1=[0.6514 0.9399 1.0634 0.4829 0.7538 1.0256 1.1138 1.1599];
v2=[0.6090 0.7117 0.6296 0.2682 0.8128 0.7828 0.7614 0.7848];
v3=[0.6922 0.7270 0.7302 0.9120 0.9239 1.4454 1.5856 1.8778];
v4=[1.3891 1.2249 1.1379 0.9886 0.9399 0.8434 0.6492 0.6739];
v5=[-0.0912 -0.1366 -0.3085 -0.5630 -0.6915 -0.6638 -0.7077 -0.5407];
v6=[0.3019 0.7974 1.0274 1.1417 1.0787 1.1825 1.1757 0.5550];
v7=[0.8720 0.9351 0.9555 0.8034 0.7767 0.8500 1.2799 0.3450];


