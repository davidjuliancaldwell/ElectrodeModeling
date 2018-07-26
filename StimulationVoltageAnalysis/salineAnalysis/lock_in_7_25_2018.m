% 0.5 mA
% mV, degrees 
% 100 Hz 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stim between 32 and 25 
I = 0.5e-3;

% 28 29
measurements = [1.48*1e-3,-87.80];
% p+, p-,m+,m- 
distance = [3,4,4,3];
rho(1) = calculate_resistivity(measurements(1),I,distance)

% 30, 27 
measurements = [5.18*1e-3 -89.99];
% p+, p-,m+,m- 
distance = [2,5,5,2];
rho(2) = calculate_resistivity(measurements(1),I,distance)

% 31, 26 
measurements = [14.76*1e-3 -89.55];
distance = [1,6,6,1];
rho(3) = calculate_resistivity(measurements(1),I,distance)

figu11111111111111111111asurements = [8.72*1e-3,-90.74];

% p+, p-,m+,m- 
distance = [1,2,2,1];
GF = (1/distance(1) - 1/distance(2) - 1/distance(3) + 1/distance(4));
rho(3) = calculate_resistivity(measurements(1),I,distance)


% 32 25
measurements = [1.37,-90.00];

% 31 26 
measurements = [measurements; 2.79,-91.16];

% 30 27 
measurements = [measurements; 8.72,-90.74];

figure
subplot(2,1,1)
plot(measurements(:,1))
subplot(2,1,2)
plot(measurements(:,2))
