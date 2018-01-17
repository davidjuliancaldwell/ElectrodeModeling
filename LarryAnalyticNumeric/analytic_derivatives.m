h=0.001;
i0=1e-3;
rho1=0.5;
rho2=2.5;
K21=(rho2-rho1)/(rho2+rho1);
scale=(i0*rho1)/(2*pi);
x_offset=0;
z_offset=0;

for k=1:1001;
    x=x_offset+(k-1)*0.00001;
    for j=1:100;
        z=z_offset+(j-1)*0.00001;
        r=sqrt(x^2+z^2);
        
        Eox=x*scale/(x^2+z^2)^1.5;
        Eoz=z*scale/(x^2+z^2)^1.5;
        
        ex(j,k)=Eox;
        ez(j,k)=Eoz;
        
        for n=1:50;
            m=n-1;
            cx1(n)=(x*K21^(n)/((2*n*h-z)^2+x^2)^1.5);
            cx2(n)=(x*K21^(n)/((2*n*h+z)^2+x^2)^1.5);
            cz1(n)=(-(2*n*h-z)*K21^(n)/((2*n*h-z)^2+x^2)^1.5);
            cz2(n)=((2*n*h+z)*K21^(n)/((2*n*h+z)^2+x^2)^1.5);
        end;
        Cxo1=scale*sum(cx1);
        Cxo2=scale*sum(cx2);
        Czo1=scale*sum(cz1);
        Czo2=scale*sum(cz2);
        
        lookx1(j,k)=Cxo1;
        lookx2(j,k)=Cxo2;
        lookz1(j,k)=Czo1;
        lookz2(j,k)=Czo2;
        
        Ex(j,k)=Eox+Cxo1+Cxo2;
        Ez(j,k)=Eoz+Czo1+Czo2;
    end;
end;

for k=1:1001;
    x=x_offset+(k-1)*0.00001;
    for j=101:1001;
        z=z_offset+(j-1)*0.00001;
        r=sqrt(x^2+z^2);
        
        Eox=x*scale/(x^2+z^2)^1.5;
        Eoz=z*scale/(x^2+z^2)^1.5;
        
        ex(j,k)=Eox;
        ez(j,k)=Eoz;
        
        for n=1:50;
            m=n-1;
            cxb1(n)=(x*K21^(n)/((2*m*h+z)^2+x^2)^-1.5);
            cxb2(n)=(x*K21^(n)/((2*n*h+z)^2+x^2)^-1.5);
            czb1(n)=((2*m*h+z)*K21^(n)/((2*m*h+z)^2+x^2)^1.5);
            czb2(n)=((2*n*h+z)*K21^(n)/((2*n*h+z)^2+x^2)^1.5);
        end;
        
        Cxob1=scale*sum(cxb1);
        Cxob2=scale*sum(cxb2);
        Czob1=scale*sum(czb1);
        Czob2=scale*sum(czb2);
        
        lookx1(j,k)=Cxob1;
        lookx2(j,k)=Cxob2;
        lookz1(j,k)=Czob1;
        lookz2(j,k)=Czob2;
        
        Ex(j,k)=Eox+Cxob1+Cxob2;
        Ez(j,k)=Eoz+Czob1+Czob2;
    end;
end;
%%
E=sqrt(Ex.^2+Ez.^2);
figure;imagesc(E)

figure;imagesc(log10(E))

figure;plot(E,'b')

figure;plot(E(:,1))
hold on;plot(E(:,101))
hold on;plot(E(:,201))
hold on;plot(E(:,301))
hold on;plot(E(:,401))
hold on;plot(E(:,501))
hold on;plot(E(:,601))
hold on;plot(E(:,701))
hold on;plot(E(:,801))
hold on;plot(E(:,901))
hold on;plot(E(:,1001))