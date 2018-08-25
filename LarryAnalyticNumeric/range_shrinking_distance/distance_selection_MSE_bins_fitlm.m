function [rhoA,MSE,subjectResiduals] = distance_selection_MSE_bins_fitlm(data,theory,bins,distances,stimChans)

MSE = zeros(size(bins,1),1);
subjectResiduals = {};

count = 1;
intercept = true;

for i=bins'
    
    indicesSelect = distances>=i(1) & distances<i(2);
    dataSelect = data(indicesSelect);
    theorySelect = theory(indicesSelect);
    % use MSE
    if ~isempty(dataSelect)
        if ~intercept
            dlm=fitlm(theorySelect,dataSelect,'intercept',false);
            rhoA(count)=dlm.Coefficients{1,1};
            
        else
            dlm=fitlm(theorySelect,dataSelect);
            
            rhoA(count)=dlm.Coefficients{2,1};
        end
        MSE(count) = dlm.RMSE;
    else
        
        rhoA(count) = nan;
        MSE(count) = nan;
    end
    
    count = count + 1;
    
end



end
