%% 3 layer
% optimization for 3 layer
rho1_vec = [0.55];
rho2_vec= [1.5:0.05:7.5];
rho3_vec = [1.5:0.05:7.5];
height_vec = [0:0.0001:0.002];
offset_vec=[-5e-2:1e-3:5e-2];
%subject_residuals = zeros(length(sidVec),length(height_vec),length(rho1_vec),length(rho2_vec),length(rho3_vec),length(offset_vec),64);

cost_vec_3layer = {};
subject_min_rhoA_vec = {};
subject_min_rho2_vec = {};
subject_min_rho3_vec = {};
subject_residuals = {};
gridSize = [8,8];
bins = (repmat([1:7],2,1)+[0;1])';

%subject_min_rho1_vec = zeros(length(sidVec),1);
%subject_min_rho2_vec = zeros(length(sidVec),1);
%subject_min_rho3_vec = zeros(length(sidVec),1);
%subject_min_offset3l_vec = zeros(length(sidVec),1);
%%
for i = 1:length(sidVec)
    
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
        dataMeas = dataTotal_8x4(:,i-8);
    end
    
    [distances] = distance_electrodes_center(stimChans,gridSize);
    
    h = 1;
    for h1 = height_vec
        % perform 3d optimization
        j = 1;
        for rho1 = rho1_vec
            k = 1;
            for rho2 = rho2_vec
                l = 1;
                for rho3 = rho3_vec
                    m = 1;
                    for offset = offset_vec
                        [alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1);
                        
                        if i <= 8 % 8x8 cases
                            [l3] = computePotentials_8x8_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset);
                            % c91479 was flipped l1 l3
                            if strcmp(sid,'c91479') || strcmp(sid,'ecb43e')
                                l3 = -l3;
                            end
                            
                        else % 8x4 case
                            [l3] = computePotentials_8x4_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset);
                        end
                        
                        [MSE,subjectResiduals] = distance_selection_MSE_bins(dataMeas',l3,bins,distances,stimChans);
                        cost_vec_3layer{i}(h,j,k,l,m,:) = MSE';
                        m = m + 1;
                  %      fprintf(['complete for subject ' num2str(i) ' height = ' num2str(h1) ' rho1 = ' num2str(rho1) ' rho2 = ' num2str(rho2) ' rho3 = ' num2str(rho3) ' offset = ' num2str(offset) ' \n' ]);
                    end
                    l = l + 1;
                end
                k = k + 1;
            end
            j = j + 1;
        end
        h = h + 1;
 fprintf(['complete for subject ' num2str(i) ' height = ' num2str(h1) ' rho1 = ' num2str(rho1) ' rho2 = ' num2str(rho2) ' rho3 = ' num2str(rho3) ' offset = ' num2str(offset) ' \n' ]);

    end
end

save('8_25_2018_3layer_vals_distance.mat')