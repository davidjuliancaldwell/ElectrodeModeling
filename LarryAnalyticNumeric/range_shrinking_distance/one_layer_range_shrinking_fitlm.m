%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
rhoA_vec=[0:0.001:7];
%offset_vec=[-3e-3:1e-5:3e-3];
%offset_vec = [0,1];
offset_vec = [0];
cost_vec_1layer = {};

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
    rhoA = 1;
    offset = 0;
    % extract measured data and calculate theoretical ones
    if i <= 8 % 8x8 cases
        [l1] = computePotentials_8x8_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
        % c91479 was flipped l1 l3
        if strcmp(sid,'c91479') || strcmp(sid,'ecb43e')
            l1 = -l1;
        end
        
    else % 8x4 case
        [l1] = computePotentials_8x4_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
    end
    
    [rhoA,MSE,subjectResiduals] = range_shrinking_fitlm(dataMeas',l1,vals,indices,numberNonNaN);
    
    cost_vec_1layer{i}{:} = MSE';
    rhoA_cell{i} = rhoA;
    fprintf(['complete for subject ' num2str(i) '\n']);
    
end

%%
figure
for i=1:length(sidVec)
    subplot(2,4,i)
    plot([1:length(rhoA_cell{i})],fliplr(rhoA_cell{i}))
    
    set(gca,'fontsize',14)
    ylim([0 7])
    title(['Subject ' num2str(i)])
end
xlabel('number of data points fit')
ylabel('apparent resistivity (Ohm-m)')
subtitle('range shrinking by sorted values - fitlm, no intercept')