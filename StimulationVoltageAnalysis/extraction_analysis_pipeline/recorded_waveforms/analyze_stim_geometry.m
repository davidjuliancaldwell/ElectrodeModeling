% script to analyze EP screen from paired pulse DBS experiments
close all;clear all;clc
Z_Constants_Resistivity;
%% load in subject

SIDS = {'71c6c'};
matlab_dir = 'MATLAB_Converted';
experiment = 'stimGeometry';

for sid = SIDS
    OUTPUT_DIR = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\Plots\dataPlots';
    
    sid = sid{:};
    
    switch sid
        case '71c6c'
            blocks = [1 2 3 4 5 6 7 8 9];
            stimChansVec = [4 3; 5 3; 6 3; 7 3; 7 2; 8 1; 6 4; 7 4; 8 4];
            numChansVec = repmat(8,length(blocks),1);
            badChansVec = repmat({[]},length(blocks),1);
            badTrialsVec = repmat({[]},length(blocks),1);
            counterIndex = 1;
    end
    
    for block = blocks
        load(fullfile(SUB_DIR,sid,matlab_dir,experiment,['stimGeometry-' num2str(block) '.mat'])); % most promising one
        
        stimChans = stimChansVec(counterIndex,:);
        fprintf(['running for subject ' sid ' stim chans ' num2str(stimChans(1)) ' ' num2str(stimChans(2)) '\n']);
        badChans = badChansVec{counterIndex};
        badTrials = badTrialsVec{counterIndex};
        numChans = numChansVec(counterIndex);
        %%
        meanSubtract = 1;
        preTime = 1 ;
        postTime = 5;
        fsData = ECO1.info.SamplingRateHz;
        data1= ECO1.data;
        data2= ECO2.data;
        data3= ECO3.data;
        
        fsSing = Sing.info.SamplingRateHz;
        
        sing = Sing.data;
        data = [data1 data2 data3];
        data = data(:,1:numChans,:);        stimBox = Stim.data;
        fsStim = Stim.info.SamplingRateHz;
        stimProgrammed = Sing.data;
        presamps = round(preTime/1000 * fsData); % pre time in sec
        postsamps = round(postTime/1000 * fsData); % post time in sec,
        badChansTotal = [stimChans badChans];
        
        %%
        plotIt = 1;
        savePlot = 1;
        EPscreen = 0; % account for parallel stim channels
        saveName = [sid '_stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_' 'stimMonitor'];
        
        [stim1Epoched,t,fsStim,stimLevelLabels,pulseWidthLabels,uniqueLabels,uniquePulseWidths,uniquePulseWidthLabels,singEpoched] = voltage_monitor_different_width(Stim,Sing,...
            plotIt,savePlot,'',OUTPUT_DIR,saveName,EPscreen);
        
        goodTrialsVec = logical(ones(size(stim1Epoched,2),1));
        goodTrialsVec(badTrials) = 0;
        stimLevelLabels = stimLevelLabels(goodTrialsVec);
        pulseWidthLabels = pulseWidthLabels(goodTrialsVec);
        singEpoched = singEpoched(goodTrialsVec);
        stim1Epoched = stim1Epoched(goodTrialsVec);
        %% find out which each of the programmed stimuli actually were set to be delivered
        [sts,bursts] = get_epoch_indices(Sing.data,fsData,fsStim);
        
        %% get the data epochs
        
        scaling = 'n';
        dataEpoched = squeeze(getEpochSignal(data,sts-presamps,sts+postsamps+1));
        dataEpoched = dataEpoched(:,:,goodTrialsVec);
        
        
        % set the time vector to be set by the pre and post samps
        t = (-presamps:postsamps)*1e3/fsData;
        
        if meanSubtract
            dataEpoched = dataEpoched - repmat(mean(dataEpoched(t<0,:,:),1), [size(dataEpoched, 1), 1]);
        end
        
        
        % get rid of bad channels
        chansVec_goods = ones(numChans,1);
        chansVec_goods(badChansTotal) = 0;
       % dataEpoched(:,~chansVec_goods,:) = nan;
        
        % intialize counter for plotting
        k = 1;
        
        % make vector of stim channels
        % determine number of subplot
        subPlots = numSubplots(numChans);
        p = subPlots(1);
        q = subPlots(2);
        
        % plot each condition separately e.g. 1000 uA, 2000 uA, and so on
        
        for ii=uniquePulseWidthLabels
            figure('units','normalized','outerposition',[0 0 1 1]);
            dataInterest = dataEpoched(:,:,stimLevelLabels==ii(1) & pulseWidthLabels ==ii(2));
            for j = 1:numChans
                subplot(p,q,j);
                plot(t,4.*squeeze(dataInterest(:,j,:)));
                xlim([min(t) max(t)]);
                
                % change y axis scaling if necessary
                if strcmp(scaling,'y')
                    ylim([minVal maxVal]);
                end
                
                % put a box around the stimulation channels of interest if need be
                if ismember(j,stimChans)
                    ax = gca;
                    ax.Box = 'on';
                    ax.XColor = 'red';
                    ax.YColor = 'red';
                    ax.LineWidth = 2;
                    title(num2str(j),'color','red');
                    
                else
                    title(num2str(j));
                end
                vline(0);
            end
            
            % label axis
            xlabel('time in ms');
            ylabel('voltage in \muV');
            %subtitle(['Individual traces - Current set to ',num2str(uniqueLabels(k)),' \muA']);
            % subtitle(['Individual traces - Voltage set to ',num2str(uniqueLabels(k)),' V']);
            
            % get cell of raw values, can use this to analyze later
            dataEpochedCell{k} = dataInterest;
            
            % get averages to plot against each for later
            % cell function, can use this to analyze later
            dataAvgs{k} = mean(dataInterest,3);
            %increment counter
            k = k + 1;
            
            subtitle(['Current = ' num2str(round(ii(1))) '\muA, pulse width = ' num2str(ii(2)) '\mus'])
            
            if savePlot
                SaveFig(OUTPUT_DIR,[sid '_stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_stimCurr_' num2str(round(ii(1))) '_PW_' num2str(ii(2)) '_individualRecordings']);
            end
            
        end
        
        %% plot averages
        
        k = 1;
        figure('units','normalized','outerposition',[0 0 1 1]);
        for k = 1:length(dataAvgs)
            
            tempData = 4.*dataAvgs{k};
            
            for j = 1:numChans
                s = subplot(p,q,j);
                plot(t,squeeze(tempData(:,j)),'linewidth',2);
                hold on;
                xlim([min(t) max(t)]);
                
                % change y axis scaling if necessary
                if strcmp(scaling,'y')
                    ylim([minVal maxVal]);
                end
                
                if ismember(j,stimChans)
                    ax = gca;
                    ax.Box = 'on';
                    ax.XColor = 'red';
                    ax.YColor = 'red';
                    ax.LineWidth = 2;
                    title(num2str(j),'color','red')
                    
                else
                    title(num2str(j));
                end
                vline(0);
                
            end
            gcf;
        end
        xlabel('time in ms');
        ylabel('voltage in \muV');
        %subtitle(['Averages for all conditions']);
        legLabels = {[num2str(round(uniqueLabels(1)))]};
        
        k = 2;
        if length(uniqueLabels>1)
            for ii = uniqueLabels(2:end)
                legLabels{end+1} = [num2str(round(uniqueLabels(k)))];
                k = k+1;
            end
        end
        legend(s,legLabels);
        
        if savePlot
            SaveFig(OUTPUT_DIR,[sid '_stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_' 'averageRecordings']);
        end
        
        counterIndex = counterIndex + 1;
        
        %% save the data 
        saveData = 0;
        if saveData
            OUTPUT_DIR = pwd;
            fs = fsData;
            save(sprintf(['stimSpacing-DBS-%s-stim_%d-%d'], sid, stimChans(1),stimChans(2)),...
                'dataEpoched','dataEpochedCell','stimChans','t','fsStim','fsData','singEpoched',...
                'stim1Epoched','fsData','fsStim','uniquePulseWidthLabels','stimLevelLabels','pulseWidthLabels');
        end
        
        clearvars -except sid block blocks matlab_dir DBS_DIR DBS_SID META_DIR plotIt savePlot SUB_DIR experiment SIDS OUTPUT_DIR counterIndex stimChansVec numChansVec badChansVec badTrialsVec
        
    end
end