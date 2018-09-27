%% script to fit individual data
%
% David.J.Caldwell

%% fitlm by bins
% David.J.Caldwell 9.5.2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer

cost_vec_1layer = {};
gridSize = [8,8];
bins = (repmat([1:7],2,1)+[0;1])';

cost_vec_1layer = {};
rhoA = 1;
subject_min_rhoA_vec = {};
subject_residuals = {};

jLength = 8;
kLength = 8;
%%
for i = 1:numSubjs
    
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    stimChans = [(stimChansVec{i})];
    stimChansDistance = stimChans(1:2);
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    
    % [distancesPosNeg] = distance_electrodes_pos_neg(stimChans,gridSize);
    [distances] = distance_electrodes_center(stimChansDistance,gridSize);
    
    
    % perform 1d optimization
    rhoA = 1;
    offset = 0;
    % extract measured data and calculate theoretical ones
    
    [l1] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,jLength,kLength);
    % c91479 was flipped l1 l3
    
    [rhoA,MSE,subjectResiduals,offset] = distance_selection_MSE_bins_fitlm(dataMeas,l1,bins,distances,stimChans);
    
    cost_vec_1layer{i}{:} = MSE';
    rhoA_cell{i} = rhoA;
    offset_vec{i} = offset;
    fprintf(['complete for subject ' num2str(i) ' rhoA = ' num2str(rhoA) ' offset = ' num2str(offset) ' \n ']);
    
    
end



