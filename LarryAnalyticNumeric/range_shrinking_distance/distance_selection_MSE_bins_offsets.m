function [MSE,subjectResiduals] = distance_selection_MSE_bins_offsets(data,theory,bins,distances,stimChans,offsets)

MSE = zeros(size(bins,1),1);
subjectResiduals = {};

count = 1;

for i=bins'
    
    indicesSelect = distances>=i(1) & distances<i(2);
    dataSelect = data(indicesSelect);
    theorySelect = theory(indicesSelect);
    theorySelect = theorySelect + offsets(count);
    
    % use MSE
    MSE(count) = (nansum((dataSelect - theorySelect).^2))/sum(~isnan(dataSelect));
    subjectResiduals{count} = dataSelect - theory(indicesSelect);
    count = count + 1;
    
end



end
