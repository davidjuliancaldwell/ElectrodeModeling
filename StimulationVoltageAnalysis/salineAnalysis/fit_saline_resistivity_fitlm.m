%% script to fit layered models to saline stimulation 
%
% David.J.Caldwell 7.19.2018

dataDir = 'G:\My Drive\GRIDLabDavidShared\SummerStudents2018\chris_and_sonia\7-18-2018\processedData';
highResist = '2-91ms-cm-solution5';
lowResist = '19-57ms-cm-solution1';

stimChans = [28 29];
badChans = [27];
load(fullfile(dataDir,lowResist,['salineAnalysis_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']))

%%

conditionInterest = 4; % condition of interest 
i0 = uniqueLabels(4)/1e6; % current in uA to A
dataInt(stimChans) = nan;
dataInt(badChans) = nan;
dataInt = meanMatAll(:,1,conditionInterest);
dataIntReshape = reshape(dataInt,8,8);
% perform optimization for the 1 layer case


a=0.00115;
R=0.00115;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% optimization for 1 layer
rhoA_vec=[0.1:0.001:3.5];
%offset_vec=[-3e-3:1e-5:3e-3];
offset_vec = [0,1];
offset_vec = [0];
cost_vec_1layer = zeros(length(rhoA_vec),length(offset_vec));

min_rhoA_vec = zeros(1);
min_offset1l_vec = zeros(1);
%%

% Calculate voltages
jp=5;
kp=4;
jm=4;
km=4;

% perform 1d optimization
j = 1;
for rhoA = rhoA_vec
    % extract measured data and calculate theoretical ones
    k = 1;
    for offset = offset_vec
        
        [l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,8,8);
        tp = tp/1000 ;
        l1 = tp/1000;
        % use sum sqaured
        
        % scale the data
        ratio = max(dataIntReshape(:))/max(tp(:));


        sqLoss = (dataIntReshape*ratio-tp).^2;
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

%%
figure
subplot(2,1,1)
imagesc(tp)
title('theory')

colorbar
subplot(2,1,2)
imagesc(dataIntReshape)
colorbar
title('experiment')