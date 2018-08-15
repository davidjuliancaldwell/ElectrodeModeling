clear all
close all
load('all12.mat')

% 1 0b5a2e
jp=3;
kp=6;
jm=4;
km=6;
for j=1:8;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory1(j,k)=((100/dp)-(100/dm));
        Dp1(j,k)=dp;
        Dm1(j,k)=dm;
    end;
end;
E1=m0b5a2e;
T1=reshape(theory1',[64,1]);
DP1=reshape(Dp1',[64,1]);
DM1=reshape(Dm1',[64,1]);


% 2 702d24
jp=2;
kp=5;
jm=2;
km=6;
for j=1:8;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory2(j,k)=((100/dp)-(100/dm));
        Dp2(j,k)=dp;
        Dm2(j,k)=dm;
    end;
end;
E2=m702d24;
T2=reshape(theory2',[64,1]);
DP2=reshape(Dp2',[64,1]);
DM2=reshape(Dm2',[64,1]);

% 3 7dbdec
jp=2;
kp=3;
jm=2;
km=4;
for j=1:8;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory3(j,k)=((100/dp)-(100/dm));
        Dp3(j,k)=dp;
        Dm3(j,k)=dm;
    end;
end;
E3=m7dbdec;
T3=reshape(theory3',[64,1]);
DP3=reshape(Dp3',[64,1]);
DM3=reshape(Dm3',[64,1]);

% 4 9ab7ab
jp=8;
kp=3;
jm=8;
km=4;
for j=1:8;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory4(j,k)=((100/dp)-(100/dm));
        Dp4(j,k)=dp;
        Dm4(j,k)=dm;
    end;
end;
E4=m9ab7ab;
T4=reshape(theory4',[64,1]);
DP4=reshape(Dp4',[64,1]);
DM4=reshape(Dm4',[64,1]);

% 5 c91479
jp=7;
kp=7;
jm=7;
km=8;
for j=1:8;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory5(j,k)=((100/dp)-(100/dm));
        Dp5(j,k)=dp;
        Dm5(j,k)=dm;
    end;
end;
E5=mc91479;
T5=-1*reshape(theory5',[64,1]);
DP5=reshape(Dp5',[64,1]);
DM5=reshape(Dm5',[64,1]);

% 6 d5cd55
jp=7;
kp=6;
jm=8;
km=6;
for j=1:8;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory6(j,k)=((100/dp)-(100/dm));
        Dp6(j,k)=dp;
        Dm6(j,k)=dm;
    end;
end;
E6=md5cd55;
T6=reshape(theory6',[64,1]);
DP6=reshape(Dp6',[64,1]);
DM6=reshape(Dm6',[64,1]);

% 7 ecb43e
jp=7;
kp=8;
jm=8;
km=8;
for j=1:8;
    for k=1:8;
        dxp=j-jp;
        dyp=k-kp;
        dxm=j-jm;
        dym=k-km;
        dp=sqrt(dxp^2+dyp^2);
        dm=sqrt(dxm^2+dym^2);
        theory7(j,k)=((100/dp)-(100/dm));
        Dp7(j,k)=dp;
        Dm7(j,k)=dm;
    end;
end;
E7=mecb43e;
T7=reshape(theory7',[64,1]);
DP7=reshape(Dp7',[64,1]);
DM7=reshape(Dm7',[64,1]);

%
%% 2-7-2018 - DJC - fitting part

% collect all the data into one place

E_mat = [E1 E2 E3 E4 E5 E6 E7];
T_mat = [T1 T2 T3 T4 T5 T6 T7];
DP_mat = [DP1 DP2 DP3 DP4 DP5 DP6 DP7];
DM_mat = [DM1 DM2 DM3 DM4 DM5 DM6 DM7];

% define colors for plotting
colors = [253,174,107;230,85,13;188,189,220;117,107,177]/256;


%%
LogicalStr = {'false', 'true'};

for loop = [1,2]
    if loop == 1
        use_offset = true;
    else
        use_offset = false;
    end
    OUTPUT_DIR = pwd;
    saveFigBool = true;
    
    fit_vals_p_r = {};
    fit_vals_p_c = {};
    fit_vals_m_r = {};
    fit_vals_m_c = {};
    
    row_mat = [3.5,2.5,2.5,inf,inf,inf,inf,inf;
        4,4,4,4,5,5.5,inf,inf;
        inf,4,4,4,5,5.5,6.25,7;
        8,7.2,6,inf,5,inf,inf,inf;
        inf,6.5,6,inf,inf,5,5,4;
        inf,inf,inf,inf,inf,3,inf,inf;
        8.3,7.8,7,inf,inf,5,inf,inf
        ];
    
    col_mat = [6,5.5,5,4,4,4,4,4;
        6,6,5,inf,inf,inf,inf,inf;
        inf,inf,inf,inf,inf,inf,inf,inf;
        5,5,5,inf,inf,inf,inf,inf;
        inf,inf,inf,inf,inf,inf,inf,inf;
        inf,inf,inf,inf,inf,inf,inf,inf;
        8,7.5,6.5,5,5.2,4,4,5
        ];
    for i = 1:size(E_mat,2)
        %  figure_subj =figure('units','normalized','outerposition',[0 0 1 1]);
        
        
        for j = 0:size(E_mat,1)/8-1
            %subplot(8,2,2*j+1)
            
            % optimization for row
            % vanilla linear regression
            
            % 1st subject, 1st row
            distance_bool_pos_row  = DP_mat(8*j+1:8*j+8,i);
            distance_bool_neg_row = DM_mat(8*j+1:8*j+8,i);
            distance_bool_pos_row(distance_bool_pos_row<row_mat(i,j+1)) = nan;
            distance_bool_neg_row(distance_bool_neg_row<row_mat(i,j+1)) = nan;
            
            % positive
            
            y_p = E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DP_mat(8*j+1:8*j+8,i));
            x_p = T_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DP_mat(8*j+1:8*j+8,i));
            
            if use_offset
                x_p = [ones(length(x_p),1) x_p]; % include offset
            end
            
            x_p = x_p(~isnan(y_p) & ~isnan(distance_bool_pos_row),:);
            y_p = y_p(~isnan(y_p) & ~isnan(distance_bool_pos_row));
            calculated_p =x_p\y_p;
            
            % r square
            yfit_p = x_p*calculated_p;
            
            yresid_p = y_p - yfit_p;
            SSresid_p = sum(yresid_p.^2);
            SStotal_p = (length(y_p)-1) * var(y_p);
            rsq_p = 1 - SSresid_p/SStotal_p;
            
            % negative
            
            y_m = E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DM_mat(8*j+1:8*j+8,i));
            x_m = T_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DM_mat(8*j+1:8*j+8,i));
            
            if use_offset
                x_m = [ones(length(x_m),1) x_m]; % include offset
            end
            x_m = x_m(~isnan(y_m) & ~isnan(distance_bool_neg_row),:);
            y_m = y_m(~isnan(y_m) & ~isnan(distance_bool_neg_row));
            
            calculated_m = x_m\y_m;
            
            % r square
            yfit_m = x_m*calculated_m;
            
            yresid_m = y_m - yfit_m;
            SSresid_m = sum(yresid_m.^2);
            SStotal_m = (length(y_m)-1) * var(y_m);
            rsq_m = 1 - SSresid_m/SStotal_m;
            
            % plotting for the row
            %subplot_ind(j+1) = subplot(4,4,j+1);
            figure_subj = figure;
            plot(DP_mat(8*j+1:8*j+8,i),E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DP_mat(8*j+1:8*j+8,i)),'color',colors(1,:),'linewidth',2);hold on;
            plot(DM_mat(8*j+1:8*j+8,i),E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DM_mat(8*j+1:8*j+8,i)),'color',colors(3,:),'linewidth',2);hold on;
            
            plot(distance_bool_pos_row(~isnan(distance_bool_pos_row)),yfit_p,'color',colors(2,:),'linewidth',2);hold on;
            plot(distance_bool_neg_row(~isnan(distance_bool_neg_row)),yfit_m,'color',colors(4,:),'linewidth',2);hold on;
            legend('E/D*T scaled by distance to positive electrode','E/D*T scaled by distance to negative electrode',...
                'coeff*T/D*T scaled by distance to positive electrode','coeff*T/D*T scaled by distance to negative electrode')
            xlabel('Distance to electrode (cm)')
            ylabel('Plot of E/D*T and coeff*T/D*T')
            title(['row ' num2str(j+1) '- Subject ' num2str(i)])
            
            num_p_r{i,j+1} = length(distance_bool_pos_row(~isnan(distance_bool_pos_row)));
            num_m_r{i,j+1} = length(distance_bool_neg_row(~isnan(distance_bool_neg_row)));
            
            fit_vals_p_r{i,j+1} = calculated_p;
            fit_vals_m_r{i,j+1} = calculated_m;
            
            
            dim = [0.15 0.15 0.5 0.5];
            if use_offset
                annotation('textbox', dim, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_r{i,j+1}(2))],...
                    ['offset positive = ' num2str(fit_vals_p_r{i,j+1}(1))],['Slope coefficient negative = ' num2str(fit_vals_m_r{i,j+1}(2))],...
                    ['offset negative = ' num2str(fit_vals_m_r{i,j+1}(1))]},...
                    'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
            else
                annotation('textbox', dim, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_r{i,j+1})],...
                    ['Slope coefficient negative = ' num2str(fit_vals_m_r{i,j+1})]},...
                    'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
            end
            
            if saveFigBool && ~isinf(row_mat(i,j+1))
                SaveFig(OUTPUT_DIR,sprintf(['subj_' num2str(i) 'row_' num2str(j+1) '_offset_' LogicalStr{use_offset+1}]), 'png', '-r600');
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % now onto the columns
            
            % positive
            % subplot(8,2,2*(j+1))
            % subplot_ind(j+9) = subplot(4,4,j+9);
            figure_subj = figure;
            distance_bool_pos_col  = DP_mat(j+1:8:64-7+j,i);
            distance_bool_neg_col = DM_mat(j+1:8:64-7+j,i);
            distance_bool_pos_col(distance_bool_pos_col<col_mat(i,j+1)) = nan;
            distance_bool_neg_col(distance_bool_neg_col<col_mat(i,j+1)) = nan;
            
            % optimization for column
            % vanilla linear regression
            y_p = E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DP_mat(j+1:8:64-7+j,i));
            x_p = T_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DP_mat(j+1:8:64-7+j,i));
            if use_offset
                x_p = [ones(length(x_p),1) x_p]; % include offset
            end
            
            x_p = x_p(~isnan(y_p) & ~isnan(distance_bool_pos_col),:);
            y_p = y_p(~isnan(y_p) & ~isnan(distance_bool_pos_col));
            calculated_p =x_p\y_p;
            
            % r square
            yfit_p = x_p*calculated_p;
            
            yresid_p = y_p - yfit_p;
            SSresid_p = sum(yresid_p.^2);
            SStotal_p = (length(y_p)-1) * var(y_p);
            rsq_p = 1 - SSresid_p/SStotal_p;
            
            % negative
            
            y_m = E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DM_mat(j+1:8:64-7+j,i));
            x_m = T_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DM_mat(j+1:8:64-7+j,i));
            
            if use_offset
                x_m = [ones(length(x_m),1) x_m]; % include offset
            end
            x_m = x_m(~isnan(y_m) & ~isnan(distance_bool_neg_col),:);
            y_m = y_m(~isnan(y_m) & ~isnan(distance_bool_neg_col));
            
            calculated_m = x_m\y_m;
            
            % r square
            yfit_m = x_m*calculated_m;
            
            yresid_m = y_m - yfit_m;
            SSresid_m = sum(yresid_m.^2);
            SStotal_m = (length(y_m)-1) * var(y_m);
            rsq_m = 1 - SSresid_m/SStotal_m;
            
            % plotting for the column
            
            plot(DP_mat(j+1:8:64-7+j,i),E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DP_mat(j+1:8:64-7+j,i)),'color',colors(1,:),'linewidth',2);hold on;
            plot(DM_mat(j+1:8:64-7+j,i),E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DM_mat(j+1:8:64-7+j,i)),'color',colors(3,:),'linewidth',2);hold on;
            plot(distance_bool_pos_col(~isnan(distance_bool_pos_col)),yfit_p,'color',colors(2,:),'linewidth',2);hold on;
            plot(distance_bool_neg_col(~isnan(distance_bool_neg_col)),yfit_m,'color',colors(4,:),'linewidth',2);hold on;
            legend('E/D*T scaled by distance to positive electrode','E/D*T scaled by distance to negative electrode',...
                'coeff*T/D*T scaled by distance to positive electrode','coeff*T/D*T scaled by distance to negative electrode')
            xlabel('Distance to electrode (cm)')
            ylabel('Plot of E/D*T and coeff*T/D*T')
            title(['column ' num2str(j+1) '- Subject ' num2str(i)])
            
            
            num_p_c{i,j+1} = length(distance_bool_pos_col(~isnan(distance_bool_pos_col)));
            num_m_c{i,j+1} = length(distance_bool_neg_col(~isnan(distance_bool_neg_col)));
            
            fit_vals_p_c{i,j+1} = calculated_p;
            fit_vals_m_c{i,j+1} = calculated_m;
            
            
            dim = [0.15 0.15 0.5 0.5];
            if use_offset
                annotation('textbox', dim, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_c{i,j+1}(2))],...
                    ['offset positive = ' num2str(fit_vals_p_c{i,j+1}(1))],['Slope coefficient negative = ' num2str(fit_vals_m_c{i,j+1}(2))],...
                    ['offset negative = ' num2str(fit_vals_m_c{i,j+1}(1))]},...
                    'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
            else
                annotation('textbox', dim, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_c{i,j+1})],...
                    ['Slope coefficient negative = ' num2str(fit_vals_m_c{i,j+1})]},...
                    'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
            end
            
            
            if saveFigBool && ~isinf(col_mat(i,j+1))
                SaveFig(OUTPUT_DIR,sprintf(['subj_' num2str(i) 'col_' num2str(j+1) '_offset_' LogicalStr{use_offset+1}]), 'png', '-r600');
            end
            
        end
        
        %     lg = legend('E/D*T scaled by distance to positive electrode','E/D*T scaled by distance to negative electrode',...
        %         'coeff*T/D*T + offset scaled by distance to positive electrode','coeff*T/D*T + offset scaled by distance to negative electrode');
        %     lg.Location = 'southeast';
        %     xlabel('Distance to electrode (cm)')
        %     ylabel('Plot of E/D*T and coeff*T/D*T')
        format short
        %     arrayfun(@(x) pbaspect(x, [1 1 1]), subplot_ind);
        %     drawnow;
        %     pos = arrayfun(@plotboxpos, subplot_ind, 'uni', 0);
        %     dim = cellfun(@(x) x.*[1 1 0.5 0.5], pos, 'uni',0);
        %     for i = 1:size(E_mat,1)/8
        %         annotation(figure_subj, 'textbox', dim{i}, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_r(1,i))],...
        %             ['offset positive = ' num2str(fit_vals_p_r(2,i))],['Slope coefficient negative = ' num2str(fit_vals_m_r(1,i))],...
        %             ['offset negative = ' num2str(fit_vals_m_r(2,i))]},...
        %             'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
        %
        %         annotation(figure_subj, 'textbox', dim{i+8}, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_c(1,i))],...
        %             ['offset positive = ' num2str(fit_vals_p_c(2,i))],['Slope coefficient negative = ' num2str(fit_vals_m_c(1,i))],...
        %             ['offset negative = ' num2str(fit_vals_m_c(2,i))]},...
        %             'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
        
        %     end
        
        %     if saveFigBool
        %         SaveFig(OUTPUT_DIR,sprintf(['exp_over_theory_fit_subj_' num2str(i)]), 'png', '-r600');
        %     end
        
    end
    close all
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % now with fit vals histogram
    bin_lims = [-1e-3 1e-3];
    num_bins = 15;
    
    if ~use_offset
        
        for i = 1:size(E_mat,2)
            figure
            hold on
            fit_vals_p_r_select = [];
            fit_vals_m_r_select = [];
            fit_vals_p_c_select = [];
            fit_vals_m_c_select = [];
            
            for j = 0:size(E_mat,1)/8-1
                
                if ~isinf(row_mat(i,j+1))
                    if num_p_r{i,j+1} > 1
                        fit_vals_p_r_select = [fit_vals_p_r_select fit_vals_p_r{i,j+1}];
                    end
                    if num_m_r{i,j+1} >1
                        fit_vals_m_r_select = [fit_vals_m_r_select fit_vals_m_r{i,j+1}];
                    end
                end
                
                if ~isinf(col_mat(i,j+1))
                    if num_p_c{i,j+1} > 1
                        fit_vals_p_c_select = [fit_vals_p_c_select fit_vals_p_c{i,j+1}];
                    end
                    if num_m_c{i,j+1} > 1
                        fit_vals_m_c_select = [fit_vals_m_r_select fit_vals_m_r{i,j+1}];
                    end
                end
            end
            histogram(fit_vals_p_r_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_m_r_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_p_c_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_m_c_select,num_bins,'binlimits',bin_lims)
            xlim(bin_lims)
            legend('pos,row','neg,row','pos,col','neg,col')
            title(['coeff subject -  ' num2str(i) ' - no offset'])
            
            if saveFigBool 
                SaveFig(OUTPUT_DIR,sprintf(['subj_' num2str(i) 'histogram_coeff' '_offset_' LogicalStr{use_offset+1}]), 'png', '-r600');
            end
            
        end
        
    else
        
        for i = 1:size(E_mat,2)
            figure
            hold on
            fit_vals_p_r_select = [];
            fit_vals_m_r_select = [];
            fit_vals_p_c_select = [];
            fit_vals_m_c_select = [];
            
            for j = 0:size(E_mat,1)/8-1
                
                if ~isinf(row_mat(i,j+1))
                    if num_p_r{i,j+1} > 1
                        fit_vals_p_r_select = [fit_vals_p_r_select fit_vals_p_r{i,j+1}(2)];
                    end
                    if num_m_r{i,j+1} > 1
                        fit_vals_m_r_select = [fit_vals_m_r_select fit_vals_m_r{i,j+1}(2)];
                    end
                end
                
                if ~isinf(col_mat(i,j+1))
                    if num_p_c{i,j+1} > 1
                        fit_vals_p_c_select = [fit_vals_p_c_select fit_vals_p_c{i,j+1}(2)];
                    end
                    if num_m_c{i,j+1} > 1
                        fit_vals_m_c_select = [fit_vals_m_r_select fit_vals_m_r{i,j+1}(2)];
                    end
                end
            end
            histogram(fit_vals_p_r_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_m_r_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_p_c_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_m_c_select,num_bins,'binlimits',bin_lims)
            xlim(bin_lims)
            legend('pos,row','neg,row','pos,col','neg,col')
            title(['coeff - subject ' num2str(i) ' - offset'])
            
            if saveFigBool 
                SaveFig(OUTPUT_DIR,sprintf(['subj_' num2str(i) 'histogram_coeff' '_offset_' LogicalStr{use_offset+1}]), 'png', '-r600');
            end
        end
        
        
        for i = 1:size(E_mat,2)
            figure
            hold on
            fit_vals_p_r_select = [];
            fit_vals_m_r_select = [];
            fit_vals_p_c_select = [];
            fit_vals_m_c_select = [];
            
            for j = 0:size(E_mat,1)/8-1
                
                if ~isinf(row_mat(i,j+1))
                    if num_p_r{i,j+1} > 1
                        fit_vals_p_r_select = [fit_vals_p_r_select fit_vals_p_r{i,j+1}(1)];
                    end
                    if num_m_r{i,j+1} > 1
                        fit_vals_m_r_select = [fit_vals_m_r_select fit_vals_m_r{i,j+1}(1)];
                    end
                end
                
                if ~isinf(col_mat(i,j+1))
                    if num_p_c{i,j+1} > 1
                        fit_vals_p_c_select = [fit_vals_p_c_select fit_vals_p_c{i,j+1}(1)];
                    end
                    if num_m_c{i,j+1} > 1
                        fit_vals_m_c_select = [fit_vals_m_r_select fit_vals_m_r{i,j+1}(1)];
                    end
                end
            end
            histogram(fit_vals_p_r_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_m_r_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_p_c_select,num_bins,'binlimits',bin_lims)
            histogram(fit_vals_m_c_select,num_bins,'binlimits',bin_lims)
            xlim(bin_lims)
            legend('pos,row','neg,row','pos,col','neg,col')
            title(['offset - subject ' num2str(i)])
            
            if saveFigBool 
                SaveFig(OUTPUT_DIR,sprintf(['subj_' num2str(i) 'histogram_offset' '_offset_' LogicalStr{use_offset+1}]), 'png', '-r600');
            end
        end
        
    end
    close all
end