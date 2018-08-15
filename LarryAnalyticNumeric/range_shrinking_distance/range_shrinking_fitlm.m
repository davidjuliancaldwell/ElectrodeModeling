function [rhoA,MSE,subjectResiduals] = range_shrinking_fitlm(data,theory,vals,indices,numberNonNaN)

MSE = zeros(numberNonNaN,1);
subjectResiduals = zeros(numberNonNaN,64);

count = 1;
dlm=fitlm(theory,data);
rhoA(count)=dlm.Coefficients{2,1};

MSE(count) = dlm.RMSE;
count = count + 1;


for i=indices(~isnan(vals))'
    data(i) = NaN;
    
    dlm=fitlm(theory,data);
    rhoA(count)=dlm.Coefficients{2,1};
    
    MSE(count) = dlm.RMSE;
    
    count = count + 1;
    
end


end
