%and babies can safely sleep thru the night


%I used the matlab rms function to extract the rms voltages from the 1 mA stim 2829 data

for j=1:64;out2(j)=rms(Sdata(199000:200000,j));end

% I calculated the theoretical predictions for point electrodes yesterday

% stim 2829
i0=1e-3;
rhoA=1;
jp=4;
kp=4;
jm=4;
km=5;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
% Calculate voltages for 1-layer point-electrodes
scaleA=(i0*rhoA)/(2*pi);
t2829(j,k)=scaleA*((100/dp)-(100/dm));
end;
end;



%I found that the thy and exp agreed if I multiplied the rms values by 2*2*sqrt(2)

% “hand plot”
figure;plot(abs(1000*t2829(1,1:8)),4*sqrt(2)*1000*out2(1:8),'b*')
hold on;plot(abs(1000*t2829(2,1:8)),4*sqrt(2)*1000*out2(9:16),'r*')
hold on;plot(abs(1000*t2829(3,1:8)),4*sqrt(2)*1000*out2(17:24),'g*')
hold on;plot(abs(1000*t2829(4,1:8)),4*sqrt(2)*1000*out2(25:32),'c*')
hold on;plot(abs(1000*t2829(5,1:8)),4*sqrt(2)*1000*out2(33:40),'bo')
hold on;plot(abs(1000*t2829(6,1:8)),4*sqrt(2)*1000*out2(41:48),'ro')
hold on;plot(abs(1000*t2829(7,1:8)),4*sqrt(2)*1000*out2(49:56),'go')
%hold on;plot(abs(1000*t2829(8,1:8)),4*sqrt(2)*1000*out2(57:64),'co’)








%Now 2*sqrt(2) is the factor that converts rms voltages into peak-to-peak voltages (for sine waves)

%The extra factor of two is because the theory is for 4-point arrays and is the difference between
%the two voltage electrodes. This is twice as big as what we measure.

%Putting it all together, and doing the fit:

% “fit thy”

T=abs(0.5*reshape(t2829',[1,64]));
E=abs(2*sqrt(2)*out2);
T(28)=0;
T(29)=0;
E(28)=0;
E(29)=0;
figure;plot(T,E)
P=polyfit(T,E,1);
yfit1=P(1)*T+P(2);
hold on;plot(T,yfit1,'r')


%>> P

%P =

%    1.0523   -0.0000




