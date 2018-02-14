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
colors = [127,205,187;44,127,184;250,159,181;197,27,138]/256;
figure

for i = 1:size(E_mat,2)
    figure_subj =figure('units','normalized','outerposition',[0 0 1 1]);
    
    fit_vals_p_r_total = [];
    fit_vals_p_c_total = [];
    fit_vals_m_r_total = [];
    fit_vals_m_c_total = [];
    
    for j = 0:size(E_mat,1)/8-1
        %subplot(8,2,2*j+1)
        
        % optimization for row
        % vanilla linear regression
        
        y_p = E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DP_mat(8*j+1:8*j+8,i));
        x_p = T_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DP_mat(8*j+1:8*j+8,i));
        x_p = [ones(length(x_p),1) x_p];
        calculated_p = x_p(~isnan(y_p),:)\y_p(~isnan(y_p));
        
        y_m = E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DM_mat(8*j+1:8*j+8,i));
        x_m = T_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DM_mat(8*j+1:8*j+8,i));
        x_m = [ones(length(x_m),1) x_m];
        calculated_m = x_m(~isnan(y_m),:)\y_m(~isnan(y_m));
        
        % plotting for the row
        subplot_ind(j+1) = subplot(4,4,j+1);
        plot(DP_mat(8*j+1:8*j+8,i),E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DP_mat(8*j+1:8*j+8,i)),'color',colors(1,:));hold on;
        plot(DM_mat(8*j+1:8*j+8,i),E_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DM_mat(8*j+1:8*j+8,i)),'color',colors(3,:));hold on;
        plot(DP_mat(8*j+1:8*j+8,i),(calculated_p(2)*T_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DP_mat(8*j+1:8*j+8,i))+calculated_p(1)),'color',colors(2,:));hold on;
        plot(DM_mat(8*j+1:8*j+8,i),(calculated_m(2)*T_mat(8*j+1:8*j+8,i)./(T_mat(8*j+1:8*j+8,i).*DM_mat(8*j+1:8*j+8,i))+calculated_m(1)),'color',colors(4,:));hold on;
        %         legend('E/D*T scaled by distance to positive electrode','E/D*T scaled by distance to negative electrode',...
        %             'coeff*T/D*T scaled by distance to positive electrode','coeff*T/D*T scaled by distance to negative electrode')
        %         xlabel('Distance to electrode (cm)')
        %         ylabel('Plot of E/D*T and coeff*T/D*T')
        title(['row ' num2str(j) '- Subject ' num2str(i)])
        
        fit_vals_p_r(:,j+1) = calculated_p;
        fit_vals_m_r(:,j+1) = calculated_m;
        
         fit_vals_p_r_total(i,:,:) = fit_vals_p_r;
         fit_vals_m_r_total(i,:,:) = fit_vals_m_r;
        % now onto the columns
        
        % subplot(8,2,2*(j+1))
        subplot_ind(j+9) = subplot(4,4,j+9);
        
        % optimization for column
        % vanilla linear regression
        y_p = E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DP_mat(j+1:8:64-7+j,i));
        x_p = T_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DP_mat(j+1:8:64-7+j,i));
        x_p = [ones(length(x_p),1) x_p];
        calculated_p = x_p(~isnan(y_p),:)\y_p(~isnan(y_p));
        
        y_m = E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DM_mat(j+1:8:64-7+j,i));
        x_m = T_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DM_mat(j+1:8:64-7+j,i));
        x_m = [ones(length(x_m),1) x_m];
        calculated_m = x_m(~isnan(y_m),:)\y_m(~isnan(y_m));
        
        % plotting for the column
        
        plot(DP_mat(j+1:8:64-7+j,i),E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DP_mat(j+1:8:64-7+j,i)),'color',colors(1,:));hold on;
        plot(DM_mat(j+1:8:64-7+j,i),E_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DM_mat(j+1:8:64-7+j,i)),'color',colors(3,:));hold on;
        plot(DP_mat(j+1:8:64-7+j,i),(calculated_p(2)*T_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DP_mat(j+1:8:64-7+j,i))+calculated_p(1)),'color',colors(2,:));hold on;
        plot(DM_mat(j+1:8:64-7+j,i),(calculated_m(2)*T_mat(j+1:8:64-7+j,i)./(T_mat(j+1:8:64-7+j,i).*DM_mat(j+1:8:64-7+j,i))+calculated_m(1)),'color',colors(4,:));hold on;
        %         legend('E/D*T scaled by distance to positive electrode','E/D*T scaled by distance to negative electrode',...
        %             'coeff*T/D*T scaled by distance to positive electrode','coeff*T/D*T scaled by distance to negative electrode')
        %         xlabel('Distance to electrode (cm)')
        %         ylabel('Plot of E/D*T and coeff*T/D*T')
        title(['column ' num2str(j) '- Subject ' num2str(i)])
        
        fit_vals_p_c(:,j+1) = calculated_p;
        fit_vals_m_c(:,j+1) = calculated_m;
        
         fit_vals_p_c_total(i,:,:) = fit_vals_p_c;
         fit_vals_m_c_total(i,:,:) = fit_vals_m_c;
    end
    
    lg = legend('E/D*T scaled by distance to positive electrode','E/D*T scaled by distance to negative electrode',...
        'coeff*T/D*T + offset scaled by distance to positive electrode','coeff*T/D*T + offset scaled by distance to negative electrode');
    lg.Location = 'southeast';
    xlabel('Distance to electrode (cm)')
    ylabel('Plot of E/D*T and coeff*T/D*T')
    format short
    arrayfun(@(x) pbaspect(x, [1 1 1]), subplot_ind);
    drawnow;
    pos = arrayfun(@plotboxpos, subplot_ind, 'uni', 0);
    dim = cellfun(@(x) x.*[1 1 0.5 0.5], pos, 'uni',0);
    for i = 1:size(E_mat,1)/8
        annotation(figure_subj, 'textbox', dim{i}, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_r(1,i))],...
            ['offset positive = ' num2str(fit_vals_p_r(2,i))],['Slope coefficient negative = ' num2str(fit_vals_m_r(1,i))],...
            ['offset negative = ' num2str(fit_vals_m_r(2,i))]},...
            'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
        
        annotation(figure_subj, 'textbox', dim{i+8}, 'String', {['Slope coefficient positive = ' num2str(fit_vals_p_c(1,i))],...
            ['offset positive = ' num2str(fit_vals_p_c(2,i))],['Slope coefficient negative = ' num2str(fit_vals_m_c(1,i))],...
            ['offset negative = ' num2str(fit_vals_m_c(2,i))]},...
            'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none');
        
    end
    
    OUTPUT_DIR = pwd;
    saveFigBool = false;
    if saveFigBool
        SaveFig(OUTPUT_DIR,sprintf(['exp_over_theory_fit_subj_' num2str(i)]), 'png', '-r600');
    end
    
end