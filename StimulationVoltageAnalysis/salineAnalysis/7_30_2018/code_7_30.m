% Look at the 1 mA sine wave stim 2829 data

load('/Users/imac2/Desktop/july 30 measurements/MATLABconverted 2/sine_wave/stimGeometrySineWave-5.mat')

Sdata= [ECO1.data ECO2.data(:,1:31)];

figure;for j=25:32;subplot(8,1,j-24);plot(Sdata(:,j));hold on;end

% Extract the peak amplitudes of the sine wave responses for e25-e32 from the plots

s1=[.3363
.676
2.11
-2.16
-.69
-.36];

s2=[-.345
-.687
-2.13
2.15
.679
.34];


% Look at the 1 mA pulse stim 2829 data

load('/Users/imac2/Desktop/july 30 measurements/MATLABconverted 2/pulses/stimGeometry-7.mat')

Pdata=[ECO1.data ECO2.data(:,1:24)];

figure;for j=25:32;subplot(8,1,j-24);plot(Pdata(:,j));hold on;end

% Extract the peak amplitudes of the pulse response for e25-e32 from the plots

p1=[-.3333
-.6703
-2.11
2.15
.6924
.3575];

p2=[.3394
.6851
2.15
-2.18
-.7043
-.3592];


% Compare the pulse and sine data

figure;plot(p1,p2)
hold on;plot(s1,s2,'r')



% Compare the pulse and sine data with the theory

figure;plot(t,p1,'bo')
hold on;plot(t,-p2,'b*')
hold on;plot(t,-s1,'ro')
hold on;plot(t,s2,'r*')