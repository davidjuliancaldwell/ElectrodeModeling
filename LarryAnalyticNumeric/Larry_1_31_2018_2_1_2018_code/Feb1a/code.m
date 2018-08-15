clear all
close all
load('all12.mat')

% 1 0b5a2e
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
        Dp1(j,k)=dp;
        Dm1(j,k)=dm;
    end;
end;
E1=m0b5a2e;
T1=reshape(theory1',[64,1]);
DP1=reshape(Dp1',[64,1]);
DM1=reshape(Dm1',[64,1]);


% 2 702d24
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
        theory2(j,k)=((100/dp)-(100/dm));
        Dp2(j,k)=dp;
        Dm2(j,k)=dm;
    end;
end;
E2=m702d24;
T2=reshape(theory2',[64,1]);
DP2=reshape(Dp2',[64,1]);
DM2=reshape(Dm2',[64,1]);

% 3 7dbdec
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
        theory3(j,k)=((100/dp)-(100/dm));
        Dp3(j,k)=dp;
        Dm3(j,k)=dm;
    end;
end;
E3=m7dbdec;
T3=reshape(theory3',[64,1]);
DP3=reshape(Dp3',[64,1]);
DM3=reshape(Dm3',[64,1]);

% 4 9ab7ab
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
        theory4(j,k)=((100/dp)-(100/dm));
        Dp4(j,k)=dp;
        Dm4(j,k)=dm;
    end;
end;
E4=m9ab7ab;
T4=reshape(theory4',[64,1]);
DP4=reshape(Dp4',[64,1]);
DM4=reshape(Dm4',[64,1]);

% 5 c91479
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
        theory5(j,k)=((100/dp)-(100/dm));
        Dp5(j,k)=dp;
        Dm5(j,k)=dm;
    end;
end;
E5=mc91479;
T5=reshape(theory5',[64,1]);
DP5=reshape(Dp5',[64,1]);
DM5=reshape(Dm5',[64,1]);

% 6 d5cd55
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
        theory6(j,k)=((100/dp)-(100/dm));
        Dp6(j,k)=dp;
        Dm6(j,k)=dm;
    end;
end;
E6=md5cd55;
T6=reshape(theory6',[64,1]);
DP6=reshape(Dp6',[64,1]);
DM6=reshape(Dm6',[64,1]);

% 7 ecb43e
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
        theory7(j,k)=((100/dp)-(100/dm));
        Dp7(j,k)=dp;
        Dm7(j,k)=dm;
    end;
end;
E7=mecb43e;
T7=reshape(theory7',[64,1]);
DP7=reshape(Dp7',[64,1]);
DM7=reshape(Dm7',[64,1]);

figure;
subplot(2,3,1);plot(DP1,E1);hold on;
subplot(2,3,2);plot(DM1,E1);hold on;
subplot(2,3,4);plot(DP1,T1);hold on;
subplot(2,3,5);plot(DM1,T1);hold on;
subplot(2,3,3);plot(DP1,E1,'bo');hold on;
subplot(2,3,3);plot(DM1,E1,'ro');hold on;
subplot(2,3,6);plot(DP1,T1,'bo');hold on;
subplot(2,3,6);plot(DM1,T1,'ro');hold on;

figure;
subplot(2,3,1);plot(DP2,E2);hold on;
subplot(2,3,2);plot(DM2,E2);hold on;
subplot(2,3,4);plot(DP2,T2);hold on;
subplot(2,3,5);plot(DM2,T2);hold on;
subplot(2,3,3);plot(DP2,E2,'bo');hold on;
subplot(2,3,3);plot(DM2,E2,'ro');hold on;
subplot(2,3,6);plot(DP2,T2,'bo');hold on;
subplot(2,3,6);plot(DM2,T2,'ro');hold on;

figure;
subplot(2,3,1);plot(DP3,E3);hold on;
subplot(2,3,2);plot(DM3,E3);hold on;
subplot(2,3,4);plot(DP3,T3);hold on;
subplot(2,3,5);plot(DM3,T3);hold on;
subplot(2,3,3);plot(DP3,E3,'bo');hold on;
subplot(2,3,3);plot(DM3,E3,'ro');hold on;
subplot(2,3,6);plot(DP3,T3,'bo');hold on;
subplot(2,3,6);plot(DM3,T3,'ro');hold on;

figure;
subplot(2,3,1);plot(DP4,E4);hold on;
subplot(2,3,2);plot(DM4,E4);hold on;
subplot(2,3,4);plot(DP4,T4);hold on;
subplot(2,3,5);plot(DM4,T4);hold on;
subplot(2,3,3);plot(DP4,E4,'bo');hold on;
subplot(2,3,3);plot(DM4,E4,'ro');hold on;
subplot(2,3,6);plot(DP4,T4,'bo');hold on;
subplot(2,3,6);plot(DM4,T4,'ro');hold on;

figure;
subplot(2,3,1);plot(DP5,E5);hold on;
subplot(2,3,2);plot(DM5,E5);hold on;
subplot(2,3,4);plot(DP5,T5);hold on;
subplot(2,3,5);plot(DM5,T5);hold on;
subplot(2,3,3);plot(DP5,E5,'bo');hold on;
subplot(2,3,3);plot(DM5,E5,'ro');hold on;
subplot(2,3,6);plot(DP5,T5,'bo');hold on;
subplot(2,3,6);plot(DM5,T5,'ro');hold on;

figure;
subplot(2,3,1);plot(DP6,E6);hold on;
subplot(2,3,2);plot(DM6,E6);hold on;
subplot(2,3,4);plot(DP6,T6);hold on;
subplot(2,3,5);plot(DM6,T6);hold on;
subplot(2,3,3);plot(DP6,E6,'bo');hold on;
subplot(2,3,3);plot(DM6,E6,'ro');hold on;
subplot(2,3,6);plot(DP6,T6,'bo');hold on;
subplot(2,3,6);plot(DM6,T6,'ro');hold on;

figure;
subplot(2,3,1);plot(DP7,E7);hold on;
subplot(2,3,2);plot(DM7,E7);hold on;
subplot(2,3,4);plot(DP7,T7);hold on;
subplot(2,3,5);plot(DM7,T7);hold on;
subplot(2,3,3);plot(DP7,E7,'bo');hold on;
subplot(2,3,3);plot(DM7,E7,'ro');hold on;
subplot(2,3,6);plot(DP7,T7,'bo');hold on;
subplot(2,3,6);plot(DM7,T7,'ro');hold on;
%%
figure;
plot(DP1(1:8),E1(1:8)./(T1(1:8).*DP1(1:8)),'b');hold on;
plot(DM1(1:8),E1(1:8)./(T1(1:8).*DM1(1:8)),'g');hold on;
plot(DP1(1:8),(2e-4*T1(1:8)./(T1(1:8).*DP1(1:8))-0.1e-4),'r');hold on;
plot(DM1(1:8),(2e-4*T1(1:8)./(T1(1:8).*DM1(1:8))-0.1e-4),'k');hold on;