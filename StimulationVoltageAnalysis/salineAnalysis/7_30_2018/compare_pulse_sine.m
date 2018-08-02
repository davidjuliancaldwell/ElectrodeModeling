%% compare pulses and sine waves from the TDT
% 7.31.2018 David.J.Caldwell

close all;clear all;clc

DATA_DIR = 'G:\My Drive\GRIDLabDavidShared\SummerStudents2018\chris_and_sonia\7_30_2018_sineWave_pulses';
PULSE_DIR = 'G:\My Drive\GRIDLabDavidShared\SummerStudents2018\chris_and_sonia\7_30_2018_sineWave_pulses\MATLABconverted\pulses';
SINE_DIR = 'G:\My Drive\GRIDLabDavidShared\SummerStudents2018\chris_and_sonia\7_30_2018_sineWave_pulses\MATLABconverted\sine_wave';

pulseFile = 1;
sineFile = 1;

% pulse data
load(fullfile(PULSE_DIR,['stimGeometry-' num2str(pulseFile)]))
Pdata =[ECO1.data ECO2.data(:,1:24)];
Pstim = Stim;
Psing = Sing;

% sine data
load(fullfile(SINE_DIR,['stimGeometrySineWave-' num2str(sineFile)]))

Sdata =[ECO1.data ECO2.data(:,1:31)];
Sstim = Stim;
Ssing = Sing;

fsStim = Stim.info.SamplingRateHz;
fsSing = Sing.info.SamplingRateHz;

stimChansSineVec = [28 29; 28 29; 28 29; 28 29; 28 29; 20 21; 20 21; 20 21; 20 21; 28 29];
stimChansPulseVec = [20 21; 20 21; 20 21; 20 21; 28 29; 28 29; 28 29; 28 29; 28 29];

stimChansSine = stimChansSineVec(:,sineFile);
stimChansPulse = stimChansPulseVec(:,pulseFile);

%% stimulation voltage monitor
plotIt = 0;
savePlot = 0;
[Pstim1Epoched,t,fs,labels,uniqueLabels] = voltage_monitor(Stim,Sing,plotIt,savePlot,'','','');
[Sstim1Epoched,t,fs,labels,uniqueLabels] = voltage_monitor_sine_wave(Stim,Sing,plotIt,savePlot,'','','');

%% extract average signals

[sts,bursts] = get_epoch_indices(sing,fsData,fsSing);

dataEpoched = squeeze(getEpochSignal(data,sts-preSamps,sts+postSamps+1));
% set the time vector to be set by the pre and post samps
t = (-preSamps:postSamps)*1e3/fsData;

%% plot epoched signals
scaling = 'y';
plot_unique_epochs(dataEpoched,t,uniqueLabels,labels,stimChans,scaling)


%% extract averages, means, and standard deviations
count = 1;

preSampsExtract = 3;
postSampsExtract = 3;
plotIt = 0;

for i = uniqueLabels
    dataEpochedInt = dataEpoched(:,:,labels==i);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpochedInt,'fs',fsData,'preSamps',preSampsExtract,'postSamps',postSampsExtract,'plotIt',plotIt);
    
    meanMat(stimChans,:) = nan;
    stdMat(stimChans,:) = nan;
    extractCell{stimChans(1)}{1} = nan;
    extractCell{stimChans(1)}{2}= nan;
    extractCell{stimChans(2)}{1}= nan;
    extractCell{stimChans(2)}{2}= nan;
    stdCellEveryPoint{stimChans(1)} = {nan,nan};
    stdCellEveryPoint{stimChans(2)} =  {nan,nan};
    
    meanMatAll(:,:,count) = meanMat;
    stdMatAll(:,:,count) = stdMat;
    numberStimsAll(count) = numberStims;
    stdEveryPoint{count} = stdCellEveryPoint;
    
    
    count = count + 1;
end


%% 2d plot
plot_2d_heatmap(meanMatAll(1:64,:,:),64,uniqueLabels,stimChans)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


conditionInterest = 7; % condition of interest
i0 = uniqueLabels(7)/1e6; % current in uA to A
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

% stim 2829
i0=1e-3;
%rhoA=1;
jp=4;
kp=4;
jm=4;
km=5;

% perform 1d optimization
j = 1;
for rhoA = rhoA_vec
    % extract measured data and calculate theoretical ones
    k = 1;
    for offset = offset_vec
        
        [l1,tp] = computePotentials_1Layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,8,8);
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
