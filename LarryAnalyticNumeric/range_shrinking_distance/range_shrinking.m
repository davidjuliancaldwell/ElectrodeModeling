function [MSE,subjectResiduals] = range_shrinking(data,theory,vals,indices,numberNonNaN)

MSE = zeros(numberNonNaN,1);
subjectResiduals = zeros(numberNonNaN,64);
count = 1;
MSE(count) = (nansum((data - theory).^2))/sum(~isnan(data));
    count = count + 1;


for i=indices(~isnan(vals))'
    data(i) = NaN;
    
    % use MSE
    MSE(count) = (nansum((data - theory).^2))/sum(~isnan(data));
    subjectResiduals(count,:) = data - theory;
    count = count + 1;
    
end


end
