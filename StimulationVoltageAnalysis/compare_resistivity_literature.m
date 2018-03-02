%electrodeRhos = [4.06 3.46 1.53 5.35 2.51 3.12 2.58 6.50 2.24 2.78 2.92 5.48];
%dataFitRhos1st7=[.865 .862 .99 .866 1.001 1.252 .793 0.45167]; % these are from my distant fits for the first 7 
dataFitRhos1st7=[.865 .862 .99 .866 1.001 1.252 .793]; % these are from my distant fits for the first 7 

dataFitRhos2nd5 = [0.78 0.76 0.72 0.69 0.62];
%dataFitRhos=[.865 .862 .99 .866 1.001 1.252 .793 0.45167 1.30922 0.5892 0.62625 1.16166]; % these are from my distant fits 
%stephenrhos=[.8 .75 1. .98 .69 .76 .68];
%larryrhos=[0.8600 0.9000 1.3800 0.8800 1.1400 0.7200 0.8100];


gray = [
3.85
3.62 
2.2 
3.0  
3.5 
2.3 
1.92  
1.45   
2.25  
4.18  
3.92  
5.13 
4.65 
];

white = [
5.88 
7.94 
0.88 
7.69
7.0 
2.13
12.5
3.33   
2.56   
5.26  
3.77  
7.80  
0.83  
];

csf = [
0.56 
0.64 
0.61 
0.56 
0.65 
0.60  
0.48  
0.57  
0.56 
];

figure;
%  semilogy(dataFitRhos1st7,'-o','linewidth',2);
%  hold on
%  semilogy(dataFitRhos2nd5,'-o','linewidth',2);

 plot(dataFitRhos1st7,'-o','linewidth',2);
 hold on
 plot(dataFitRhos2nd5,'-o','linewidth',2);
 ylim([0 2.5]);

% hold on;semilogy(larryrhos,'r')
% hold on;semilogy(stephenrhos,'k')
ylabel('Apparent Resistivity (ohm - m)')
%xlabel('Subject number')
xlabel('Pair of stimulation electrodes')

grayLine = hline(gray(1),'k-');
whiteLine = hline(white(1),'-m');
csfLine = hline(csf(1),'-c');

grayLine.HandleVisibility = 'on';
whiteLine.HandleVisibility = 'on';
csfLine.HandleVisibility = 'on';
legend({'Calculated from data fits for adjacent stimulation pairs','Calculated from spacing experimental pairs','gray matter','white matter','csf'})

grayLine2 = hline(gray(2:end),'k-');
whiteLine2 = hline(white(2:end),'-m');
csfLine2 = hline(csf(2:end),'-c');
title('Apparent Resistivities compared to Reported Literature Values')
set(gca,'fontsize',14)

