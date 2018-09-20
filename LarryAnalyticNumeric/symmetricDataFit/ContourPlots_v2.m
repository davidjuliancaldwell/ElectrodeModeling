a=0.00115;
R=0.00115;
i0=5e-3;

for n=1:200;
    rhoN=2+0.02*n;
    for m=1:200;
        rhoM=2+0.02*m;
        X(m)=rho;
        rhoA=rhoN;
        rho1=0.55;
        rho2=rhoN;
        rho3=rhoM;
        
        k1=(rho2-rho1)/(rho2+rho1);
        k2=(rho3-rho2)/(rho3+rho2);
        h1=0.0001; % 0.1 mm 
    %    h1 = 0.001; % 1mmm
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
            parfor k=1:13;
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
        out1(m,n)=norm(symmetric-thy3);
        %out2(m,n)=norm(symmetric-thyP);
    end;
end;
%%
[val,ind] = min(out1(:));
[i,j] = ind2sub([200 200],ind);
x = (1:200)*0.02 + 2;
y = (1:200)*0.02 + 2;
figure;
contour(x,y,out1,100);
hold on
h2 = plot(x(j),y(i),'*');
legend([h2],{'best fit point'})
set(gca,'fontsize',14)
title({'Best fit values for gray matter and white matter',[' resistivities for CSF thickness = ' num2str(1000*h1) ' mm']})
xlabel('gray matter resistivity (ohm-m)')
ylabel('white matter resistivity (ohm-m)')
colormap('hot')
c = colorbar
c.Label.String = 'mean square error (mV^2)'
