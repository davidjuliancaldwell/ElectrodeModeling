% calculate the potential analytically using a 1 micron grid
a=0.00115;
for k=1:10001;
    x=(k-1)/1000000;
    for j=1:10001;
        z=(j)/1000000;
        x1=x+a;
        x2=x-a;
        t1=sqrt(x1^2+z^2);
        t2=sqrt(x2^2+z^2);
        V(k,j)=asin(2*a/(t1+t2));
    end;
end;

% plot the potential and the normalized potential
figure;imagesc(V')
figure;imagesc((2/pi)*(V'))

% calculate the electric field components using
% the numerical gradient of the potential
[EX,EZ]=gradient(V',1/1000000);

% plot the log of the total electric field
figure;imagesc(log10(abs(Et')))
% plot the log of the x-component of the electric field
figure;imagesc(log10(abs(Ex')))
% plot the log of the z-component of the electric field
figure;imagesc(log10(abs(Ez')))

% compare the analytic electric fields
% with the numerical electric fields
%figure;imagesc(2*(ET-Et)./(ET+Et))
%figure;imagesc(2*(EX-Ex)./(EX+Ex))
%figure;imagesc(2*(EZ-Ez)./(EY+Ez))

