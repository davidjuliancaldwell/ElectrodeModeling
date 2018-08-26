%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
rhoA_vec=[0:0.001:7];
%offset_vec=[-3e-3:1e-5:3e-3];
%offset_vec = [0,1];
offset_vec = [0];
cost_vec_1layer = {};

subject_min_rhoA_vec = {};
subject_residuals = {};
%subject_residuals = nan(length(sidVec),length(rhoA_vec),length(offset_vec),62);
subject_min_offset1l_vec = zeros(length(sidVec),1);
%%

% loop through subjects
for i = 1:length(sidVec)
    %for i = 1
    
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    stimChans = [(stimChansVec{i})];
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    
    if i <= 8
        dataMeas = dataTotal_8x8(:,i);
    else
        dataMeas = dataTotal_8x4(:,i-7);
    end
    
    [vals,indices,numberNonNaN] = sort_voltage_data(dataMeas);
    
    % perform 1d optimization
    j = 1;
    for rhoA = rhoA_vec
        % extract measured data and calculate theoretical ones
        k = 1;
        for offset = offset_vec
            if i <= 8 % 8x8 cases
                [l1] = computePotentials_8x8_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
                % c91479 was flipped l1 l3
                if strcmp(sid,'c91479') || strcmp(sid,'ecb43e')
                    l1 = -l1;
                end
                
            else % 8x4 case
                [l1] = computePotentials_8x4_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
            end
            
            [MSE,subjectResiduals] = range_shrinking(dataMeas',l1,vals,indices,numberNonNaN);
            cost_vec_1layer{i}{j,k,:} = MSE';
            fprintf(['complete for subject ' num2str(i) ' rhoA = ' num2str(rhoA) ' offset = ' num2str(offset) ' \n ']);
            k = k + 1;
        end
        j = j + 1;
    end
    
end

%%
for i = 1:length(sidVec)
    cost_vec_subj = cell2mat(cost_vec_1layer{i});
    
    [value, index] = min(cost_vec_subj,[],1);
    %[ind1,ind2] = ind2sub(size(cost_vec_subj),index);
    [ind1] = ind2sub(size(cost_vec_subj),index);
        subject_min_rhoA_vec{i} = rhoA_vec(index);

    %subject_min_offset1l_vec(i) = offset_vec(ind2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
figure
for i=1:length(sidVec)
subplot(2,4,i)
plot([1:length(subject_min_rhoA_vec{i})],fliplr(subject_min_rhoA_vec{i}))

set(gca,'fontsize',14)
ylim([0 7])
title(['Subject ' num2str(i)])
end
xlabel('number of data points fit')
ylabel('apparent resistivity (Ohm-m)')
subtitle('one layer grid search, range shrinking by sorted values')