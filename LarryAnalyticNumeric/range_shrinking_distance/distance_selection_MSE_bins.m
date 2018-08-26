function [MSE,subjectResiduals] = distance_selection_MSE_bins(data,theory,bins,distances,stimChans)

MSE = zeros(size(bins,1),1);
subjectResiduals = {};

count = 1;

for i=bins'
    
    indicesSelect = distances>=i(1) & distances<i(2);
    dataSelect = data(indicesSelect);
    
    % use MSE
    MSE(count) = (nansum((dataSelect - theory(indicesSelect)).^2))/sum(~isnan(dataSelect));
    subjectResiduals{count} = data - theory;
    count = count + 1;
    
end



end
