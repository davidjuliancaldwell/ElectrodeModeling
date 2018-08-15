%% simplest randles
% start with simplest randle's, recreate figure 5 from the following
% https://www.cei.washington.edu/wordpress/wp-content/uploads/2018/05/EIS-and-NLEIS-Wiki.pdf

Rs = 47;
Rp_1 = 467;
Cdl_1 = 860e-9;

omega = [0:1:10*1e5];
Z = Rs + Rp_1./(1+ 1i*omega*Rp_1*Cdl_1);

% make Nyquist plot
figure
subplot(2,1,1)
plot(real(Z),-imag(Z))
xlabel('real(Z)')
ylabel('- imaginary(Z)')
title('Nyquist plot')
set(gca,'fontsize',14)

% make Bode plot

subplot(2,1,2)
loglog(omega,abs(Z))
ylabel('|Z|')
xlabel('Frequency (Hz)')
title('Bode plot')
set(gca,'fontsize',14)

% looks good!

%% now do our circuit

Rs = 50; % ohms
Re_1 = 2500; % electrode
Rp_1 = 500; % polarization resistance? 
Cdl_1 = 0.1e-6; % Farads

Re_2 = 2500; 
Rp_2 = 2500; % ohms
Cdl_2 = 0.1e-6; % Farads


omega = [0:1:10*1e5]; % frequency 
Z = Rs + Re_1 + Re_2 + Rp_1./(1+ 1i*omega*Rp_1*Cdl_1) + Rp_2./(1+ 1i*omega*Rp_2*Cdl_2);

% make Nyquist plot
figure
subplot(2,1,1)
plot(real(Z),-imag(Z))
xlabel('real(Z)')
ylabel('- imaginary(Z)')
title('Nyquist plot')
set(gca,'fontsize',14)

% make Bode plot

subplot(2,1,2)
loglog(omega,abs(Z))
ylabel('|Z|')
xlabel('Frequency (Hz)')
title('Bode plot')
set(gca,'fontsize',14)