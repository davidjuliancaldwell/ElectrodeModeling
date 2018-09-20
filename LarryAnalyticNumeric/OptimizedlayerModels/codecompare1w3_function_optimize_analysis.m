%% script to analyze the results of the one and 3 layer optimization on all electrodes at once
% David.J.Caldwell 8.29.2018

load('optimized_values_rescaled_v2_wider_range')
saveFigBool = true;
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

%%


%% overall resistivity plot with subplots
% 8.13.2018
saveFigBool = true;

figure;

for i = 1:7
    subplot(2,4,i)

    plot(1e3*height_vec,subject_min_rho2_vec(i,:),'o-','linewidth',2)
    hold on;plot(1e3*height_vec,subject_min_rho3_vec(i,:),'o-','color','r','linewidth',2)

    if i ==7
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

%%
if saveFigBool
    SaveFig(OUTPUT_DIR, sprintf(['total_bestFitResistivity_8_29_2018'], num2str(i)), 'png', '-r300');
end

%% overall conductivity plot with subplots
% 8.13.2018
saveFigBool = true;

figure;

for i = 1:7
    subplot(2,4,i)

    plot(1e3*height_vec,1./subject_min_rho2_vec(i,:),'o-','linewidth',2)
    hold on;plot(1e3*height_vec,1./subject_min_rho3_vec(i,:),'o-','color','r','linewidth',2)

    if i ==7
        h1 = hline(1./subject_min_rhoA_vec(i),'k','one layer point electrode');

    else
        h1 = hline(1./subject_min_rhoA_vec(i),'k');

    end
    h1.LineWidth = 2;
    ylim([0 1])
    title(['Subject ' num2str(i) ])
    set(gca,'fontsize',16)

end

xlabel('csf thickness (mm)')
ylabel('conductivity (S/m)')
legend({'gray matter','white matter'})

subtitle('Conductivity of cortical layers as a function of presumed CSF thickness')

subject_min_sigA_vec = 1./subject_min_rhoA_vec;
subject_min_sig2_vec = 1./subject_min_rho2_vec;
subject_min_sig3_vec = 1./subject_min_rho3_vec;


%%
if saveFigBool
    SaveFig(OUTPUT_DIR, sprintf(['total_bestFitConductivity_8_29_2018'], num2str(i)), 'png', '-r300');
end

%% individual subject plots
saveFigBool = true;

for i = 1:length(sidVec)

    figure;
    set(gcf, 'position', [1.0003e+03 779.6667 732 558.6667]);

    plot(1e3*height_vec,subject_min_rho2_vec(i,:),'o-','linewidth',2)
    hold on;plot(1e3*height_vec,subject_min_rho3_vec(i,:),'o-','color','r','linewidth',2)
    h1 = hline(subject_min_rhoA_vec(i),'k','one layer point electrode');
    h1.LineWidth = 2;
    xlabel('csf thickness (mm)')
    ylabel('resistivity (ohm-m)')
    legend({'gray matter','white matter'})
    set(gca,'fontsize',14)
    title(['Subject ' num2str(i) ' Resistivity of cortical layers as a function of CSF thickness'])


    OUTPUT_DIR = pwd;
    if saveFigBool
        SaveFig(OUTPUT_DIR, sprintf(['subject_%s_bestFitRestivity_8_29_2018'], num2str(i)), 'png', '-r300');
    end



    figure;
    set(gcf, 'position', [1.0003e+03 779.6667 732 558.6667]);
    plot(1e3*height_vec,1./subject_min_rho2_vec(i,:),'o-','linewidth',2)
    hold on;plot(1e3*height_vec,1./subject_min_rho3_vec(i,:),'o-','color','r','linewidth',2)
    h1 = hline(1./subject_min_rhoA_vec(i),'k','one layer point electrode');
    h1.LineWidth = 2;
    xlabel('csf thickness (mm)')
    ylabel('conductivity (S/m)')
    legend({'gray matter','white matter'})
    set(gca,'fontsize',14)
    title(['Subject ' num2str(i) ' Conductivity of cortical layers as a function of CSF thickness'])

    OUTPUT_DIR = pwd;
    if saveFigBool
        SaveFig(OUTPUT_DIR, sprintf(['subject_%s_bestFitConductivity_8_29_2018'], num2str(i)), 'png', '-r300');
    end



end



%% plot trajectory of MSE as function of CSF thickness
 figure;
    set(gcf, 'position', [607.6667 232.3333 1.7927e+03 1.0473e+03]);
for i = 1:7
        cost_vec_subj = squeeze(cost_vec_3layer(i,:,:,:,:,:));
        cost_vec_subj = reshape(cost_vec_subj,length(height_vec),[]);
        subplot(2,4,i)
        plot(1e3*height_vec,squeeze(min(cost_vec_subj,[],2)),'linewidth',2)
    title(['Subject ' num2str(i)])

            h1 = hline(min(cost_vec_1layer(i,:)),'k','one layer point electrode');
    h1.LineWidth = 2;
    set(gca,'fontsize',14)
    grid on
    grid minor

end
xlabel('csf thickness (mm)')
ylabel('squared error')
set(gca,'fontsize',14)

subtitle('Error by subject as a function of presumed CSF thickness ')

    OUTPUT_DIR = pwd;
    if saveFigBool
        SaveFig(OUTPUT_DIR, sprintf(['squaredError_trajectory_8_29_2018'], num2str(i)), 'png', '-r300');
    end


%% now find global minimum for each subject
        % subject_min_rho1_vec(i) = rho1_vec(ind1);
        subject_min_h1_vec_global = [];
        subject_min_rho1_vec_global = [];
        subject_min_rho2_vec_global = [];
        subject_min_rho3_vec_global = [];
        %  subject_min_offset3l_vec(i) = offset_vec(ind4);
for i = 1:7
        cost_vec_subj = cost_vec_3layer(i,:,:,:,:,:);

        [value, index] = min(cost_vec_subj(:));
        [ind1,ind2,ind3,ind4,ind5] = ind2sub(size(cost_vec_subj),index);


        % subject_min_rho1_vec(i) = rho1_vec(ind1);
        subject_min_h1_vec_global(i) = height_vec(ind2);
        subject_min_rho1_vec_global(i) = rho1_vec(ind3);
        subject_min_rho2_vec_global(i) = rho2_vec(ind4);
        subject_min_rho3_vec_global(i) = rho3_vec(ind5);

        % use forced zeros here for offsets
        subject_min_offset1l_vec_global(i) = 0;
          subject_min_offset3l_vec_global(i) = 0;

end

%% plotting
% plot
% setup global figure
figTotal = figure('units','normalized','outerposition',[0 0 1 1]);
figResid = figure('units','normalized','outerposition',[0 0 1 1]);
figLinear = figure('units','normalized','outerposition',[0 0 1 1]);
%
l1_vec = zeros(size(dataTotal_8x8));
l3_vec = zeros(size(dataTotal_8x8));

for i = 1:7

    fig_ind(i) = figure('units','normalized','outerposition',[0 0 1 1]);
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    % for the old data file with 12 x 2 cell for stim chans, must do below,
    % rathern than [(stimChansVec{:})];
    stimChans =  [(stimChansVec{i,:})];
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    rho1 = subject_min_rho1_vec_global(i);
    rho2 = subject_min_rho2_vec_global(i);
    rho3 = subject_min_rho3_vec_global(i);
    offset_1l = 0;
    offset_3l = 0;
    rhoA = subject_min_rhoA_vec(i);
    h1 = subject_min_h1_vec_global(i);
    % perform 1d optimization
    [alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1);

    % extract measured data and calculate theoretical ones
    if i <= 7 % 8x8 cases
        dataMeas = dataTotal_8x8(:,i);
        [l3] = computePotentials_8x8_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset_3l);
        [l1] = computePotentials_8x8_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset_1l);
        % c91479 was flipped l1 l3
        if strcmp(sid,'c91479')
            l3 = -l3;
            l1 = -l1;
        end
    else % 8x4 case
        dataMeas = dataTotal_8x4(:,i-7);
        [l3] = computePotentials_8x4_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset_3l);
        [l1] = computePotentials_8x4_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset_1l);

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
    annotation(fig_ind(i), 'textbox', dim, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec_global(i))]...
        ['rho1 = ' num2str(subject_min_rho1_vec_global(i))],['rho2 = ' num2str(subject_min_rho2_vec_global(i))],...
        ['rho3 = ' num2str(subject_min_rho3_vec_global(i))], ['offset 3 layer = ' num2str(subject_min_offset3l_vec_global(i))],...
        ['h1 = ' num2str(subject_min_h1_vec_global(i))]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    %     annotation(fig_ind(i), 'textbox', dim, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec(i))]...
    %         },...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    drawnow;
    title(sid)
    OUTPUT_DIR = pwd;
    if saveFigBool
        SaveFig(OUTPUT_DIR, sprintf(['fit_ind_opt_subject_farAway_3l_1l_sid_%s_8_29_2018'], char(sid)), 'png', '-r300');
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
for i = 1:7
    annotation(figTotal, 'textbox', dim{i}, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec_global(i))]...
        ['rho1 = ' num2str(subject_min_rho1_vec_global(i))],['rho2 = ' num2str(subject_min_rho2_vec_global(i))],...
        ['rho3 = ' num2str(subject_min_rho3_vec_global(i))], ['offset 3 layer = ' num2str(subject_min_offset3l_vec_global(i))],...
        ['h1 = ' num2str(subject_min_h1_vec_global(i))]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');

    %     annotation(figTotal, 'textbox', dim{i}, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))],['offset 1 layer = ' num2str(subject_min_offset1l_vec(i))]...
    %         },...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
end
OUTPUT_DIR = pwd;
if saveFigBool
    SaveFig(OUTPUT_DIR, ['fit_total_opt_farAway_3l_1l_8_29_2018'], 'png', '-r300');
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
for i = 1:7
    annotation(figResid, 'textbox', dim{i}, 'String', {['R factor 1 layer = ' num2str(R_factor1(i))],['R factor 3 layer = ' num2str(R_factor3(i))]},...
        'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
    %
    %     annotation(figResid, 'textbox', dim{i}, 'String', {['R factor 1 layer = ' num2str(R_factor1(i))]},...
    %         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
end
OUTPUT_DIR = pwd;
if saveFigBool
    SaveFig(OUTPUT_DIR, ['fit_resid_farAway_3l_l1_8_29_2018'], 'png', '-r300');
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
    SaveFig(OUTPUT_DIR, ['fit_linear_farAway_3l_l1_8_29_2018'], 'png', '-r300');
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
%% prepare data for larry

save('3_layer_1_layer_fit_vals.mat','l1_vec','l3_vec','dataTotal_8x8','sidVec')

%% save all the data
close all;
save('fineResolution_optimized.mat','-v7.3')
