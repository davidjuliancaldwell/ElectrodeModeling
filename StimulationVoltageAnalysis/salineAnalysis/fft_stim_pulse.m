%% FFT of stim pulse 7-25-2018
% 1.2 ms pulse
for j=1:1201;bipolar(j)=1;end;
for j=1202:2402;bipolar(j)=-1;end;
for j=2403:1000000;bipolar(j)=0;end;

fs = 1000000;
t = 1e3*(0:length(bipolar)-1)/fs;

T = 1/fs;
L = size(bipolar,2);

Y = fft(bipolar);
P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:floor(L/2))/L;


figure;plot(t,bipolar)
ylabel('signal')
xlabel('time (ms)')

figure;plot(f,P1)
ylabel('power (abs(FFT))')
xlabel('frequency (Hz)')

%%
% now add 0's to beginning
for j=1:1201;bipolar(j)=0;end;
for j=1202:2402;bipolar(j)=1;end;
for j=2403:3604;bipolar(j)=-1;end;
    for j = 3605:1000000;bipolar(j)=0;end;

fs = 1000000;
t = 1e3*(0:length(bipolar)-1)/fs;

T = 1/fs;
L = size(bipolar,2);

Y = fft(bipolar);
P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:floor(L/2))/L;


figure;plot(t,bipolar)
ylabel('signal')
xlabel('time (ms)')

figure;plot(f,P1)
ylabel('power (abs(FFT))')
xlabel('frequency (Hz)')

%%
% now add many more 0's to beginning
for j=1:499999;bipolar(j)=0;end;
for j=500000:501200;bipolar(j)=1;end;
for j=501201:502402;bipolar(j)=-1;end;
    for j = 502403:1000000;bipolar(j)=0;end;

fs = 1000000;
t = 1e3*(0:length(bipolar)-1)/fs;

T = 1/fs;
L = size(bipolar,2);

Y = fft(bipolar);
P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:floor(L/2))/L;


figure;plot(t,bipolar)
ylabel('signal')
xlabel('time (ms)')

figure;plot(f,P1)
ylabel('power (abs(FFT))')
xlabel('frequency (Hz)')