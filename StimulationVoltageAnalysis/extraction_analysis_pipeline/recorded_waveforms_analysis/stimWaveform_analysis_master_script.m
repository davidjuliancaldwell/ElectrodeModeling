%%
close all;clear all;clc
Z_Constants_Resistivity
addpath(SUBJECT_DIR)
%% go through first seven subjects first
preSamps = 3;
postSamps = 3;
plotIt = 1;

%% factor of 4 is included in here NOW within voltage_extract_avg

% data for further analysis
meanMatAll_1st7 = zeros(64,2,7);
stdMatAll_1st7 = zeros(64,2,7);
numberStimsAll_1st7 = zeros(7,1);
stdEveryPoint_1st7 = {};
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

% stimulation currents in A
stimChans_first7 = [22 30;13 14;11 12;59 60;56 55;54 62;56 64; 28 27];
currentMat_first7 = [0.00175 0.00075 0.0035 0.00075 0.003 0.0025 0.00175 0.002];

first_7_struct.stimChans = stimChans_first7;
first_7_struct.currentMat = currentMat_first7;

for ii = 1:7
    sid = SIDS{ii};
    fprintf(['running for subject ' sid '\n']);
    fs = 12207;
    stimChans_subj = stimChans_first7(ii,:);
    load(fullfile([sid '_StimulationAndCCEPs.mat']))
    ECoGData = permute(ECoGData,[1 3 2]);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_1st7(:,:,ii) = meanMat;
    stdMatAll_1st7(:,:,ii) = stdMat;
    numberStimsAll_1st7(ii) = numberStims;
    stdEveryPoint_1st7{ii} = stdCellEveryPoint;
    
    
    if plotIt
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        chanVec = [1:size(ECoGData,2)];
        figure
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
        hold on
        errorbar(chanVec+0.3,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title(['Mean and Standard Deviation for Recorded Biphasic Pulse'])
        set(gca,'fontsize',16)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure(figTotal)
        subplot(4,2,ii)
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
        
        title(['Subject ' num2str(ii)])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({['Subject ' num2str(ii)],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
        
    end
end
if plotIt
    figure(figTotal)
    
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_first7']),'png');
    
end

first_7_struct.meanMat = meanMatAll_1st7;
first_7_struct.stdMat = meanMatAll_1st7;
first_7_struct.numberStims = meanMatAll_1st7;
first_7_struct.stdEveryPoint = meanMatAll_1st7;


%% go through 48 for 0a80cf

stimChans_0a80cf = [ 28 27];
currentMat_0a80cf = [ 0.002];
sid = '0a80cf';
subj_0a80cf_struct.stimChans = stimChans_0a80cf;
subj_0a80cf_struct.currentMat = currentMat_0a80cf ;

for ii = 1:1
    fprintf(['running for subject ' sid '\n']);
    
    fs = 12207;
    
    stimChans_subj = stimChans_0a80cf(ii,:);
    load(fullfile([sid '_StimulationAndCCEPs.mat']))
    ECoGData = permute(ECoGData,[1 3 2]);
    ECoGData = ECoGData(:,[1:48],:);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_0a80cf(:,:,ii) = meanMat;
    stdMatAll_0a80cf(:,:,ii) = stdMat;
    numberStimsAll_0a80cf(ii) = numberStims;
    stdEveryPoint_0a80cf{ii} = stdCellEveryPoint;
    
    if plotIt
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        chanVec = [1:size(ECoGData,2)];
        figure
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
        hold on
        errorbar(chanVec+0.3,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title(['Mean and Standard Deviation for Recorded Biphasic Pulse'])
        set(gca,'fontsize',16)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({['Subject ' num2str(ii)],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
        
    end
end


subj_0a80cf_struct.meanMat = meanMatAll_0a80cf;
subj_0a80cf_struct.stdMat = meanMatAll_0a80cf;
subj_0a80cf_struct.numberStims = meanMatAll_0a80cf;
subj_0a80cf_struct.stdEveryPoint = meanMatAll_0a80cf;


%% now go through the next 5 spacing
dataStruct = struct('pair_21_20',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_20_12',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_22_19',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_23_18',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_28_4',struct('stim_current',[],'time_vec',[],'stim_data',[]));

% vector to loop through
stimChans_20f8a3 = [ 20 12;21 20; 22 19; 23 18; 28 4];
currentMat_20f8a3 = [0.0005 0.0005 0.0005 0.0005 0.0005] ;
pair_vec = {'pair_20_12','pair_21_20','pair_22_19','pair_23_18','pair_28_4'};
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

subj_20f8a3_struct.stimChans = stimChans_20f8a3;
subj_20f8a3_struct.currentMat = currentMat_20f8a3 ;

ii = 1;
meanMatAll_20f8a3 = zeros(110,2,5);
stdMatAll_20f8a3 = zeros(110,2,5);
numberStimsAll_20f8a3 = zeros(5,1);
stdEveryPoint_20f8a3 = {};
chanVec = [1:110];
sid = '20f8a3';

for pair = pair_vec
    
    switch(char(pair))
        case 'pair_20_12'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_20_12.mat')
        case 'pair_21_20'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_21_20.mat')
        case 'pair_22_19'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_22_19.mat')
        case 'pair_23_18'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_23_18.mat')
        case 'pair_28_4'
            load('G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked\stim_widePulse_28_4.mat')
    end
    fprintf(['running for pair ' char(pair) '\n']);
    fs = fs_data;
    stimChans_subj = stimChans_20f8a3(ii,:);
    ECoGData = dataEpoched;
    ECoGData = ECoGData(:,chanVec,:);
    
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_20f8a3(:,:,ii) = meanMat;
    stdMatAll_20f8a3(:,:,ii) = stdMat;
    numberStimsAll_20f8a3(ii) = numberStims;
    stdEveryPoint_20f8a3{ii} = stdCellEveryPoint;
    
    pair_inds = strsplit(char(pair),'_');
    
    %pair_title = strrep(pair,'_','\_');
    
    if plotIt
        chanVec = [1:110];
        figure
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        title(['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure(figTotal)
        subplot(2,3,ii)
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        
        title(['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid '_electrodePair_'  pair_inds{2} '_' pair_inds{3} ]),'png');
        
    end
    
    ii = ii + 1;
    
end
if plotIt
    figure(figTotal)
    
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
    
end

subj_20f8a3_struct.meanMat = meanMatAll_20f8a3;
subj_20f8a3_struct.stdMat = meanMatAll_20f8a3;
subj_20f8a3_struct.numberStims = meanMatAll_20f8a3;
subj_20f8a3_struct.stdEveryPoint = meanMatAll_20f8a3;
%% now go through 2fd831

% vector to loop through
stimChans_2fd831 = [
    122 121;
    121 122
    63 121
    121 63
    55 121
    121 55];

currentMat_2fd831   = [0.0005]';
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

ii = 1;
meanMatAll_2fd831  = zeros(128,2,length(currentMat_2fd831 ));
stdMatAll_2fd831  = zeros(128,2,length(currentMat_2fd831 ));
numberStimsAll_2fd831   = zeros(length(currentMat_2fd831 ),1);
stdEveryPoint_2fd831   = {};
chanVec = [1:128];
sid = '2fd831';
dataDir_2fd831 = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\ECoG_Subjects\2fd831\StimulationSpacingChunked';
filesChoice = [2 3 5 6 8 9];

subj_2fd831_struct.stimChans = stimChans_2fd831;
subj_2fd831_struct.currentMat = currentMat_2fd831 ;

for stimChans = stimChans_2fd831'
    fprintf(['running for a7a181 stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile(dataDir_2fd831,['stim_widePulse_' num2str(stimChans(1)) '_' num2str(stimChans(2))]));
    fs = 12207;
    stimChans_subj = stimChans_2fd831(ii,:);
    ECoGData = dataEpoched;
    ECoGData = ECoGData(:,chanVec,:);
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_2fd831(:,:,ii) = meanMat;
    stdMatAll_2fd831(:,:,ii) = stdMat;
    numberStimsAll_2fd831(ii) = numberStims;
    stdEveryPoint_2fd831{ii} = stdCellEveryPoint;
    
    pair_inds = string(stimChans);
    
    %pair_title = strrep(pair,'_','\_');
    
    if plotIt
        chanVec = [1:128];
        figure
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        title(['Electrode Pair ' pair_inds{1} ' ' pair_inds{2}])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({['Electrode Pair ' pair_inds{1} ' ' pair_inds{2}],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid '_electrodePair_'  pair_inds{1} '_' pair_inds{2} ]),'png');
        
    end
    
    ii = ii + 1;
    
end

subj_2fd831_struct.meanMat = meanMatAll_2fd831;
subj_2fd831_struct.stdMat = meanMatAll_2fd831;
subj_2fd831_struct.numberStims = meanMatAll_2fd831;
subj_2fd831_struct.stdEveryPoint = meanMatAll_2fd831;

%% now go through 3ada8b

% vector to loop through
stimChans_3ada8b = [
    3 4;
    4 3;
    4 12;
    12 4;
    20 4;
    4 20;
    5 7;
    7 5;
    13 12;
    12 13;
    14 11;
    11 14
    15 10;
    10 15
    16 9;
    9 16;
    ];
currentMat_3ada8b = repmat([0.0005],length(stimChans_3ada8b),1) ;
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

ii = 1;
meanMatAll_3ada8b = zeros(92,2,length(currentMat_3ada8b));
stdMatAll_3ada8b = zeros(92,2,length(currentMat_3ada8b));
numberStimsAll_3ada8b = zeros(length(currentMat_3ada8b),1);
stdEveryPoint_3ada8b = {};
chanVec = [1:92];
sid = '3ada8b';

subj_3ada8b_struct.stimChans = stimChans_3ada8b;
subj_3ada8b_struct.currentMat = currentMat_3ada8b ;

for stimChans = stimChans_3ada8b'
    
    fprintf(['running for 3ada8b stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile('G:\My Drive\CDrive-Output-Pistachio\stimSpacing\outputData', ['3ada8b_' num2str(stimChans(1)) '_' num2str(stimChans(2))]));
    
    stimChans_subj = stimChans_3ada8b(ii,:);
    ECoGData = dataEpoched;
    ECoGData = ECoGData(:,chanVec,:);
    fs = fsData;
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_3ada8b(:,:,ii) = meanMat;
    stdMatAll_3ada8b(:,:,ii) = stdMat;
    numberStimsAll_3ada8b(ii) = numberStims;
    stdEveryPoint_3ada8b{ii} = stdCellEveryPoint;
    
    pair_inds = string(stimChans);
    
    %pair_title = strrep(pair,'_','\_');
    
    if plotIt
        chanVec = [1:92];
        figure
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        title(['Electrode Pair ' pair_inds{1} ' ' pair_inds{2}])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure(figTotal)
        subplot(4,4,ii)
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        
        title(['Electrode Pair ' pair_inds{1} ' ' pair_inds{2}])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({['Electrode Pair ' pair_inds{1} ' ' pair_inds{2}],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid '_electrodePair_'  pair_inds{1} '_' pair_inds{2} ]),'png');
        
    end
    ii = ii + 1;
end
if plotIt
    figure(figTotal)
    
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
end

subj_3ada8b_struct.meanMat = meanMatAll_3ada8b;
subj_3ada8b_struct.stdMat = meanMatAll_3ada8b;
subj_3ada8b_struct.numberStims = meanMatAll_3ada8b;
subj_3ada8b_struct.stdEveryPoint = meanMatAll_3ada8b;

%% now go through a7a181 - DIVIDE THIS BY 4 SINCE IT WAS ALREADY ACCOUNTED FOR

% vector to loop through
stimChans_a7a181 = [
    23 24
    ];

currentMat_a7a181  = [0.0015 0.003 0.0075]';
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

ii = 1;
meanMatAll_a7a181 = zeros(112,2,length(currentMat_a7a181 ));
stdMatAll_a7a181 = zeros(112,2,length(currentMat_a7a181 ));
numberStimsAll_a7a181  = zeros(length(currentMat_a7a181 ),1);
stdEveryPoint_a7a181  = {};
chanVec = [1:112];
sid = 'a7a181';

subj_a7a181_struct.stimChans = stimChans_a7a181;
subj_a7a181_struct.currentMat = currentMat_a7a181 ;

for current = currentMat_a7a181'
    stimChans = stimChans_a7a181;
    fprintf(['running for a7a181 stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile(['a7a181_' num2str(stimChans(1)) '_' num2str(stimChans(2))]));
    fs = 12207;
    stimChans_subj = stimChans;
    ECoGData = dataEpoched./4; % FACTOR OF 4 !!!!
    ECoGData = ECoGData(:,chanVec,(labels==1e6*(current./3)));
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    meanMat(stimChans_subj,:) = nan;
    stdMat(stimChans_subj,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_a7a181(:,:,ii) = meanMat;
    stdMatAll_a7a181(:,:,ii) = stdMat;
    numberStimsAll_a7a181(ii) = numberStims;
    stdEveryPoint_a7a181{ii} = stdCellEveryPoint;
    
    
    pair_inds = string(stimChans);
    
    %pair_title = strrep(pair,'_','\_');
    
    if plotIt
        chanVec = [1:112];
        figure
        errorbar(chanVec,abs(meanMat(chanVec,1)),stdMat(chanVec,1),'linewidth',2)
        hold on
        errorbar(chanVec,abs(meanMat(chanVec,2)),stdMat(chanVec,2),'linewidth',2)
        legend('first phase','second phase')
        xlabel('electrode')
        ylabel('Voltage (V)')
        title(['Electrode Pair ' pair_inds{1} ' ' pair_inds{2}])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({['Electrode Pair ' pair_inds{1} ' ' pair_inds{2}],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        set(gca,'YScale','log')
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1}],{'first phase','second phase'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid '_electrodePair_'  pair_inds{1} '_' pair_inds{2} ]),'png');
        
    end
    
    ii = ii + 1;
    
end

subj_a7a181_struct.meanMat = meanMatAll_a7a181;
subj_a7a181_struct.stdMat = meanMatAll_a7a181;
subj_a7a181_struct.numberStims = meanMatAll_a7a181;
subj_a7a181_struct.stdEveryPoint = meanMatAll_a7a181;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DBS BELOW HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% try DBS subject 5e0cf
preSamps = 3;
postSamps = 3;
stimChansVec_DBS_5e0cf = [2 3; 3 2; 3 4; 4 3; 4 5; 5 4; 5 6; 6 5; 6 7; 7 6; 4 6; 6 4]';
currentMat_DBS_5e0cf = repmat([0.00005],length(stimChansVec_DBS_5e0cf),1);
numTrials = size(stimChansVec_DBS_5e0cf,2);

meanMatAll_DBS_5e0cf = zeros(12,2,numTrials);
stdMatAll_DBS_5e0cf = zeros(12,2,numTrials);
numberStimsAll_DBS_5e0cf = zeros(numTrials,1);
stdEveryPoint_DBS_5e0cf = {};
ii = 1;
DBS_SID = DBS_SIDS{1};

subj_DBS_5e0cf_struct.stimChans = stimChans_DBS_5e0cf;
subj_DBS_5e0cf_struct.currentMat = currentMat_DBS_5e0cf ;

for stimChans = stimChansVec_DBS_5e0cf
    
    fprintf(['running for 5e0cf stim chans ' num2str(stimChans(1)) '\n']);
    
    %stimChans = [2 3];
    load(fullfile(DBS_DIR,DBS_SID, ['stimSpacingDBS-5e0cf-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    fs = 48828;
    % take off mean for DBS channels
    tSamps = 1:size(dataEpoched,1);
    stimChans_subj = stimChans;
    
    for chan = 1:12
        %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
        dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(tSamps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';
        
    end
    dataEpoched = dataEpoched/1e6; % the data was stored in uV, convert this to volts
    
    % calculate metrics of interest
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpoched,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    chanVec = [1:size(dataEpoched,2)];
    
    meanMat(stimChans,:) = nan;
    stdMat(stimChans,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_DBS_5e0cf(:,:,ii) = meanMat;
    stdMatAll_DBS_5e0cf(:,:,ii) = stdMat;
    numberStimsAll_DBS_5e0cf(ii) = numberStims;
    stdEveryPoint_DBS_5e0cf{ii} = stdCellEveryPoint;
    ii = ii + 1;
    
    
    if plotIt
        figure
        hold on
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
        hax =axes;
        hold on
        hax.YScale = 'log';
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure('units','normalized','outerposition',[0 0 1 1])
        
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({DBS_SID,['Electrode Pair ' num2str(stimChans(1)) ' ' num2str(stimChans(2))],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            hold on
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        
        set(gca,'YScale','log')
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1} v1 v2 v3],{'first phase','second phase','DBS/ECoG','- chan','+ chan'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' DBS_SID '_electrodePair_'  num2str(stimChans(1)) '_' num2str(stimChans(2)) ]),'png');
        
        
    end
end

subj_DBS_5e0cf_struct.meanMat = meanMatAll_DBS_5e0cf;
subj_DBS_5e0cf_struct.stdMat = meanMatAll_DBS_5e0cf;
subj_DBS_5e0cf_struct.numberStims = meanMatAll_DBS_5e0cf;
subj_DBS_5e0cf_struct.stdEveryPoint = meanMatAll_DBS_5e0cf;


%% try DBS subject b26b7
preSamps = 3;
postSamps = 3;
stimChans_b26b7 = [7 6; 6 7; 7 8; 8 7; 8 6; 6 8; 3 5; 5 3; 7 10; 10 7]';
currentMat_b26b7 = repmat([0.0001],length(stimChans_b26b7),1);

numTrials = size(stimChans_b26b7,2);

meanMatAll_DBS_b26b7 = zeros(16,2,numTrials);
stdMatAll_DBS_b26b7 = zeros(16,2,numTrials);
numberStimsAll_DBS_b26b7 = zeros(numTrials,1);
stdEveryPoint_DBS_b26b7 = {};

ii = 1;
DBS_SID = DBS_SIDS{2};

subj_DBS_b26b7_struct.stimChans = stimChans_DBS_5e0cf;
subj_DBS_b26b7_struct.currentMat = currentMat_DBS_5e0cf ;

for stimChans = stimChans_b26b7
    fprintf(['running for b26b7 stim chans ' num2str(stimChans(1)) '\n']);
    
    load(fullfile(DBS_DIR,DBS_SID, ['stimSpacingDBS-b26b7-stim_' num2str(stimChans(1)) '-' num2str(stimChans(2))]));
    
    % take off mean for DBS channels
    tSamps = 1:size(dataEpoched,1);
    stimChans_subj = stimChans;
    % fs is in these data files
    for chan = 1:16
        %dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(squeeze(mean(dataEpoched(t_samps<55,chan,:))), [1,size(dataEpoched, 1)])';
        dataEpoched(:,chan,:) = squeeze(dataEpoched(:,chan,:))-repmat(mean(squeeze(mean(dataEpoched(tSamps<55,chan,:)))), [size(dataEpoched,3),size(dataEpoched, 1)])';
        
    end
    
    % calculate metrics of interest
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(dataEpoched,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    chanVec = [1:size(dataEpoched,2)];
    
    meanMat(stimChans,:) = nan;
    stdMat(stimChans,:) = nan;
    extractCell{stimChans_subj(1)}{1} = nan;
    extractCell{stimChans_subj(1)}{2}= nan;
    extractCell{stimChans_subj(2)}{1}= nan;
    extractCell{stimChans_subj(2)}{2}= nan;
    stdCellEveryPoint{stimChans_subj(1)} = {nan,nan};
    stdCellEveryPoint{stimChans_subj(2)} =  {nan,nan};
    
    meanMatAll_DBS_b26b7(:,:,ii) = meanMat;
    stdMatAll_DBS_b26b7(:,:,ii) = stdMat;
    numberStimsAll_DBS_b26b7(ii) = numberStims;
    stdEveryPoint_DBS_b26b7{ii} = stdCellEveryPoint;
    
    ii = ii + 1;
    
    if plotIt
        figure
        hold on
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure
        hax =axes;
        hold on
        hax.YScale = 'log';
        errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'o')
        errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'o')
        xlabel('Electrode')
        ylabel('V')
        title([num2str(stimChans(1)) ' _ ' num2str(stimChans(2))])
        vline(9,'k')
        vline(stimChans(1),'g')
        vline(stimChans(2),'b')
        legend('1st phase','2nd phase','DBS/ECoG','- chan','+ chan')
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        figure('units','normalized','outerposition',[0 0 1 1])
        subplot(2,1,1)
        hold on
        plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
        plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
        
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
            scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
        end
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        
        xlabel('electrode')
        ylabel('Voltage (V)')
        % title(['Subject ' num2str(ii)])
        title({DBS_SID,['Electrode Pair ' num2str(stimChans(1)) ' ' num2str(stimChans(2))],'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
        set(gca,'fontsize',16)
        
        subplot(2,1,2)
        hold on
        for chan = chanVec
            dataInt = stdCellEveryPoint{chan};
            dataInt1st = dataInt{1};
            dataInt2nd = dataInt{2};
            h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
            h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
        end
        
        set(gca,'YScale','log')
        v1 =        vline(9,'k');
        v2 = vline(stimChans(1),'g');
        v3 = vline(stimChans(2),'b');
        xlabel('electrode')
        ylabel('standard deviation (V)')
        title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
        legend([h1{1} h2{1} v1 v2 v3],{'first phase','second phase','DBS/ECoG','- chan','+ chan'})
        set(gca,'fontsize',16)
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' DBS_SID '_electrodePair_'  num2str(stimChans(1)) '_' num2str(stimChans(2)) ]),'png');
        
    end
end

subj_DBS_b26b7_struct.meanMat = meanMatAll_DBS_b26b7;
subj_DBS_b26b7_struct.stdMat = meanMatAll_DBS_b26b7;
subj_DBS_b26b7_struct.numberStims = meanMatAll_DBS_b26b7;
subj_DBS_b26b7_struct.stdEveryPoint = meanMatAll_DBS_b26b7;


%%

saveIt = 1;
if saveIt
    
    save('recorded_waveform_data.mat',...
        'first_7_struct','subj_20f8a3_struct','subj_3ada8b_struct','subj_2fd831_struct','subj_3ada8b_struct','subj_a7a181_struct','subj_DBS_5e0cf_struct','subj_DBS_b26b7_struct');
    %     save('meansStds_10_26_2018.mat','meanMatAll_DBS_5e0cf','stdMatAll_DBS_5e0cf','numberStimsAll_DBS_5e0cf',...
    %         'meanMatAll_DBS_b26b7','stdMatAll_DBS_b26b7','numberStimsAll_DBS_b26b7',...
    %         'meanMatAll_2nd5','stdMatAll_2nd5','numberStimsAll_2nd5',...
    %         'meanMatAll_1st7','stdMatAll_1st7','numberStimsAll_1st7',...
    %         'meanMatAll_0a80cf','stdMatAll_0a80cf','numberStimsAll_0a80cf','stdEveryPoint_0a80cf',...
    %         'stdEveryPoint_DBS_b26b7','stdEveryPoint_1st7','stdEveryPoint_2nd5','stdEveryPoint_DBS_b26b7',...
    %         'stimChansVec_20f8a3','stimChansVec_first7','stimChansVec_b26b7','stimChansVec_5e0cf',...
    %         'currentMat_first7','currentMat_20f8a3','currentMat_b26b7','currentMat_5e0cf',...
    %                 'meanMatAll_2fd831','stdMatAll_0a80cf','numberStimsAll_0a80cf','stdEveryPoint_0a80cf')
end