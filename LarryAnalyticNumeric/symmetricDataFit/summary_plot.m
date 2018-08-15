x1=[0.1 0.2 0.5 1 2 3 4 5];
x2=[8 8 10 13 21 35 64 98];
x3=[33 33 33 33 33 32 29 26];
figure;plot(x1,0.5+0.02*x2,'o-','linewidth',2)
hold on;plot(x1,0.5+0.02*x3,'o-','color','r','linewidth',2)
xlabel('csf thickness (mm)')
ylabel('resistivity (ohm-m)')
legend({'gray matter','white matter'})
set(gca,'fontsize',14)
title('Resistivity of cortical layers as a function of CSF thickness')
