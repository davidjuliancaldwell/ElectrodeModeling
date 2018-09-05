%% 3 layer
% optimization for 3 layer
rho1_vec = [0.55];
rho2_vec= [1.5:0.01:7.5];
rho3_vec = [1.5:0.01:7.5];
height_vec = [0:0.0001:0.002];
offset_vec_bracketed=[-1e-2:5e-4:1e-2];
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
    
    %     if i <= 8
    dataMeas = dataTotal_8x8(:,i);
    %     else
    %     dataMeas = dataTotal_8x4(:,i-8);
    %     end
    
    [distances] = distance_electrodes_center(stimChans,gridSize);
    
    cost_vec_temp = zeros(length(height_vec),length(rho1_vec),length(rho2_vec),length(rho3_vec),length(offset_vec),size(bins,1));
    offset_vec_temp = zeros(length(height_vec),length(rho1_vec),length(rho2_vec),length(rho3_vec),length(offset_vec),size(bins,1));
    offset_repped = repmat(offset_vec{i},length(offset_vec_bracketed),1) + repmat(offset_vec_bracketed,length(offset_vec{i}),1)';
    
    for h = 1
        h1 = height_vec(h);
        % perform 3d optimization
        for j = 1:length(rho1_vec)
            rho1 = rho1_vec(j);
            
            for k = 1:length(rho2_vec)
                rho2 = rho2_vec(k);
                
                for l = 1:length(rho3_vec)
                    rho3 = rho3_vec(l);
                    
                    for m = 1:length(offset_vec_bracketed)
                        tic
                        offset_selected = offset_repped(m,:);
                        [alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1);
                        
                        %                         if i <= 8 % 8x8 cases
                        [l3] = computePotentials_8x8_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,0);
                        % c91479 was flipped l1 l3
                        if strcmp(sid,'c91479') || strcmp(sid,'ecb43e')
                            l3 = -l3;
                        end
                        
                        %                         else % 8x4 case
                        %                             [l3] = computePotentials_8x4_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset);
                        %                         end
                        
                        [MSE,subjectResiduals] = distance_selection_MSE_bins_offsets(dataMeas',l3,bins,distances,stimChans,offset_selected);
                        cost_vec_temp(h,j,k,l,m,:) = MSE';
                        offset_vec_temp(h,j,k,l,m,:) = offset_selected;
                        
                        %      fprintf(['complete for subject ' num2str(i) ' height = ' num2str(h1) ' rho1 = ' num2str(rho1) ' rho2 = ' num2str(rho2) ' rho3 = ' num2str(rho3) ' offset = ' num2str(offset) ' \n' ]);
                    end
                    tic
                    fprintf(['complete for subject ' num2str(i) ' height = ' num2str(h1) ' rho1 = ' num2str(rho1) ' rho2 = ' num2str(rho2) ' rho3 = ' num2str(rho3) ' \n']);
                    toc
                    
                end
            end
        end
        
        cost_vec_subj{i} = cost_vec_temp;
        offset_vec_subj{i} = offset_vec_temp;
        %  fprintf(['complete for subject ' num2str(i) ' height = ' num2str(h1) ' rho1 = ' num2str(rho1) ' rho2 = ' num2str(rho2) ' rho3 = ' num2str(rho3) ' offset = ' num2str(offset) ' \n' ]);
        
    end
end

save('9_5_2018_3layer_vals_distance.mat')
return
%%

%% find minimum apparent resistivities for different distance bins
subject_min_rhoA_vec = {};

for i = 1:length(sidVec)
    for ii = 1:length(height_vec)
        % if offset vector
        cost_vec_subj = cost_vec_3layer{i};
        %cost_vec_subj = reshape(cost_vec_subj,size(bins,1),length(rhoA_vec),length(offset_vec));
        
        for iii = 1:size(bins,1)
            binCost = squeeze(cost_vec_subj(:,:,:,:,:,iii));
            [value, index] = min(binCost(:));
            [ind1,ind2,ind3,ind4,ind5] = ind2sub(size(binCost),index);
            subject_min_rho2_vec(i,iii,ii) = rho2_vec(ind1);
            subject_min_rho3_vec(i,iii,ii) = rho3_vec(ind2);
        end
    end
    
end

%% overall resistivity plot with subplots
% 8.13.2018
saveFigBool = true;

figure;

for i = 1:8
    subplot(2,4,i)
    for ii = 1:size(bins,1)
        plot(1e3*height_vec,subject_min_rho2_vec(i,ii,:),'o-','linewidth',2)
        hold on;plot(1e3*height_vec,subject_min_rho3_vec(i,ii,:),'o-','color','r','linewidth',2)
    end
    if i ==8
        h1 = hline(subject_min_rhoA_vec(i),'k','one layer point electrode');
        
    else
        h1 = hline(subject_min_rhoA_vec(i),'k');
        
    end
    h1.LineWidth = 2;
    ylim([1 8])
    title(['Subject ' num2str(i) ])
    set(gca,'fontsize',16)
    
end

xlabel('csf thickness (mm)')
ylabel('resistivity (ohm-m)')
legend({'gray matter','white matter'})

subtitle('Resistivity of cortical layers as a function of presumed CSF thickness')

if saveFigBool
    SaveFig(OUTPUT_DIR, sprintf(['total_bestFitResistivity_Binned'], num2str(i)), 'png', '-r300');
end

%%
for i = 1:length(sidVec)
    for ii = 1:length(height_vec)
        cost_vec_subj = squeeze(cost_vec_3layer(i,ii,:,:,:,:));
        
        [value, index] = min(cost_vec_subj(:));
        [ind1,ind2] = ind2sub(size(cost_vec_subj),index);
        
        
        % subject_min_rho1_vec(i) = rho1_vec(ind1);
        subject_min_rho2_vec(i,ii) = rho2_vec(ind1);
        subject_min_rho3_vec(i,ii) = rho3_vec(ind2);
        %  subject_min_offset3l_vec(i) = offset_vec(ind4);
    end
end
