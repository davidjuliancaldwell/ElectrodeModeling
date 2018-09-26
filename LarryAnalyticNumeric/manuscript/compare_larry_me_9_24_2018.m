load('Aug29Workspace')

figure;
hold on;subplot(2,4,1);plot(rr,rhoA1)
hold on;subplot(2,4,1);plot(rr2,rhoA1,'r')
hold on;subplot(2,4,2);plot(rr,rhoA2)
hold on;subplot(2,4,2);plot(rr2,rhoA2,'r')
hold on;subplot(2,4,3);plot(rr,rhoA3)
hold on;subplot(2,4,3);plot(rr2,rhoA3,'r')
hold on;subplot(2,4,4);plot(rr,rhoa4)
hold on;subplot(2,4,4);plot(rr2,rhoa4,'r')
hold on;subplot(2,4,5);plot(rr,rhoA5)
hold on;subplot(2,4,5);plot(rr2,rhoA5,'r')
hold on;subplot(2,4,6);plot(rr,rhoA6)
hold on;subplot(2,4,6);plot(rr2,rhoA6,'r')
hold on;subplot(2,4,7);plot(rr,rhoA7)
hold on;subplot(2,4,7);plot(rr2,rhoA7,'r')


hold on;subplot(2,4,1);plot(0.5*(rr+rr2),rhoA1,'go')
hold on;subplot(2,4,2);plot(0.5*(rr+rr2),rhoA2,'go')
hold on;subplot(2,4,3);plot(0.5*(rr+rr2),rhoA3,'go')
hold on;subplot(2,4,4);plot(0.5*(rr+rr2),rhoa4,'go')
hold on;subplot(2,4,5);plot(0.5*(rr+rr2),rhoA5,'go')
hold on;subplot(2,4,6);plot(0.5*(rr+rr2),rhoA6,'go')
hold on;subplot(2,4,7);plot(0.5*(rr+rr2),rhoA7,'go')


%%
load('Aug29Workspace')
load('9-24-2018-dataDavid')

%
figure;
%hold on;subplot(2,4,1);plot(rr,rhoA1)
hold on;subplot(2,4,1);plot(rr2,rhoA1,'r'); hold on
plot(rhoA_subj(1,1:5)'); 
%hold on;subplot(2,4,2);plot(rr,rhoA2)
hold on;subplot(2,4,2);plot(rr2,rhoA2,'r'); hold on
plot(rhoA_subj(2,1:5)')
%hold on;subplot(2,4,3);plot(rr,rhoA3)
hold on;subplot(2,4,3);plot(rr2,rhoA3,'r'); hold on
plot(rhoA_subj(3,1:5)')
%hold on;subplot(2,4,4);plot(rr,rhoa4)
hold on;subplot(2,4,4);plot(rr2,rhoa4,'r'); hold on
plot(rhoA_subj(4,1:5)')
%hold on;subplot(2,4,5);plot(rr,rhoA5)
hold on;subplot(2,4,5);plot(rr2,rhoA5,'r'); hold on
plot(rhoA_subj(5,1:5)')
%hold on;subplot(2,4,6);plot(rr,rhoA6)
hold on;subplot(2,4,6);plot(rr2,rhoA6,'r'); hold on
plot(rhoA_subj(6,1:5)')
%hold on;subplot(2,4,7);plot(rr,rhoA7)
hold on;subplot(2,4,7);plot(rr2,rhoA7,'r'); hold on
plot(rhoA_subj(7,1:5)')
legend('larry','david')

%% plot rhoA by bin for subjects

figure
plot(rhoA_subj(:,1:5)','-o','linewidth',2)
legend({'1','2','3','4','5','6','7','8'})
xlabel('bin')
ylabel('rhoA (ohm-m)')
title('one layer apparent resistivity by subject and bin')
set(gca,'fontsize',18)

