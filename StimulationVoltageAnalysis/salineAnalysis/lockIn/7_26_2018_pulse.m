%% stim @ 28/29, 
% these are with a delay between the two of them 
% 3 ms delay 
% these two here are wonky 
% voltages recorded - +/-, so + 1 V, - 1 V 

% record @ 30/27
I = 1/1e3;
% measurement in V 
measurement(1) = 1;

% record @ 31/26
measurement(2) = 0.2;
%% recording electrode 
% now we are talking 
% record @ 30/27
measurement(1) = 0.75;

% record @ 31/26 
measurement(2) = 0.2;

% record @ 25/32
measurement(3) = 0.1;

% have to divide the measurement by 5 since the princeton applied research
% pre amp has a gain of 5 
measurement = measurement/5

%% contact measurement 
% 28/29 drive voltage (V)
cM = 7;
%%
measurement/cM

% 32 25
% p+, p-,m+,m- 
% distance in cm
distance = [3,4,4,3]; 
rho(3) = calculate_resistivity(measurement(3),I,distance);

% 31 26 
% p+, p-,m+,m- 
% distance in cm
distance = [2,3,3,2]; 
rho(2) = calculate_resistivity(measurement(2),I,distance);

% 30 27 
% p+, p-,m+,m- 
% distance in cm
distance = [1,2,2,1]; 
rho(1) = calculate_resistivity(measurement(1),I,distance);

rho

%%
% remove space between pulses 
cM = 7.5;

% looking at the current, it looks like the discharge takes more current
% than the charge 
% large DC offset as well 