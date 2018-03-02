load('theory2012.mat')
load('m2012.mat')
scale_factor = 0.0025/50;

theory2012 = scale_factor*theory2012;
P=polyfit(theory2012(theory2012~=inf & theory2012~=-inf),m2012(1,~isnan(m2012(1,:))),1);
yfit=P(1)*theory2012(theory2012~=inf & theory2012~=-inf)+P(2);
yresid = yfit - m2012(1,~isnan(m2012(1,:)));
SSresid = sum(yresid.^2);
SStotal = (length(m2012(1,~isnan(m2012(1,:))))-1)*var(m2012(1,~isnan(m2012(1,:))));
rsq = 1 - SSresid/SStotal;

%%
figure;plot(theory2012(theory2012~=inf & theory2012~=-inf),m2012(1,~isnan(m2012(1,:))),'o')

hold on;plot(theory2012(theory2012~=inf & theory2012~=-inf),yfit,'r')
title('Comparison between theoretical prediction and measured values')
xlabel('Theoretical prediction in \muV')
ylabel('Measured values in \muV')
text(0.1e-3,-0.1e-3,['R-squared value = ' num2str(rsq)],'FontSize',14)
set(gca,'fontsize', 14)
%%
axis = [1:32];
axis(12) = nan;
axis(20) = nan;
figure;plot(m2012(1,:),'-o')
yfit=P(1)*theory2012+P(2);
hold on;plot(yfit,'-or');
xlabel('Electrode')
ylabel('Voltage (\muV)')
title('Comparison of linear fit and measured values')
legend('Measured values','Linear fit')
set(gca,'fontsize', 14)

%%


figure;plot(theory2012,m2012(1,:))
P=polyfit(theory2012,m2012(1,:),1);
yfit=P(1)*theory2012+P(2);
hold on;plot(theory2012,yfit,'r')
P(1)


figure;plot(theory2012,m2012(1,:))
P=polyfit(theory2012,m2012(1,:),1);
yfit=P(1)*theory2012+P(2);
hold on;plot(theory2012,yfit,'r')
figure;plot(m2012(1,:))
hold on;plot(yfit,'r')
m=m2012;
t=theory2012;
fit=yfit;
figure;plot(m(1,:))
hold on;plot(fit,'r')
figure;plot(t,m(1,:))
hold on;plot(t,fit,'r')