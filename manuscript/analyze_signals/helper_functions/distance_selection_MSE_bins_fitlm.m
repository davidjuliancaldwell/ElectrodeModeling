function [rhoA,MSE,subjectResiduals,offset,bestVals] = distance_selection_MSE_bins_fitlm(data,theory,bins,distances)

MSE = zeros(size(bins,1),1);
bestVals = nan(size(distances,1),1);
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
            offset(count) = 0;
        else
            dlm=fitlm(theorySelect,dataSelect);
            
            rhoA(count)=dlm.Coefficients{2,1};
            offset(count) = dlm.Coefficients{1,1};
        end
        MSE(count) = dlm.RMSE;
        bestVals(indicesSelect) = dlm.Fitted;

    else
        
        rhoA(count) = nan;
        MSE(count) = nan;
        offset(count) = nan;
    end
    
    count = count + 1;
    
end



end
