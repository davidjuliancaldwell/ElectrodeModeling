function [MSE,subjectResiduals] = distance_selection_MSE(data,theory,stimChans,distancesSorted,indicesSorted)

MSE = zeros(sum(~isnan(data)),1);
subjectResiduals = zeros(sum(~isnan(data)),length(data));
count = 1;
MSE(count) = (nansum((data - theory).^2))/sum(~isnan(data));
    count = count + 1;


for i=indicesSorted(all(indicesSorted~=stimChans,2))'
    data(i) = NaN;
    
    % use MSE
    MSE(count) = (nansum((data - theory).^2))/sum(~isnan(data));
    subjectResiduals(count,:) = data - theory;
    count = count + 1;
    
end



end
