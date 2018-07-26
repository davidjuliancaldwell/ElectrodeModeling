gray=[3.85 3.62 3.0 3.5 1.92 1.45 2.25 4.18 3.92 5.13 4.65 3.51];
white=[5.88 7.94 0.88 7.69 7.0 2.13 12.5 3.33 2.56 5.26 3.77 7.8 0.83 3.91];
csf=[0.56 0.64 0.61 0.56 0.65 0.6 0.48 0.57 0.56 0.80];
figure;histogram(white)
hold on;histogram(gray)
hold on;histogram(csf)
figure;histogram(white,'BinWidth',0.1)
hold on;histogram(gray,'BinWidth',0.1)
hold on;histogram(csf,'BinWidth',0.1)
figure;histogram(white,'BinWidth',0.2)
hold on;histogram(gray,'BinWidth',0.2)
hold on;histogram(csf,'BinWidth',0.2)
figure;histogram(white,'BinWidth',0.3)
hold on;histogram(gray,'BinWidth',0.3)
hold on;histogram(csf,'BinWidth',0.3)
figure;histogram(white,'BinWidth',0.5)
hold on;histogram(gray,'BinWidth',0.5)
hold on;histogram(csf,'BinWidth',0.3)
figure;histogram(white,10)
hold on;histogram(gray,10)
hold on;histogram(csf,10)

%%
gray=[3.85 3.62 3.0 3.5 1.92 1.45 2.25 4.18 3.92 5.13 4.65 3.51];
white=[5.88 7.94 0.88 7.69 7.0 2.13 12.5 3.33 2.56 5.26 3.77 7.8 0.83 3.91];
csf=[0.56 0.64 0.61 0.56 0.65 0.6 0.48 0.57 0.56 0.80];
x2=[8 8 10 13 21 35 64 98];
x3=[33 33 33 33 33 32 29 26];
grayVec = 0.5+0.02*x2
whiteVec = 0.5+0.02*x3

electrodeRhos1st7 = [4.06 3.46 1.53 5.35 2.51 3.12 2.58];
electrodeRhos2nd5 = [ 6.50 2.24 2.78 2.92 5.48];

electrodeRhos = [electrodeRhos1st7 electrodeRhos2nd5]

figure;histogram(white,'BinWidth',0.3)
hold on;histogram(gray,'BinWidth',0.3)
hold on;histogram(csf,'BinWidth',0.3)
ylabel('count')
xlabel('resistivity (ohm-m)')
legend({'white matter','gray matter','CSF'})
set(gca,'fontsize',16)
vline([min(grayVec) max(grayVec) min(whiteVec) max(whiteVec) min(electrodeRhos) max(electrodeRhos)],{'r','r','b','b','k','k'})
title('Literature values relative to theoretical values compared to experimental data')

%% version using for 2018 CNS poster 
gray=[3.85 3.62 3.0 3.5 1.92 1.45 2.25 4.18 3.92 5.13 4.65 3.51];
white=[5.88 7.94 0.88 7.69 7.0 2.13 12.5 3.33 2.56 5.26 3.77 7.8 0.83 3.91];
csf=[0.56 0.64 0.61 0.56 0.65 0.6 0.48 0.57 0.56 0.80];
x2=[8 8 10 13 21 35 64 98];
x3=[33 33 33 33 33 32 29 26];
grayVec = 0.5+0.02*x2
whiteVec = 0.5+0.02*x3

electrodeRhos1st7 = [4.06 3.46 1.53 5.35 2.51 3.12 2.58];
electrodeRhos2nd5 = [ 6.50 2.24 2.78 2.92 5.48];

electrodeRhos = [electrodeRhos1st7 electrodeRhos2nd5]

figure;
ax = axes;
hist1 = histogram(white,'BinWidth',0.3);
hold on;
hist2 = histogram(gray,'BinWidth',0.3);
hold on;
hist3 = histogram(csf,'BinWidth',0.3);
ylabel('count')
xlabel('resistivity (ohm-m)')
legend({'white matter','gray matter','CSF'})
set(gca,'fontsize',16)
vline([min(electrodeRhos) max(electrodeRhos)],{'k','k'})
high1 = highlight(ax,[min(electrodeRhos), max(electrodeRhos)],[],[180 180 180]/256);
legend([hist1,hist2,hist3,high1],{'white matter','gray matter','CSF','our contact resistance measurements'})

title('Previous resistivity values for gray matter, white matter, and CSF from the literature')

%% version 2 CNS 2018 
R=[3.77 3.21 1.42 4.96 2.33 2.89 2.39 6.02 2.08 2.71 2.88 5.34];
gray=[3.85 3.62 3.0 3.5 1.92 1.45 2.25 4.18 3.92 5.13 4.65 3.51];
white=[5.88 7.94 0.88 7.69 7.0 2.13 12.5 3.33 2.56 5.26 3.77 7.8 0.83 3.91];
csf=[0.56 0.64 0.61 0.56 0.65 0.6 0.48 0.57 0.56 0.80];
x2=[8 8 10 13 21 35 64 98];
x3=[33 33 33 33 33 32 29 26];
grayVec = 0.5+0.02*x2
whiteVec = 0.5+0.02*x3

electrodeRhos1st7 = [4.06 3.46 1.53 5.35 2.51 3.12 2.58];
electrodeRhos2nd5 = [ 6.50 2.24 2.78 2.92 5.48];

electrodeRhos = [electrodeRhos1st7 electrodeRhos2nd5]

figure;
ax = axes;
hist1 = histogram(white,'BinWidth',0.3);
hold on;
hist2 = histogram(gray,'BinWidth',0.3);
hold on;
hist3 = histogram(csf,'BinWidth',0.3);
hist4 = histogram(R,'BinWidth',0.3,'facealpha',0.4,'facecolor',[0.6 0.6 0.6]);
ylabel('count')
xlabel('resistivity (ohm-m)')
legend({'white matter','gray matter','CSF'})
set(gca,'fontsize',16)
%vline([min(electrodeRhos) max(electrodeRhos)],{'k','k'})
%high1 = highlight(ax,[min(electrodeRhos), max(electrodeRhos)],[],[180 180 180]/256);
legend([hist1,hist2,hist3,hist4],{'white matter','gray matter','CSF','our electrode resistance measurements'})

title('Previous resistivity values for gray matter, white matter, and CSF from the literature')



%%
numberStimsAll_1st7 =[
1290
1366
3246
2312
2823
1982
1650];
sum(numberStimsAll_1st7)