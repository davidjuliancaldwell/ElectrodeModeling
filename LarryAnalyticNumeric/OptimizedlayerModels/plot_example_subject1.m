fig_ind = figure;
hold on
i = 1;

offset_1l = subject_min_offset1l_vec(i);
rhoA = subject_min_rhoA_vec(i);
[l1] = computePotentials_8x8_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset_1l);


dataMeas = dataTotal_8x8(:,i);
plot(dataMeas,'linewidth',2);
plot(l1,'linewidth',2);
legend('measured','analytic model');
title('Measured Values vs. Simple Analytic Model Fit')
xlabel('Electrode Number')
ylabel(['Voltage (V)'])

  dim = [0.2 0.2 0.5 0.5];
     annotation(fig_ind, 'textbox', dim, 'String', {['rhoA = ' num2str(subject_min_rhoA_vec(i))]},...
         'vert', 'bottom', 'FitBoxToText','on','EdgeColor','none','fontsize',14);
set(gca,'fontsize',14);
