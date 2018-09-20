%% find the offsets using fitlm on a single layer binned model to start
% use these offsets to then estimate where to start with the 3 layer model 
% David.J.Caldwell 9.5.2018 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
rhoA_vec=[0:0.001:7];
offset_vec = {};
cost_vec_1layer = {};
gridSize = [8,8];
bins = (repmat([1:7],2,1)+[0;1])';

cost_vec_1layer = {};
rhoA = 1;
subject_min_rhoA_vec = {};
subject_residuals = {};
%%

% loop through subjects
for i = 1:length(sidVec)
    %for i = 1
    
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    stimChans = [(stimChansVec{i})];
  stimChansDistance = stimChans(1:2);
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    
    if i <= 8
        dataMeas = dataTotal_8x8(:,i);
    else
        dataMeas = dataTotal_8x4(:,i-7);
    end
    
    % [distancesPosNeg] = distance_electrodes_pos_neg(stimChans,gridSize);
    [distances] = distance_electrodes_center(stimChansDistance,gridSize);
    
    %[sortedDistances,distanceIndices] = sort_distance_data(distances);
    
    % perform 1d optimization
    rhoA = 1;
    offset = 0;
    % extract measured data and calculate theoretical ones
    if i <= 9 % 8x8 cases
        [l1] = computePotentials_8x8_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
        % c91479 was flipped l1 l3
        if strcmp(sid,'c91479') || strcmp(sid,'ecb43e')
            l1 = -l1;
        end
        
    else % 8x4 case
        [l1] = computePotentials_8x4_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
    end
    
   [rhoA,MSE,subjectResiduals,offset] = distance_selection_MSE_bins_fitlm(dataMeas,l1,bins,distances,stimChans);
    
    cost_vec_1layer{i}{:} = MSE';
    rhoA_cell{i} = rhoA;
    offset_vec{i} = offset;
    fprintf(['complete for subject ' num2str(i) ' rhoA = ' num2str(rhoA) ' offset = ' num2str(offset) ' \n ']);
    
    
end



