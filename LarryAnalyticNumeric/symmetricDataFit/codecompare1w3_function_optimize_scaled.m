%% initialize workspace
% DJC 7.6.2018
% compare symmetric, averaged across subjects data

clear all;close all;clc
load('all12.mat')
load('the_data.mat')
symmetric = 4.*symmetric;
symmetricFlat = reshape(symmetric',1,[]);
symmetric(symmetric==0) = NaN;
symmetricFlat(symmetricFlat==0) = NaN;
%%
[row,col] = find(symmetric==0);
sizeMatrix = size(symmetric);
indices = sub2ind(sizeMatrix,row,col);

% perform optimization for the 1 layer case

a=0.00115;
R=0.00115;
d=0.0035;
sigma = 0.05; % this defines for huber loss the transition from squared
% to linear loss behavior

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
rhoA_vec=[0.1:0.001:5];
%offset_vec=[-3e-3:1e-5:3e-3];
offset_vec = [0];
cost_vec_1layer = zeros(length(rhoA_vec),length(offset_vec));

min_rhoA_vec = zeros(1);
min_offset1l_vec = zeros(1);
%%

% select particular values for constants
i0 = 5e-3;
stimChans = indices;
% Calculate voltages
jp=5;
kp=7;
jm=6;
km=7;

% perform 1d optimization
j = 1;
for rhoA = rhoA_vec
    % extract measured data and calculate theoretical ones
    k = 1;
    for offset = offset_vec
        
        [l1,tp] = computePotentials_1Layer_symmetric(jp,kp,jm,km,rhoA,i0,stimChans,offset,10,13);
        % use sum sqaured
        sqLoss = (symmetric-tp).^2;
        h_loss = nansum(sqLoss(:));
        
        cost_vec_1layer(j,k) = h_loss;
        fprintf(['rhoA  = ' num2str(rhoA) ', offset  = ' num2str(offset) ' \n ']);
        k = k + 1;
    end
    j = j + 1;
end

%%

[value, index] = min(cost_vec_1layer(:));
[ind1,ind2] = ind2sub(size(cost_vec_1layer),index);

min_rhoA_vec = rhoA_vec(ind1);
min_offset1l_vec= offset_vec(ind2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 3 layer
% optimization for 3 layer
%rho1_vec = [0.4:0.05:0.6];
rho1_vec = 0.55;
rho2_vec= [2:0.05:7.75];
rho3_vec = [2:0.05:7.5];
%offset_vec=[-3e-3:1e-5:3e-3];
offset_vec = [0];
height_vec = [0:0.0001:0.002];
%height_vec = [0.0001]
sigma = 0.05; % sigma for huber loss
cost_vec_3layer = zeros(length(height_vec),length(rho1_vec),length(rho2_vec),length(rho3_vec),length(offset_vec));

min_rho1_vec = zeros(1);
min_rho2_vec = zeros(1);
min_rho3_vec = zeros(1);
min_offset3l_vec = zeros(1);

% select particular values fhor constants
i0 = 5e-3;
stimChans = indices;
% Calculate voltages
jp=5;
kp=7;
jm=6;
km=7;
%h1=0.001;

% perform 3d optimization

h = 1;
for h1 = height_vec
    j = 1;
    for rho1 = rho1_vec
        k = 1;
        for rho2 = rho2_vec
            l = 1;
            for rho3 = rho3_vec
                m = 1;
                for offset = offset_vec
                    [alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1);
                    [l3,t3] = computePotentials_3Layer_symmetric(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset,10,13);
                    
                    % use sum sqaured
                    sqLoss = (symmetric-t3).^2;
                    h_loss = nansum(sqLoss(:));
                    cost_vec_3layer(h,j,k,l,m) = h_loss;
                    m = m + 1;
                    fprintf(['h1 = ' num2str(h1) ' rho1 = ' num2str(rho1) ' rho2 = ' num2str(rho2) ' rho3 = ' num2str(rho3) ' offset = ' num2str(offset) ' \n' ]);
                end
                l = l + 1;
            end
            k = k + 1;
        end
        j = j + 1;
        
    end
    h = h+1;
end
%%
h = 1;
for h1 = height_vec
    [value, index] = min(squeeze((cost_vec_3layer(h,:))));
    
    [ind1,ind2] = ind2sub(size(squeeze(cost_vec_3layer(h,:,:,:))),index);
    
    %min_height_vec = height_vec(ind1);
   % min_rho1_vec(h) = rho1_vec(ind1);
    min_rho2_vec(h) = rho2_vec(ind1);
    min_rho3_vec(h) = rho3_vec(ind2);
    %min_offset3l_vec = offset_vec(ind5);
    h = h + 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% plot conductivity and resistivity as a function of CSF thickness
saveFigBool = false;

figure;plot(1e3*height_vec,min_rho2_vec,'o-','linewidth',2)
hold on;plot(1e3*height_vec,min_rho3_vec,'o-','color','r','linewidth',2)
h1 = hline(min_rhoA_vec,'k','one layer point electrode');
h1.LineWidth = 2;
xlabel('Assumed csf thickness (mm)')
ylabel('resistivity (ohm-m)')
legend({'gray matter','white matter'})
set(gca,'fontsize',14)
title('The best fit resistivity values as a function of CSF thickness')
    OUTPUT_DIR = pwd;
    if saveFigBool
        SaveFig(OUTPUT_DIR, sprintf(['symmetric_bestFitRestivity_v2'], num2str(i)), 'png', '-r300');
    end
    
    
    

figure;plot(1e3*height_vec,1./min_rho2_vec,'o-','linewidth',2)
hold on;plot(1e3*height_vec,1./min_rho3_vec,'o-','color','r','linewidth',2)
h1 = hline(1./min_rhoA_vec,'k','one layer point electrode');
h1.LineWidth = 2;
xlabel('Assumed csf thickness (mm)')
ylabel('conductivity (S/m)')
legend({'gray matter','white matter'})
set(gca,'fontsize',14)
title('The best fit conductivity values as a function of CSF thickness')

    if saveFigBool
        SaveFig(OUTPUT_DIR, sprintf(['symmetric_bestFitConductivity_v2'], num2str(i)), 'png', '-r300');
    end
    

%% plot contour lines of interest


h = 1;
for h1 = height_vec
    [value, index] = min(squeeze((cost_vec_3layer(h,:))));
    
    [ind1,ind2] = ind2sub(size(squeeze(cost_vec_3layer(h,:,:,:))),index);
    
    %min_height_vec = height_vec(ind1);
    % min_rho1_vec(h) = rho1_vec(ind1);
    min_rho2_vec(h) = rho2_vec(ind1);
    min_rho3_vec(h) = rho3_vec(ind2);
    %min_offset3l_vec = offset_vec(ind5);
    
    figure;
    contour(rho2_vec,rho3_vec,squeeze(cost_vec_3layer(h,:,:,:))',100);
    hold on
    h2 = plot(rho2_vec(ind1),rho3_vec(ind2),'*');
    legend([h2],{'best fit point'})
    set(gca,'fontsize',14)
    title({'Best fit values for gray matter and white matter',[' resistivities for CSF thickness = ' num2str(1000*h1) ' mm']})
    xlabel('gray matter resistivity (ohm-m)')
    ylabel('white matter resistivity (ohm-m)')
    colormap('hot')
    c = colorbar;
    c.Label.String = 'mean square error (mV^2)';
    
    
    h = h + 1;
end
%%
makeMovie = false;
if makeMovie
    figure
    v = VideoWriter('contourVideo.mp4','MPEG-4');
    v.FrameRate = 1;
        v.Quality = 100;
    open(v)
    h = 1;

    for h1 = height_vec
        [value, index] = min(squeeze((cost_vec_3layer(h,:))));
        
        [ind1,ind2] = ind2sub(size(squeeze(cost_vec_3layer(h,:,:,:))),index);
        
        %min_height_vec = height_vec(ind1);
        % min_rho1_vec(h) = rho1_vec(ind1);
        min_rho2_vec(h) = rho2_vec(ind1);
        min_rho3_vec(h) = rho3_vec(ind2);
        %min_offset3l_vec = offset_vec(ind5);
        
        contour(rho2_vec,rho3_vec,squeeze(cost_vec_3layer(h,:,:,:))',100);
        hold on
        h2 = plot(rho2_vec(ind1),rho3_vec(ind2),'*');
        legend([h2],{'best fit point'})
        set(gca,'fontsize',14)
        title({'Best fit values for gray matter and white matter',[' resistivities for CSF thickness = ' num2str(1000*h1) ' mm']})
        xlabel('gray matter resistivity (ohm-m)')
        ylabel('white matter resistivity (ohm-m)')
        colormap('hot')
        c = colorbar;
        c.Label.String = 'mean square error (mV^2)';
        hold off
        frame = getframe(gcf);
        writeVideo(v,frame);
        
        
        h = h + 1;
    end
    close(v)
end

if makeMovie
    figure
    v = VideoWriter('contourVideo.avi');
    v.FrameRate = 1;
    v.Quality = 100;
    open(v)
    h = 1;

    for h1 = height_vec
        [value, index] = min(squeeze((cost_vec_3layer(h,:))));
        
        [ind1,ind2] = ind2sub(size(squeeze(cost_vec_3layer(h,:,:,:))),index);
        
        %min_height_vec = height_vec(ind1);
        % min_rho1_vec(h) = rho1_vec(ind1);
        min_rho2_vec(h) = rho2_vec(ind1);
        min_rho3_vec(h) = rho3_vec(ind2);
        %min_offset3l_vec = offset_vec(ind5);
        
        contour(rho2_vec,rho3_vec,squeeze(cost_vec_3layer(h,:,:,:))',100);
        hold on
        h2 = plot(rho2_vec(ind1),rho3_vec(ind2),'*');
        legend([h2],{'best fit point'})
        set(gca,'fontsize',14)
        title({'Best fit values for gray matter and white matter',[' resistivities for CSF thickness = ' num2str(1000*h1) ' mm']})
        xlabel('gray matter resistivity (ohm-m)')
        ylabel('white matter resistivity (ohm-m)')
        colormap('hot')
        c = colorbar;
        c.Label.String = 'mean square error (mV^2)';
        hold off
        frame = getframe(gcf);
        writeVideo(v,frame);
        
        
        h = h + 1;
    end
    close(v)
end

%% save it
save('symmetric_optimized_8_3_2018.mat','-v7.3')


return

%% plotting
% plot
% define colors for lines

color1 = [27,201,127]/256;
color2 = [190,174,212]/256;
color3 = [ 253,192,134]/256;
saveFigBool = false;
% setup global figure
figTotal = figure('units','normalized','outerposition',[0 0 1 1]);
figResid = figure('units','normalized','outerposition',[0 0 1 1]);
figLinear = figure('units','normalized','outerposition',[0 0 1 1]);
%

fig_ind = figure;
%fig_ind = figure('units','normalized','outerposition',[0 0 1 1]);
% select particular values for constants

rho1 = min_rho1_vec;
rho2 = min_rho2_vec;
rho3 = min_rho3_vec;
offset_1l = min_offset1l_vec;
offset_3l = min_offset3l_vec;
rhoA = min_rhoA_vec;
%h1 = subject_min_h1_vec(i);
% perform 1d optimization
[alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1);

[l1,tp] = computePotentials_1Layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,10,13);


[l3,t3] = computePotentials_3Layer(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans,offset,10,13);
%%

%residuals-factor
resid_l3 = l3-symmetricFlat;
resid_l1 = l1-symmetricFlat;
%%
R_factor1 = nansum(abs(resid_l1(~isnan(resid_l1))))/nansum(abs(symmetricFlat(~isnan(l1))));
R_factor3 = nansum(abs(resid_l3(~isnan(resid_l3))))/nansum(abs(symmetricFlat(~isnan(l3))));

% linear fits
yfit3 = fitlm(symmetricFlat(~isnan(l3)),l3(~isnan(l3)),'linear','Intercept',false);
yfit1 = fitlm(symmetricFlat(~isnan(l1)),l1(~isnan(l1)),'linear','Intercept',false);
%%

% plot individual subjects for line plots
figure(fig_ind);
plot(symmetric,'color',color1,'linewidth',2);hold on;
plot(l1,'color',color2,'linewidth',2);hold on;
plot(l3,'color',color3,'linewidth',2);hold on;
xlabel('Electrode Number')
ylabel('Voltage (V)')
legend('measured','single layer','3 layer');
%  legend('measured','single layer');

dim = [0.2 0.2 0.5 0.5];
annotation(fig_ind(i), 'textbox', dim, 'String', {['rhoA = ' num2str(min_rhoA_vec(i))],['offset 1 layer = ' num2str(min_offset1l_vec(i))]...
    ['rho1 = ' num2str(min_rho1_vec(i))],['rho2 = ' num2str(min_rho2_vec(i))],...
    ['rho3 = ' num2str(min_rho3_vec(i))], ['offset 3 layer = ' num2str(min_offset3l_vec(i))],...
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
%%
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
plot(symmetric(~isnan(l1)),l1(~isnan(l1)),'o','color',color1,'markerfacecolor',color1);
hold on;
plot(l1(~isnan(l1)),yfit1,'color',color1,'linewidth',2);

plot(symmetric(~isnan(l3)),l3(~isnan(l3)),'o','color',color2,'markerfacecolor',color2);
plot(l3(~isnan(l3)),yfit3,'color',color2,'linewidth',2);

title(sid)

% global figure of linear line plots
figure(figTotal)
subplot_total(i) = subplot(2,4,i);
plot(symmetric,'color',color1,'linewidth',2);
hold on;
plot(l1,'color',color2,'linewidth',2);hold on;
plot(l3,'color',color3,'linewidth',2);hold on;
title(sid)

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
    annotation(figTotal, 'textbox', dim{i}, 'String', {['rhoA = ' num2str(min_rhoA_vec(i))],['offset 1 layer = ' num2str(min_offset1l_vec(i))]...
        ['rho1 = ' num2str(min_rho1_vec(i))],['rho2 = ' num2str(min_rho2_vec(i))],...
        ['rho3 = ' num2str(min_rho3_vec(i))], ['offset 3 layer = ' num2str(min_offset3l_vec(i))],...
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
%% prepare data for larry

save('3_layer_1_layer_fit_vals.mat','l1_vec','l3_vec','dataTotal_8x8','sidVec')

%% save all the data
close all;
save('fineResolution_optimized.mat','-v7.3')
