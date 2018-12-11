%% script to prepare the data for the one layer point theory

histStruct = struct;
dataInteresStruct = struct;

for totalDataInd = fieldnames(totalData)'
    disp(['Field named: ' totalDataInd{1} ]);
    
    disp(totalData.(totalDataInd{1}));
    subStruct = totalData.(totalDataInd{1});
    
    stimChansVec = subStruct.stimChans;
    currentMat = subStruct.currentMat;
    meanMatAll = subStruct.meanMat;
    numberStimsAll = subStruct.numberStims;
    stdEveryPointAll = subStruct.stdEveryPoint;
    extractCellAll = subStruct.extractCell;
    numTrialsAll = size(subStruct.meanMat,3);
    sidAll = subStruct.sid;
    subjectNumAll = subStruct.subjectNum;
    t = subStruct.t;
    rawDataAll = subStruct.data;
    % badChansAll = subStruct.badChans % if bad chans exist
    
    % loop through trials within structure
    for trial = 1:numTrialsAll
        % setup temporary structure
        indTrial.stimChans = stimChansVec(trial,:);
        indTrial.current = currentMat(trial);
        indTrial.meanMat = meanMatAll(:,:,trial);
        indTrial.stdEveryPoint = stdEveryPointAll{trial};
        indTrial.numberStims = numberStimsAll(trial);
        indTrial.extractCell = extractCellAll{trial};
        indTrial.sid = sidAll{trial};
        indTrial.subjectNum = subjectNumAll(trial);
        indTrial.rawData = rawDataAll{trial};
        % indTrial.badChans = badChansAll{trial};
        %   indTrial.badChans = [65:size(indTrial.meanMat,1)];
        indTrial.badChans = [];
        indTrial.badTotal = [indTrial.stimChans indTrial.badChans];
        % load in electrode coords
        %   load(fullfile(indTrial.sid,'bis_trodes.mat'));
        
        %  basedir = getSubjDir(sid);
        %  load(['bis_trodes.mat']);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % get electrode locations
        
        load(fullfile(folderCoords,['subj_' num2str(indTrial.subjectNum) '_bis_trodes.mat']));
        locs = AllTrodes;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % one layer theory fitlm
        
        vals = compute_1layer_theory_coords(locs,indTrial.stimChans);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 4 point histogram
        
        numChans = size(indTrial.meanMat,1);
        channelSelect = logical(zeros(numChans,1));
        channelSelect(indTrial.badTotal) = 1;
        dataScreened = indTrial.meanMat(:,1);
        dataScreened(channelSelect) = nan;
        
        dataInterestStruct.meanData{trial} = dataScreened; 
        
        [rho1] = four_point_histogram_calculation_coords(indTrial.current,locs,indTrial.badTotal,dataScreened);
        rho1 = rho1(~isnan(rho1) & ~isinf(rho1));
        
        rhoHist.vals = rho1;
        rhoHist.mean = mean(rho1(:));
        rhoHist.std = std(rho1(:));
        rhoHist.median = median(rho1(:));
        
        histStruct.hist{trial} = rhoHist;
        
        bins = [0:0.1:10];
        % plot histogram
        if plotIt
            histogram(rhoHist.vals,bins,'normalization','pdf');
            set(gca,'fontsize',14)
            title(['Subject ' num2str(indTrial.subjectNum)])
            xlim([0 10])
            xlabel(['\rho_{apparent}'])
            ylabel('probability')
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    end
    
end

if plotIt
    figure;
    for index = 1:numTrialsAll
        subplot(2,4,index);histogram(histStruct.hist{index}.vals,bins,'normalization','pdf');
        set(gca,'fontsize',16)
        title(['Subject ' num2str(index)])
        xlim([0 10])
        
    end
    xlabel(['\rho_{apparent}'])
    ylabel('probability')
end

