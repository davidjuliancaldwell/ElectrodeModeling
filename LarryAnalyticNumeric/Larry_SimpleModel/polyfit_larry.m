>> load('/Users/Larry/Desktop/20f8a3 data for plots/data/m2012.mat')
>> load('/Users/Larry/Desktop/20f8a3 data for plots/theory/theory2012.mat')
>> figure;plot(theory2012,m2012(1,:))
>> P=polyfit(theory2012,m2012(1,:),1);
>> yfit=P(1)*theory2012+P(2);
>> hold on;plot(theory2012,yfit,'r')
>> P(1)

ans =

   NaN

>> figure;plot(theory2012,m2012(1,:))
P=polyfit(theory2012,m2012(1,:),1);
yfit=P(1)*theory2012+P(2);
hold on;plot(theory2012,yfit,'r')
>> figure;plot(m2012(1,:))
>> hold on;plot(yfit,'r')
>> m=m2012;
>> t=theory2012;
>> fit=yfit;
>> figure;plot(m(1,:))
hold on;plot(fit,'r')
>> figure;plot(t,m(1,:))
>> hold on;plot(t,fit,'r')