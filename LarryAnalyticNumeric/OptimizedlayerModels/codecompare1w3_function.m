%% initialize workspace 
clear all
load('all12.mat')

% define matrices to iterate over
dataTotal_8x8 = [m0b5a2e m702d24 m7dbdec m9ab7ab mc91479 md5cd55 mecb43e];
dataTotal_8x4 = [m2012(1,:)' m2804(1,:)' m2318(1,:)' m2219(1,:)' m2120(1,:)'];
sidVec = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e','m2012','m2804','m2318','m2219','m2120'};
currentMat = [0.00175 0.00075 0.0035 0.00075 0.003 0.0025 0.00175 0.0005 0.0005 0.0005 0.0005 0.0005] ;
stimChansVec = [22 30; 13 14; 11 12; 59 60; 55 56; 54 62; 56 64; 12 20; 4 28; 18 23; 19 22; 21 20];
jp_vec = [3 2 2 8 7 7 7 3 4 3 3 3];
kp_vec = [6 5 3 3 7 6 8 4 4 7 6 5];
jm_vec = [4 2 2 8 7 8 8 2 1 3 3 3];
km_vec = [6 6 4 4 8 6 8 4 4 2 3 4];
%% recreating Larry's plots, no optimization, just function calls
rhoA=0.9;
rho1=0.6;
rho2=1;
rho3=1;
h1=0.001;
a=0.00115;
R=0.00115;
d=0.0035;

% setup global figure
figTotal = figure();
%

% define colors 
color1 = [27,201,127]/256;
color2 = [190,174,212]/256;
color3 = [ 253,192,134]/256;


% loop through subjects
for i = 1:length(sidVec)
    
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    stimChans = stimChansVec(i,:);
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    
    % define constants depending on these specific values
    [alpha,beta,eh1,eh2,ed,step,scale] = defineConstants(i0,a,R,rho1,rho2,rho3,d,h1);
    
    % extract measured data and calculate theoretical ones
    if i <= 7 % 8x8 cases
        dataMeas = dataTotal_8x8(:,i);
        [l1] = computePotentials_8x8_l1(jp,kp,jm,km,rhoA,i0,stimChans);
        [l3] = computePotentials_8x8_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans);
    else % 8x4 case
        dataMeas = dataTotal_8x4(:,i-7);
        [l1] = computePotentials_8x4_l1(jp,kp,jm,km,rhoA,i0,stimChans);
        [l3] = computePotentials_8x4_l3(jp,kp,jm,km,alpha,beta,eh1,eh2,step,ed,scale,a,stimChans);
    end
    % c91479 was flipped l1 l3
    if strcmp(sid,'c91479')
        l1 = -l1;
        l3 = -l3;
    end
    
    % plot individual subjects
    figure;
    plot(dataMeas);hold on;
    plot(l3,'r');hold on;
    plot(l1,'c');hold on;
    xlabel('Electrode Number')
    ylabel('Voltage (\muV)')
    legend('measured','three layer','single layer');
    title(sid)
    
    % plot them all on one figure with subplots
    figure(figTotal)
    subplot(3,4,i);plot(dataMeas,'color',color1);hold on;
    subplot(3,4,i);plot(l3,'color',color2);hold on;
    subplot(3,4,i);plot(l1,'color',color3);hold on;
    title(sid)
    
end

xlabel('Electrode Number')
ylabel('Voltage (\muV)')
legend('measured','three layer','single layer');


