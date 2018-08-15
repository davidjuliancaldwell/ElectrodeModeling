
% Fit stim 18 data
T=t18;
E=v18;
dlm=fitlm(T,E);
out2=dlm.Coefficients.Estimate(2);
>> dlm

dlm = 

Linear regression model:
    y ~ 1 + x1

Estimated Coefficients:
                   Estimate        SE          tStat         pValue  
                   _________    _________    __________    __________

    (Intercept)    3.626e-16     0.036365    9.9711e-15             1
    x1                1.1097    0.0044486        249.45    1.5494e-09


Number of observations: 6, Error degrees of freedom: 4
Root Mean Squared Error: 0.0891
R-squared: 1,  Adjusted R-Squared 1
F-statistic vs. constant model: 6.22e+04, p-value = 1.55e-09

figure;plot(T,E)
hold on;plot(T,out2*T+3.626e-16,'r')



% Fit stim 45 data
T=t45;
E=v45;
dlm=fitlm(T,E);

>> dlm

dlm = 

Linear regression model:
    y ~ 1 + x1

Estimated Coefficients:
                    Estimate        SE          tStat         pValue  
                   __________    _________    __________    __________

    (Intercept)    1.0878e-15     0.038848    2.8001e-14             1
    x1                   1.09    0.0079231        137.57    1.6747e-08


Number of observations: 6, Error degrees of freedom: 4
Root Mean Squared Error: 0.0952
R-squared: 1,  Adjusted R-Squared 1
F-statistic vs. constant model: 1.89e+04, p-value = 1.67e-08

figure;plot(T,E)
hold on;plot(T,out2*T+1.0878e-15,'r*')