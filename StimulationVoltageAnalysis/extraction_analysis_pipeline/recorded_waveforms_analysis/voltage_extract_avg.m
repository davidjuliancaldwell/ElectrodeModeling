function [meanMatrix,stdMatrix,stdCellEveryPoint,extractCell,numTrials] = voltage_extract_avg(waveformMatrix,varargin)
% expects time x channels x trials
% average across trials, and find the average stimulation waveform during
% each phase of a stimulus
% this returns a matrix of means channels x 1, and a matrix of standard
% deviations - channels x 1
% the std deviation in time at each point is also calculated by looking at
% the stimulation waveform once the onset and offset are detected

defaultFs = 12207;
defaultPreSamps = 3;
defaultPostSamps = 3;
defaultPlotIt = 1;

p = inputParser;
addRequired(p,'waveformMatrix')
addParameter(p,'fs',defaultFs);
addParameter(p,'preSamps',defaultPreSamps);
addParameter(p,'postSamps',defaultPostSamps);
addParameter(p,'plotIt',defaultPlotIt);

parse(p,waveformMatrix,varargin{:});

fs = p.Results.fs;
preSamps = p.Results.preSamps;
postSamps = p.Results.postSamps;
plotIt = p.Results.plotIt;

tSamps = [1:size(waveformMatrix,1)];
numTrials = size(waveformMatrix,3);
stdCellEveryPoint = {};

% scale by 4 for TDT!!!!!!!!!!!!!!!!!!!!!!!!!
waveformMatrix = 4.*waveformMatrix;

for chan = 1:size(waveformMatrix,2)
    % get average signal of interest to make it easier to detect onset and
    % offset
    signalInt = mean(waveformMatrix(:,chan,:),3);
    
    % take the diff of this signal
    diffSig = [0; squeeze(diff(signalInt))];
    
    % get channel wise signal for later analysis
    channelSig = squeeze(waveformMatrix(:,chan,:));
    
    % find beginning and end of stimulation waveform
    beginInd = find(abs(zscore(diffSig))>1.5,1,'first'); % was 2 before 8.14.2018
    endInd = find(abs(zscore(diffSig))>1.5,1,'last'); % was 2 before 8.14.2018
    
    % make sure signal "begin" isn't too close to the end
    % look after the onset of the pulse reliably should have begun to
    % figure out whether or not it's upward or downward going
    if beginInd+10 >= length(signalInt)
        signBegin = signalInt(beginInd);
    else
        signBegin = signalInt(beginInd+10);
    end
    
    zDiff = zscore(diffSig); % zscore the diff of the sig
    % check if its positive first
    % if so, figure out the transition, point where it goes from positive
    % to negative
    if signBegin>0
        [~,transitionPt] = max(-1* zDiff);
        [~,beginInd] = max( zDiff(tSamps<transitionPt-3));
        [~,endInd] = max( zDiff(tSamps>transitionPt+3));
        endInd = endInd + length(tSamps(tSamps<transitionPt+3));
    else
        [~,transitionPt] = max(zDiff);
        [~,beginInd] = max(-1*zDiff(tSamps<transitionPt-3));
        [~,endInd] = max(-1*zDiff(tSamps>transitionPt+3));
        endInd = endInd + length(tSamps(tSamps<transitionPt+3));
    end
    
    if plotIt && ~isempty(beginInd)
        figure
        ax = axes;
        plot(1e3*tSamps/fs,signalInt,'linewidth',3)
        ylim([-3e-2 3e-2])
        beg = vline(1e3*beginInd/fs,'g');
        trans = vline(1e3*transitionPt/fs,'k');
        en = vline(1e3*endInd/fs,'r');
        high1 = highlight(ax,[1e3*(beginInd+preSamps)/fs,1e3*(transitionPt-postSamps)/fs],[],[180 180 180]/256);
        high2 = highlight(ax,[1e3*(transitionPt+preSamps)/fs,1e3*(endInd-postSamps)/fs],[],[180 180 180]/256);
        legend('signal','beginning','transition','end','extracted period')
        xlabel('time (ms)');
        ylabel(['Voltage (V)']);
        title(['Signal Extraction - channel ' num2str(chan)]);
        set(gca,'fontsize',14);
    end
    
    firstPhase = signalInt(beginInd+preSamps:transitionPt-postSamps);
    secondPhase = signalInt(transitionPt+preSamps:endInd-postSamps);
    extractCell{chan}{1} = firstPhase;
    extractCell{chan}{2} = secondPhase;
    
    meanMatrix(chan,1) = mean(firstPhase);
    meanMatrix(chan,2) = mean(secondPhase);
    stdMatrix(chan,1) = std(firstPhase);
    stdMatrix(chan,2) = std(secondPhase);
    
    % now get the standard deviation at every point in the recorded
    % waveform
    stdCellEveryPoint{chan}{1} = std(channelSig(beginInd+preSamps:transitionPt-postSamps,:),[],2);
    stdCellEveryPoint{chan}{2} = std(channelSig(transitionPt+preSamps:endInd-postSamps,:),[],2);
    
    
end

