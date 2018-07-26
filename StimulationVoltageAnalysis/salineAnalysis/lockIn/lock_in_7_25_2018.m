% 0.5 mA
% mV, degrees 
% 100 Hz 
% first in "measurements" is voltage in V, second is degree of phase
% recorded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% stimulation between 32 and 25 
I = 0.5e-3; % current in A

% measured 28 29
measurements = [1.48*1e-3,-87.80];
% p+, p-,m+,m- 
% distance in cm
distance = [3,4,4,3]; 
rho(1) = calculate_resistivity(measurements(1),I,distance);

% 30, 27 
measurements = [5.18*1e-3 -89.99];
% p+, p-,m+,m- 
distance = [2,5,5,2];
rho(2) = calculate_resistivity(measurements(1),I,distance);

% 31, 26 
measurements = [14.76*1e-3 -89.55];
distance = [1,6,6,1];
rho(3) = calculate_resistivity(measurements(1),I,distance);
rho
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% stimulation between 28 and 29 



% 32 25
measurements = [1.37*1e-3,-90.00];
% p+, p-,m+,m- 
% distance in cm
distance = [3,4,4,3]; 
rho(1) = calculate_resistivity(measurements(1),I,distance);

% 31 26 
measurements = [2.79*1e-3,-91.16];
% p+, p-,m+,m- 
% distance in cm
distance = [2,3,3,2]; 
rho(2) = calculate_resistivity(measurements(1),I,distance);

% 30 27 
measurements = [8.72*1e-3,-90.74];
% p+, p-,m+,m- 
% distance in cm
distance = [1,2,2,1]; 
rho(3) = calculate_resistivity(measurements(1),I,distance);

rho
%% contact resistances 
% first entry is volts, second is in degrees 
%% 32 25
measurements = [0.6596,-118.63];

%% 31 26
measurements = [0.6500,-123.16];

%% 30 27
measurements = [0.6502,-119.42];

%% 29 28
measurements = [0.6275,-125.13];
