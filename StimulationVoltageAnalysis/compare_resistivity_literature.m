electrodeRhos1st7 = [4.06 3.46 1.53 5.35 2.51 3.12 2.58];
electrodeRhos2nd5 = [ 6.50 2.24 2.78 2.92 5.48];
%dataFitRhos1st7=[.865 .862 .99 .866 1.001 1.252 .793 0.45167]; % these are from my distant fits for the first 7 
dataFitRhos1st7=[.865 .862 .99 .866 1.001 1.252 .793]; % these are from my distant fits for the first 7 
dataFitRhos1st7 =[0.8600 0.9000 1.3800 0.8800 1.1400 0.7200 0.8100];

dataFitRhos2nd5 = [0.78 0.76 0.72 0.69 0.62];
%dataFitRhos=[.865 .862 .99 .866 1.001 1.252 .793 0.45167 1.30922 0.5892 0.62625 1.16166]; % these are from my distant fits 
%stephenrhos=[.8 .75 1. .98 .69 .76 .68];
%larryrhos=[0.8600 0.9000 1.3800 0.8800 1.1400 0.7200 0.8100];


rho5e0cf = [0.4506    0.4103    0.4416    0.4226    0.3724    0.4745];
rho12 = [0.8318    0.6500    0.7237    0.6684    0.6511    1.0015    0.7822    0.7773    0.7773    0.7218    0.6943 0.6179];
rho18 = [0.8318    0.6500    0.7237    0.6684    0.6511    1.0015    0.7822    0.7773    0.7773    0.7218    0.6943  0.6179  0.4506    0.4103    0.4416    0.4226    0.3724    0.4745];
dataFitRhos1st7 = [0.8318    0.6500    0.7237    0.6684    0.6511    1.0015    0.7822];
dataFitRhos2nd5 = [0.7773    0.7773    0.7218    0.6943  0.6179];
rho6 = [0.4506    0.4103    0.4416    0.4226    0.3724    0.4745];


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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
%  semilogy(dataFitRhos1st7,'-o','linewidth',2);
%  hold on
%  semilogy(dataFitRhos2nd5,'-o','linewidth',2);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subaxis(1,2,2,'SpacingHoriz',0.02)
%subplot(1,2,2)
 plot(dataFitRhos1st7,'-o','linewidth',2);
 hold on
 plot(dataFitRhos2nd5,'-o','linewidth',2);
 ylim([0 2.5]);
 
 ax2 = gca;
 ax2.YAxisLocation = 'right';


% hold on;semilogy(larryrhos,'r')
% hold on;semilogy(stephenrhos,'k')
%ylabel('Apparent Resistivity (ohm - m)')
%xlabel('Subject number')
%xlabel('Measurent')

grayLine = hline(gray(1),'k-');
whiteLine = hline(white(1),'-m');
csfLine = hline(csf(1),'-c');

grayLine.HandleVisibility = 'on';
whiteLine.HandleVisibility = 'on';
csfLine.HandleVisibility = 'on';
%legend({'Calculated from data fits for adjacent stimulation pairs','Calculated from spacing experimental pairs','gray matter','white matter','csf'})


grayLine2 = hline(gray(2:end),'k-');
whiteLine2 = hline(white(2:end),'-m');
csfLine2 = hline(csf(2:end),'-c');
set(gca,'fontsize',14)

 ax2.XTick = 1:7;
 ax2.XTickLabel = 1:7;

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subaxis(1,2,1,'SpacingHoriz',0)

%subplot(1,2,1)
 ax1 = gca;

 
 plot(dataFitRhos1st7,'-o','linewidth',2);
 hold on
 plot(dataFitRhos2nd5,'-o','linewidth',2);
 plot(electrodeRhos1st7,'-o','linewidth',2);
 plot(electrodeRhos2nd5,'-o','linewidth',2);
 
 ylim([0 10]);

% hold on;semilogy(larryrhos,'r')
% hold on;semilogy(stephenrhos,'k')
ylabel('Apparent Resistivity (ohm - m)')
%xlabel('Subject number')
xlabel('Measurement')

grayLine = hline(gray(1),'k-');
whiteLine = hline(white(1),'-m');
csfLine = hline(csf(1),'-c');

grayLine.HandleVisibility = 'on';
whiteLine.HandleVisibility = 'on';
csfLine.HandleVisibility = 'on';
% 


 legend({'Calculated from data fits for adjacent stimulation pairs (7 subjects)','Calculated from spacing pairs (1 subject)',...,
     'Resistivity from contact resistance for adjacent stimulation pairs','Resistivity from contact resistance from spacing pairs',...,
     'gray matter (literature)','white matter (literature)','csf (literature'})


grayLine2 = hline(gray(2:end),'k-');
whiteLine2 = hline(white(2:end),'-m');
csfLine2 = hline(csf(2:end),'-c');
set(gca,'fontsize',14)

 ax1.XTick = 1:7;
 ax1.XTickLabel = 1:7;
 subtitle('Apparent Resistivities compared to Reported Literature Values')

