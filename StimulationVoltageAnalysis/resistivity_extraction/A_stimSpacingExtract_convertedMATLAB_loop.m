%% updated 3-15-2018 loop through d62e38
%% initialize output and meta dir
% clear workspace
%close all; clear all; clc

% set input output working directories
Z_Constants_Resistivity;

% subject directory, change as needed
SUB_DIR = fullfile(myGetenv('subject_dir'));

%% load in subject

% this is from my z_constants

sid = SIDS{5};

stimChannels = [33 34;
    34 33;
    34 35;
    35 34;
    84 5;
    5 84;
    85 97;
    97 85;
    89 90;
    90 89;
    8 9;
    9 8;
    8 10;
    10 8;
    7 9;
    9 7;
    7 10;
    10 7;
    6 11;
    11 6;
    5 12;
    12 5;
    4 13;
    13 4;
    83 89;
    89 83;
    84 90;
    90 84;
    84 89;
    89 84;
    83 90;
    90 83;
    86 33;
    33 86;
    89 90;
    ];

% ui box for input for stimulation channels
prompt = {'how many channels did we record from? e.g 48 ',...
    'how long before each stimulation do you want to look? in ms e.g. 1',...
    'how long after each stimulation do you want to look? in ms e.g 5',...
    'how many trials?'};
dlg_title = 'StimChans';
num_lines = 1;
defaultans = {'98','1','5','35'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
numChans = str2num(answer{1});
preTime = str2num(answer{2});
postTime = str2num(answer{3});
numTrials = str2num(answer{4});
for trial = 1:numTrials
    switch sid
        case 'd62e38'
            
            fileInt = strcat('stimSpacing-',num2str(trial),'.mat');
            load(fullfile(SUB_DIR,sid,'data\d7\convertedMATLABfiles\stimSpacing',fileInt));
            fs_stim = Stim.info.SamplingRateHz;
            stim = Stim.data;
            fs_data = ECO1.info.SamplingRateHz;
            
            data1= ECO1.data;
            data2= ECO2.data;
            data3= ECO3.data;
            data4= ECO4.data;
            
            fs_sing = Sing.info.SamplingRateHz;
            
            sing = Sing.data;
            data = [data1 data2 data3 data4];
            data = data(:,1:numChans,:);
            
    end
    
    stimChans = stimChannels(trial,:);
    %
    % first and second stimulation channel
    stim_1 = stimChans(1);
    stim_2 = stimChans(2);
    
    %% Sing looks like the wave to be delivered, with amplitude in uA
    
    % build a burst table with the timing of stimuli
    bursts = [];
    
    % first channel of current
    Sing1 = sing(:,1);
    fs_sing = Sing.info.SamplingRateHz;
    
    samplesOfPulse = round(2*fs_stim/1e3);
    
    Sing1Mask = Sing1~=0;
    dmode = diff([0 Sing1Mask' 0 ]);
    
    dmode(end-1) = dmode(end);
    
    bursts(2,:) = find(dmode==1);
    bursts(3,:) = find(dmode==-1);
    
    singEpoched = squeeze(getEpochSignal(Sing1,(bursts(2,:)-1),(bursts(3,:))+1));
    t = (0:size(singEpoched,1)-1)/fs_sing;
    t = t*1e3;
    
    %% Plot stims with info from above, and find the delay!
    
    stim1stChan = stim(:,1);
    stimEpoched = squeeze(getEpochSignal(stim1stChan,(bursts(2,:)-1),(bursts(3,:))+120));
    t = (0:size(stimEpoched,1)-1)/fs_stim;
    t = t*1e3;
    
    % get the delay in stim times - looks to be 7 samples or so
    delay = round(0.2867*fs_stim/1e3);
    
    
    %% extract data
    
    % try and account for delay for the stim times
    stimTimes = bursts(2,:)-1+delay;
    
    % DJC 7-7-2016, changed presamps and postsamps to be user defined
    presamps = round(preTime/1000 * fs_data); % pre time in sec
    postsamps = round(postTime/1000 * fs_data); % post time in sec,
    
    % sampling rate conversion between stim and data
    fac = fs_stim/fs_data;
    
    % find times where stims start in terms of data sampling rate
    sts = round(stimTimes / fac);
    
    % looks like there's an additional 14 sample delay between the stimulation being set to
    % be delivered....and the ECoG recording. which would be 2.3 ms?
    
    delay2 = 14;
    sts = round(stimTimes / fac) + delay2;
    %sts = round(stimTimes / fac);
    
    %% get the data epochs
    dataEpoched = squeeze(getEpochSignal(data,sts-presamps,sts+postsamps+1));
    
    % set the time vector to be set by the pre and post samps
    t = (-presamps:postsamps)*1e3/fs_data;
    
    
    %% plot individual trials for each condition on a different graph
    
    labels = max(singEpoched);
    uniqueLabels = unique(labels);
    
    % intialize counter for plotting
    k = 1;
    
    % make vector of stim channels
    stimChans = [stim_1 stim_2];
    
    % plot each condition separately e.g. 1000 uA, 2000 uA, and so on
    
    for i=uniqueLabels
        dataInterest = dataEpoched(:,:,labels==i);
        
        % get cell of raw values, can use this to analyze later
        dataEpochedCell{k} = dataInterest;
        
        %increment counter
        k = k + 1;
        
    end
    
    %%
    if trial == 35
        save(fullfile(OUTPUT_DIR, [sid '_multipleConds_stim_',num2str(stimChans(1)),'_',num2str(stimChans(2))]),...
            'dataEpoched','dataEpochedCell','fs_data',...
            'stimEpoched','fs_stim','Sing','stim','stimChans','t');
    else
        save(fullfile(OUTPUT_DIR, [sid '_stim_',num2str(stimChans(1)),'_',num2str(stimChans(2))]),...
            'dataEpoched','dataEpochedCell','fs_data',...
            'stimEpoched','fs_stim','Sing','stim','stimChans','t');
    end
end