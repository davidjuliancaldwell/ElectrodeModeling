%% Extract neural data for screening CCEPs.
% modified from the Kurt script 1-10-2016 by DJC
% modified 4-20-2016 by David to help Larry and Stephen

%% Constants
close all;clear all;clc
Z_Constants_Resistivity;

SUB_DIR = fullfile(myGetenv('subject_dir'));
OUTPUT_DIR = 'C:\Users\david\SharedCode\ElectrodeModeling\manuscript\data';
META_DIR = 'C:\Users\david\Data\Output\BetaTriggeredStim\meta';

%9ab7ab
% sid = SIDS{i};
for ii = 1:7
    sid = SIDS{ii};
    switch(sid)
        
        case '8adc5c'
            % sid = SIDS{1};
            tp = strcat(SUB_DIR,'\8adc5c\data\D6\8adc5c_BetaTriggeredStim');
            block = 'Block-67';
            stims = [31 32];
            chans = [1:64];
            
        case 'd5cd55'
            % sid = SIDS{2};
            % sid = SIDS{2};
            tp = strcat(SUB_DIR,'\d5cd55\data\D8\d5cd55_BetaTriggeredStim');
            block = 'Block-49';
            stims = [54 62];
            %         chans = [53 61 63];
            chans = [1:64];
            
        case 'c91479'
            % sid = SIDS{3};
            tp = strcat(SUB_DIR,'\c91479\data\d7\c91479_BetaTriggeredStim');
            block = 'BetaPhase-14';
            stims = [55 56];
            stimChans = [55 56];
            %         chans = [64 63 48];
            chans = [1:64];
            
        case '7dbdec'
            % sid = SIDS{4};
            tp = strcat(SUB_DIR,'\7dbdec\data\d7\7dbdec_BetaTriggeredStim');
            block = 'BetaPhase-17';
            stims = [11 12];
            stimChans = [11 12];
            %         chans = [4 5 14];
            chans = [1:64];
            
        case '9ab7ab'
            %             sid = SIDS{5};
            %             sid = SIDS{5};
            tp = strcat(SUB_DIR,'\9ab7ab\data\d7\9ab7ab_BetaTriggeredStim');
            block = 'BetaPhase-3';
            stims = [59 60];
            stimChans = [59 60];
            %         chans = [51 52 53 58 57];
            chans = [1:64];
            
            % chans = 29;
        case '702d24'
            tp = strcat(SUB_DIR,'\702d24\data\d7\702d24_BetaStim');
            block = 'BetaPhase-4';
            stims = [13 14];
            stimChans = [13 14];
            %         chans = [4 5 21];
            chans = [1:64];
            %             chans = [36:64];
            
        case 'ecb43e'
            tp = strcat(SUB_DIR,'\ecb43e\data\d7\BetaStim');
            block = 'BetaPhase-3';
            stims = [56 64];
            stimChans = [56 64];
            chans = [1:64];
            %         chans = [47 55]; want to look at all channels
        case '0b5a2e' % added DJC 7-23-2015
            tp = strcat(SUB_DIR,'\0b5a2e\data\d8\0b5a2e_BetaStim\0b5a2e_BetaStim');
            block = 'BetaPhase-2';
            stims = [22 30];
            stimChans = [22 30];
            chans = [1:64];
        case '0b5a2ePlayback' % added DJC 7-23-2015
            tp = strcat(SUB_DIR,'\0b5a2e\data\d8\0b5a2e_BetaStim\0b5a2e_BetaStim');
            block = 'BetaPhase-4';
            stims = [22 30];
            stimChans = [22 30];
            chans = [1:64];
            
        case '0a80cf' % added DJC 5-24-2016
            tp = strcat(SUB_DIR,'\0a80cf\data\d10\0a80cf_BetaStim\0a80cf_BetaStim');
            block = 'BetaPhase-4';
            stims = [27 28];
            stimChans = [27 28];
            chans = [1:64];
            
        case '3f2113' % added DJC 5-24-2016
            tp = strcat(SUB_DIR,'\3f2113\data\data\d6\BetaStim\BetaStim');
            block = 'BetaPhase-5';
            stims = [32 31];
            stimChans = [32 31];
            chans = [1:64];
            
    end
    %% load in the trigger data
    
    if strcmp(sid,'0b5a2ePlayback')
        load(fullfile(META_DIR, ['0b5a2e' '_tables_modDJC.mat']), 'bursts', 'fs', 'stims');
        delay = 577869;
    elseif strcmp(sid,'0b5a2e')
        load(fullfile(META_DIR, [sid '_tables_modDJC.mat']), 'bursts', 'fs', 'stims');
    else
        load(fullfile(META_DIR, [sid '_tables.mat']), 'bursts', 'fs', 'stims');
        
    end
    
    % start with all of the data !
    
    % drop any stims that happen in the first 500 milliseconds
    %  stims(:,stims(2,:) < fs/2) = [];
    
    % drop any probe stimuli without a corresponding pre-burst/post-burst
    % still want to do this for selecting conditioning - DJC, as this in the
    % next step ensures we only select conditioning up to last one before beta
    % stim train    bads = stims(3,:) == 0 & (isnan(stims(4,:)) | isnan(stims(6,:)));
    %  bads = stims(3,:) == 0 & (isnan(stims(4,:)) | isnan(stims(6,:)));
    
    %   stims(:, bads) = [];
    
    
    % adjust stim and burst tables for 0b5a2e playback case
    
    if strcmp(sid,'0b5a2ePlayback')
        
        stims(2,:) = stims(2,:)+delay;
        bursts(2,:) = bursts(2,:) + delay;
        bursts(3,:) = bursts(3,:) + delay;
        
    end
    
    tank = TTank;
    tank.openTank(tp);
    tank.selectBlock(block);
    
    %% Process Triggers 9-3-2015
    efs = 12207;
    if (strcmp(sid, '8adc5c'))
        pts = stims(3,:)==0 | stims(3,:) == 1;
    elseif (strcmp(sid, 'd5cd55'))
        %         pts = stims(3,:)==0 & (stims(2,:) > 4.5e6);
        pts = (stims(3,:)==0 | stims(3,:) == 1 )& (stims(2,:) > 4.5e6) & (stims(2, :) > 36536266);
    elseif (strcmp(sid, 'c91479'))
        pts = stims(3,:) | stims(3,:) == 1;
    elseif (strcmp(sid, '7dbdec'))
        pts = stims(3,:)==0 | stims(3,:) == 1;
    elseif (strcmp(sid, '9ab7ab'))
        pts = stims(3,:)==0 | stims(3,:) == 1;
    elseif (strcmp(sid, '702d24'))
        pts = stims(3,:)==0 | stims(3,:) == 1;
        %modified DJC 7-27-2015
    elseif (strcmp(sid, 'ecb43e'))
        pts = stims(3,:) == 0 | stims(3,:) == 1;
    elseif (strcmp(sid, '0b5a2e'))
        pts = stims(3,:) == 0 | stims(3,:) == 1;
    elseif (strcmp(sid, '0b5a2ePlayback'))
        pts = stims(3,:) == 0 | stims(3,:) == 1;
    elseif (strcmp(sid,'3f2113'))
        pts = stims(3,:) == 0 | stims(3,:) == 1;
    else
        error 'unknown sid';
    end
    efs = 1.220703125000000e+04;
    % change presamps and post samps to be what Kurt wanted to look at
    presamps = round(0.05 * efs); % pre time in sec
    postsamps = round(0.15 * efs); % post time in sec
    
    t = (-presamps:postsamps)/efs;
    fac = 2;
    ptis = round(stims(2,pts)/fac);
    
    %% process each ecog channel individually
    
    ECoGData = zeros(length(t),length(ptis),64);
    
    for chan = chans
        %% load in ecog data for that channel
        fprintf('loading in %s ecog data:\n',sid);
        tic;
        
        grp = floor((chan-1)/16);
        ev = sprintf('ECO%d', grp+1);
        achan = chan - grp*16;
        fprintf('channel %d \n',chan)
        %         [eco, efs] = tdt_loadStream(tp, block, ev, achan);
        [eco, info] = tank.readWaveEvent(ev, achan);
        %   efs = info.SamplingRateHz;
        eco = eco';
        
        toc;
        
        wins = squeeze(getEpochSignal(eco', ptis-presamps, ptis+postsamps+1));
        
        %   clear awins
        % added DJC 3/9/2016 to save individual responses, want signals x
        ECoGData(:,:,chan) = wins-repmat(mean(wins(t<0-0.005 & t>-0.1,:),1), [size(wins, 1), 1]);
    end
    
    ECoGDataAverage = squeeze(mean(ECoGData,2));
    
    save(fullfile(OUTPUT_DIR, [sid '_StimulationAndCCEPs.mat']), 't','ECoGData','ECoGDataAverage','-v7.3');
    
    clearvars ECoGData ECoGDataAverage t
    
end


