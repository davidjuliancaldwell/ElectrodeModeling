x=0;
a=0.00115;

for j=1:1001;
    z=(j)/100000;
    x1=x+a;
    x2=x-a;
    t1=sqrt(x1^2+z^2);
    t2=sqrt(x2^2+z^2);
    Nz=2*a*z*sqrt((t1+t2)^2);
    Dz=(t1+t2)*sqrt(-2*a^2+2*t1*t2+2*x^2+2*z^2)*t1*t2;
    Ez(j)=Nz/Dz;
    Nx=2*a*sqrt((t1+t2)^2)*(x2*t1+x1*t2);
    Dx=(t1+t2)^2*sqrt(-2*a^2+2*t1*t2+2*x^2+2*z^2)*t1*t2;
    Ex(j)=Nx/Dx;
    E(j)=sqrt(Ex(j)^2+Ez(j)^2);
end;
figure;plot(Ex);
figure;plot(Ez);
figure;plot(E);




a=0.00115;
for k=1:2001;
    x=(k-1000)/100000;
    for j=1:1001;
        z=(j)/100000;
        x1=x+a;
        x2=x-a;
        t1=sqrt(x1^2+z^2);
        t2=sqrt(x2^2+z^2);
        Nz=2*a*z*sqrt((t1+t2)^2);
        Dz=(t1+t2)*sqrt(-2*a^2+2*t1*t2+2*x^2+2*z^2)*t1*t2;
        Ez=Nz/Dz;
        Nx=2*a*sqrt((t1+t2)^2)*(x2*t1+x1*t2);
        Dx=(t1+t2)^2*sqrt(-2*a^2+2*t1*t2+2*x^2+2*z^2)*t1*t2;
        Ex=Nx/Dx;
        E2(k,j)=sqrt((Ex)^2+(Ez)^2);
    end;
end;

figure;imagesc(log10(E2'))

figure;plot(E2(1000,:))
hold on;plot(E2(1100,:),'r')
hold on;plot(E2(1200,:),'g')
hold on;plot(E2(1300,:),'c')
hold on;plot(E2(1400,:),'m')
hold on;plot(E2(1115,:),'k')