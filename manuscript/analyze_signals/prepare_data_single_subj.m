%% script to prepare the data for the one layer point theory

totalDataInd = fieldnames(totalData)';
disp(['Field named: ' totalDataInd{1} ]);

disp(totalData.(totalDataInd{1}));
subStruct = totalData.(totalDataInd{1});

stimChansVec = subStruct.stimChans;
currentMat = subStruct.currentMat;
meanMatAll = subStruct.meanMat;
numberStimsAll = subStruct.numberStims;
stdEveryPointAll = subStruct.stdEveryPoint;
extractCellAll = subStruct.extractCell;
numIndices = size(subStruct.meanMat,3);
sidAll = subStruct.sid;
subjectNumAll = subStruct.subjectNum;
t = subStruct.t;
rawDataAll = subStruct.data;
% badChansAll = subStruct.badChans % if bad chans exist

% loop through trials within structure
for index = 1:numIndices
    % setup temporary structure
    indTrial.stimChans = stimChansVec(index,:);
    indTrial.current = currentMat(index);
    indTrial.meanMat = meanMatAll(:,:,index);
    indTrial.stdEveryPoint = stdEveryPointAll{index};
    indTrial.numberStims = numberStimsAll(index);
    indTrial.extractCell = extractCellAll{index};
    indTrial.sid = sidAll{index};
    indTrial.subjectNum = subjectNumAll(index);
    indTrial.rawData = rawDataAll{index};
    % indTrial.badChans = badChansAll{trial};
    
    indTrial.badChans = [];
    indTrial.badTotal = [indTrial.stimChans indTrial.badChans];
    
    dataInterestStruct.meanData{index} = indTrial.meanMat(:,1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get electrode locations
    
    load(fullfile(folderCoords,['subj_' num2str(indTrial.subjectNum) '_bis_trodes.mat']));
    dataInterestStruct.locs{index} = AllTrodes;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % one layer theory fitlm
    
    dataInterestStruct.oneLayerVals{index} = compute_1layer_theory_coords(dataInterestStruct.locs{index},indTrial.stimChans);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



