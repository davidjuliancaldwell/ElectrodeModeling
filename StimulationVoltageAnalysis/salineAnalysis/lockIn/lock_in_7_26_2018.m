
%% 100 kHz cell impedance 
% the three below are electrodes 28/29 
I = 0.18 % mA; instead of 0.5 mA 
measurement = [0.8460 -157.76]
impedance = measurement(1)/(I*1e-3) % electrode impedance 

%% 1 kHz cell impedance 
I = 0.5 % mA; instead of 0.5 mA 
measurement = [0.4616 -91.08]
impedance = measurement(1)/(I*1e-3) % electrode impedance 

%% 100 Hz
I = 0.5 % mA
measurement = [0.56 -108.46]
impedance = measurement(1)/(I*1e-3) % electrode impedance 

% mysterious electrode polarization 

%% stim @ 28/29
% look @ 25/32
% 10 Hz
I = 0.5; 
measurements = [1.22*1e-3,-90];
% 20 Hz
measurements = [1.34*1e-3,-87.91];
% 50 Hz 
measurements = [1.40*1e-3,-88];
% 100 Hz
I = 0.5 ; % mA 
measurements = [1.46*1e-3,-88];
% 200 Hz
measurements = [1.46*1e-3,-88.73];
% 500 Hz 
measurements = [1.5*1e-3,-88];
% 1000 Hz
measurements = [1.5*1e-3,-88];
% 2000 
measurements = [1.53*1e-3,nan];
% 5000 
measurements = [1.62*1e-3,-82];
% 10000 
measurements = [1.92*1e-3,-80];
% 20000 
measurements = [2.96*1e-3,-87];
% 50000
measurements = [9.16*1e-3,175];

% 100 kHz
% current goes down at 50-100 kHz 
I = 0.2; % mA 
measurements = [7.6,98.20];

