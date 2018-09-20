%% load in data
%close all;clear all;clc
load('G:\My Drive\GRIDLabDavidShared\resistivityDataSets\9_5_2018_3layer_vals_distance')

subject_min_rho2_vec = [];
subject_min_rho3_vec = [];
subject_min_rho1_vec = [];
subject_min_offset_vec = [];

%% get number of electrodes in each bin

for i = 1:length(sidVec)
    stimChans = [(stimChansVec{i})];
    [distances] = distance_electrodes_center(stimChans(1:2),gridSize);
    count = 1;
    
    for ii=bins'
        
        indicesSelect = distances>=ii(1) & distances<ii(2);
        chansBin(i,count,:) = indicesSelect;
        count = count + 1;
        
    end
    
end

summedChansBin = sum(chansBin,3);

%% find best offset at each height rho1 rho2, etc


cost_vec_subj_MSE_comb_offset = {};
cost_vec_subj_offset_ind = {};


for i = 1:length(sidVec)
    
    cost_vec_individual = cost_vec_subj{i};
    sizeCostVec = size(cost_vec_individual);
    cost_vec_temp = zeros(len_height_vec,len_rho1_vec,len_rho2_vec,len_rho3_vec,size(bins,1));
    cost_vec_offset_inds = cost_vec_temp;
    for a = 1:len_height_vec
        for b = 1:len_rho1_vec
            for c = 1:len_rho2_vec
                for d = 1:len_rho3_vec
                    offsetsBins = squeeze(cost_vec_individual(a,b,c,d,:,:));
                    [bestMSE,inds] = min(offsetsBins,[],1);
                    cost_vec_temp(a,b,c,d,:) = bestMSE;
                    cost_vec_offset_inds(a,b,c,d,:) = inds;
                end
            end
        end
    end
    
    cost_vec_subj_MSE_comb_offset{i} = cost_vec_temp;
    cost_vec_subj_offset_ind{i} = cost_vec_offset_inds;
end


%% unwrap MSE for each bin now that best offset has been found 

combine_MSE = @(MSE,count) nansum(MSE.*count)/nansum(count);

cost_vec_subj_MSE_comb = {};

for i = 1:length(sidVec)
    
    cost_vec_individual = cost_vec_subj_MSE_comb_offset{i};
    sizeCostVec = size(cost_vec_individual);
    cost_vec_temp = zeros(sizeCostVec(1:end-1));
    
    for a = 1:len_height_vec
        for b = 1:len_rho1_vec
            for c = 1:len_rho2_vec
                for d = 1:len_rho3_vec
                    cost_vec_temp(a,b,c,d) = squeeze(combine_MSE(squeeze(cost_vec_individual(a,b,c,d,:))',summedChansBin(i,:)));
                end
            end
        end
    end
    cost_vec_subj_MSE_comb{i} = cost_vec_temp;

end

    
%% find minimum resistivities at each thickness 

for i = 1:length(sidVec)
    cost_vec_individual = cost_vec_subj_MSE_comb{i};
    
    for ii = 1:length(height_vec)
        
        cost_vec_individual_height = squeeze(cost_vec_individual(ii,:,:,:));
        [value, index] = min(cost_vec_individual_height(:));
        
        [ind1,ind2] = ind2sub(size(cost_vec_individual_height),index);
        subject_min_rho2_vec(i,ii) = rho2_vec(ind1);
        subject_min_rho3_vec(i,ii) = rho3_vec(ind2);
        subject_min_height_cost(i,ii) = value;
    end
    
end
%%
% find global mins
for i = 1:length(sidVec)
    cost_vec_individual = cost_vec_subj_MSE_comb{i};

        cost_vec_individual_height = squeeze(cost_vec_individual(:,:,:,:));
        [value, index] = min(cost_vec_individual_height(:));
        
        [ind1,ind2,ind3] = ind2sub(size(cost_vec_individual_height),index);
        subject_min_height_vec(i) = height_vec(ind1);
        subject_min_rho2_vec_global(i) = rho2_vec(ind2);
        subject_min_rho3_vec_global(i) = rho3_vec(ind3);
    
end

%% overall resistivity plot with subplots
% 8.13.2018
saveFigBool = false;

figure;

for i = 1:8
    subplot(2,4,i)
    

   h1= plot(1e3*height_vec,squeeze(subject_min_height_cost(i,:)),'linewidth',2);
 
    title(['Subject ' num2str(i) ])
    set(gca,'fontsize',16)
    
end

xlabel('csf thickness (mm)')
ylabel('MSE')
subtitle('MSE as a function of CSF thickness')

if saveFigBool
    SaveFig(OUTPUT_DIR, sprintf(['total_curves_9_6_2018'], num2str(i)), 'png', '-r300');
end

%% cost curve
% 8.13.2018
saveFigBool = false;

figure;

for i = 1:8
    subplot(2,4,i)
    

   h1= plot(1e3*height_vec,squeeze(subject_min_rho2_vec(i,:)),'o-','linewidth',2);
        hold on;
        h2 = plot(1e3*height_vec,squeeze(subject_min_rho3_vec(i,:)),'o-','linewidth',2);

    ylim([1 8])
    title(['Subject ' num2str(i) ])
    set(gca,'fontsize',16)
    vline(1e3*subject_min_height_vec(i),'k','minimum height')
    
end

xlabel('csf thickness (mm)')
ylabel('resistivity (ohm-m)')
legend([h1,h2],{'gray matter','white matter'})
subtitle('Resistivity of cortical layers as a function of presumed CSF thickness')

if saveFigBool
    SaveFig(OUTPUT_DIR, sprintf(['total_costCurve_9_6_2018'], num2str(i)), 'png', '-r300');
end


return

%% plotting
% plot

saveFigBool = false;
% setup global figure
figTotal = figure('units','normalized','outerposition',[0 0 1 1]);
figResid = figure('units','normalized','outerposition',[0 0 1 1]);
figLinear = figure('units','normalized','outerposition',[0 0 1 1]);
%
l1_vec = zeros(size(dataTotal_8x8));
l3_vec = zeros(size(dataTotal_8x8));

for i = 1:8
    
    fig_ind(i) = figure('units','normalized','outerposition',[0 0 1 1]);
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    stimChans = stimChansVec{i};
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    rho1 = subject_min_rho2_vec(i);
    rho2 = subject_min_rho2_vec(i);
    rho3 = subject_min_rho3_vec(i);
    offset_3l = subject_min_offset_vec(i,iii,ii);
    h1 = subject_min_h1_vec(i);
    % perform 1d optimization
    [alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1);
    
    % extract measured data and calculate theoretical ones
    if i <= 8 % 8x8 cases
        dataMeas = dataTotal_8x8(:,i);
        [l3] = computePotentials_8x8_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset_3l);
        % c91479 was flipped l1 l3
        if strcmp(sid,'c91479') || strcmp(sid,'ecb43e')
            l3 = -l3;
        end
    else % 8x4 case
        dataMeas = dataTotal_8x4(:,i-7);
        [l3] = computePotentials_8x4_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset_3l);
        
    end
    
    l3 = l3';
    l1 = l1';
    l1_vec(:,i) = l1;
    l3_vec(:,i) = l3;
    %residuals-factor
    resid_l3{i} = l3-dataMeas;
    resid_l1{i} = l1-dataMeas;
    R_factor1(i) = nansum(abs(resid_l1{i}))/nansum(abs(dataMeas(~isnan(l1))));
    R_factor3(i) = nansum(abs(resid_l3{i}))/nansum(abs(dataMeas(~isnan(l1))));
    
    % linear fits
    [yfit3,P3] = linearModelFit(dataMeas,l3);
    [yfit1,P1] = linearModelFit(dataMeas,l1);
    
    yfit3_cell{i} = yfit3;
    yfit1_cell{i} = yfit1;
    P3_cell{i} = P3;
    P1_cell{i} = P1;
    
    
    % plot individual subjects for line plots
    figure(fig_ind(i));
    plot(dataMeas,'color',color1,'linewidth',2);hold on;
    plot(l1,'color',color2,'linewidth',2);hold on;
    plot(l3,'color',color3,'linewidth',2);hold on;
    xlabel('Electrode Number')
    ylabel('Voltage (V)')
    legend('measured','single layer','3 layer');
    %  legend('measured','single layer');
    
    dim = [0.2 0.2 0.5 0.5];
    annotation(fig_ind(i), 'textbox', dim, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec(i))]...
        ['rho1 = ' num2str(subject_min_rho1_vec(i))],['rho2 = ' num2str(subject_min_rho2_vec(i))],...
        ['rho3 = ' num2str(subject_min_rho3_vec(i))], ['offset 3 layer = ' num2str(subject_min_offset3l_vec(i))],...
        ['h1 = ' num2str(subject_min_h1_vec(i))]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    %     annotation(fig_ind(i), 'textbox', dim, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec(i))]...
    %         },...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    drawnow;
    title(sid)
    OUTPUT_DIR = pwd;
    if saveFigBool
        SaveFig(OUTPUT_DIR, sprintf(['fit_ind_opt_subject_farAway_3l_1l%s'], char(sid)), 'png', '-r300');
    end
    
    % global figure of residuals
    figure(figResid);
    subplot_resid(i) = subplot(2,4,i);
    vectorPlot = [1:64];
    vectorPlot(isnan(resid_l1{i})) = nan;
    plot(vectorPlot,resid_l1{i},'o','color',color1,'markerfacecolor',color1); hold on;
    plot(vectorPlot,resid_l3{i},'o','color',color2,'markerfacecolor',color2);
    hline(0)
    title(sid)
    
    
    % global figure of linear fits
    figure(figLinear);
    subplot_linear(i) = subplot(2,4,i);
    plot(dataMeas(~isnan(l1)),l1(~isnan(l1)),'o','color',color1,'markerfacecolor',color1);
    hold on;
    plot(l1(~isnan(l1)),yfit1,'color',color1,'linewidth',2);
    
    plot(dataMeas(~isnan(l3)),l3(~isnan(l3)),'o','color',color2,'markerfacecolor',color2);
    plot(l3(~isnan(l3)),yfit3,'color',color2,'linewidth',2);
    
    title(sid)
    
    % global figure of linear line plots
    figure(figTotal)
    subplot_total(i) = subplot(2,4,i);
    plot(dataMeas,'color',color1,'linewidth',2);
    hold on;
    plot(l1,'color',color2,'linewidth',2);hold on;
    plot(l3,'color',color3,'linewidth',2);hold on;
    title(sid)
end
%
figure(figTotal)

xlabel('Electrode Number')
ylabel('Voltage (V)')
legend('measured','single layer','three layer');
% legend('measured','single layer');

%
arrayfun(@(x) pbaspect(x, [1 1 1]), subplot_total);
drawnow;
pos = arrayfun(@plotboxpos, subplot_total, 'uni', 0);
dim = cellfun(@(x) x.*[1 1 0.5 0.5], pos, 'uni',0);
for i = 1:length(sidVec)
    annotation(figTotal, 'textbox', dim{i}, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec(i))]...
        ['rho1 = ' num2str(subject_min_rho1_vec(i))],['rho2 = ' num2str(subject_min_rho2_vec(i))],...
        ['rho3 = ' num2str(subject_min_rho3_vec(i))], ['offset 3 layer = ' num2str(subject_min_offset3l_vec(i))],...
        ['h1 = ' num2str(subject_min_h1_vec(i))]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    
    %     annotation(figTotal, 'textbox', dim{i}, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec(i))]...
    %         },...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
end
OUTPUT_DIR = pwd;
if saveFigBool
    SaveFig(OUTPUT_DIR, ['fit_total_opt_farAway_3l_1l'], 'png', '-r300');
end


figure(figResid);
xlabel('Electrode Number')
ylabel('Residual')
legend('single layer','three layer');
% legend('single layer');

%
arrayfun(@(x) pbaspect(x, [1 1 1]), subplot_resid);
drawnow;
pos = arrayfun(@plotboxpos, subplot_total, 'uni', 0);
dim = cellfun(@(x) x.*[1 1 0.5 0.5], pos, 'uni',0);
for i = 1:length(sidVec)
    annotation(figResid, 'textbox', dim{i}, 'String', {['R factor 1 layer = ' num2str(R_factor1(i))],['R factor 3 layer = ' num2str(R_factor3(i))]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    %
    %     annotation(figResid, 'textbox', dim{i}, 'String', {['R factor 1 layer = ' num2str(R_factor1(i))]},...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
end
OUTPUT_DIR = pwd;
if saveFigBool
    SaveFig(OUTPUT_DIR, ['fit_resid_farAway_3l_l1'], 'png', '-r300');
end

figure(figLinear)
xlabel('Theoretical Prediction')
ylabel('Data')
legend('single layer','single layer fit line','three layer','three layer fit line');
%
arrayfun(@(x) pbaspect(x, [1 1 1]), subplot_total);
drawnow;
pos = arrayfun(@plotboxpos, subplot_linear, 'uni', 0);
dim = cellfun(@(x) x.*[1 1 0.5 0.5], pos, 'uni',0);
for i = 1:length(sidVec)
    annotation(figLinear, 'textbox', dim{i}, 'String', {['slope 1 layer = ' num2str(P1_cell{i}(1))],['intercept 1 layer = ' num2str(P1_cell{i}(2))],...
        ['slope 3 layer = ' num2str(P3_cell{i}(1))],['intercept 3 layer = ' num2str(P3_cell{i}(2))]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    
    %     annotation(figLinear, 'textbox', dim{i}, 'String', {['slope 1 layer = ' num2str(P1_cell{i}(1))],['intercept 1 layer = ' num2str(P1_cell{i}(2))],...
    %         },...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
end
OUTPUT_DIR = pwd;
if saveFigBool
    SaveFig(OUTPUT_DIR, ['fit_linear_farAway_3l_l1'], 'png', '-r300');
end

%% plot contours of interest
%%
figure('units','normalized','outerposition',[0 0 1 1]);
%colormap('grayb')
for i = 1:length(sidVec)
    subplot_resid(i) = subplot(2,4,i);
    sid = sidVec{i};
    
    cost_vec_subj = squeeze(cost_vec_1layer(i,:,:));
    
    
    imagesc(rhoA_vec,offset_vec,log(cost_vec_subj))
    set(gca,'Ydir','normal')
    xlabel('rhoA vec')
    ylabel('offset vector')
    title([sid ' Log plot'])
    colorbar()
end
set(gca,'fontsize',14)
OUTPUT_DIR = pwd;
%
if saveFigBool
    SaveFig(OUTPUT_DIR, ['contour_log_3l_1l'], 'png', '-r300');
end

%%
% 3D slice
%%
%subject of interest - 0b5a2e
subject = 1;
param_slice_interest = 2;
cost_vec_subj = squeeze(cost_vec_3layer(subject,:,:,:,:));

figure
[gridded_x,gridded_y] = meshgrid(rho1_vec,rho2_vec);
surf(gridded_x,gridded_y ,squeeze(cost_vec_subj(:,:, param_slice_interest,1))')
xlabel('rho1')
ylabel('rho2')


param_slice_interest = 4;
figure
[gridded_x,gridded_y] = meshgrid(rho2_vec,rho3_vec);
surf(gridded_x,gridded_y ,squeeze(cost_vec_subj( param_slice_interest,:,:,1))')
xlabel('rho2')
ylabel('rho3')

%subject of interest - d5cd55
subject = 1;
param_slice_interest = 5;
cost_vec_subj = squeeze(cost_vec_3layer(subject,:,:,:));

figure
[gridded_x,gridded_y] = meshgrid(rho1_vec,rho2_vec);
surf(gridded_x,gridded_y ,squeeze(cost_vec_subj(:,:, param_slice_interest,1))')
xlabel('rho1')
ylabel('rho2')


param_slice_interest = 1;
figure
[gridded_x,gridded_y] = meshgrid(rho2_vec,rho3_vec);
surf(gridded_x,gridded_y ,squeeze(cost_vec_subj( param_slice_interest,:,:,1))')
xlabel('rho2')
ylabel('rho3')

