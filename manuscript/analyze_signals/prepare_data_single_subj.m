%% script to prepare the data for the one layer point theory

function [subStruct] = prepare_data_single_subj(eliminateBadChannels)

cd(fileparts(which('prepare_data_single_subj')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','data');
folderCoords = fullfile(locationsDir,'..','coordinates');

totalData = load(fullfile(folderData,'recorded_voltages.mat'));

subStruct = struct;
totalDataInd = fieldnames(totalData)';
disp(['Field named: ' totalDataInd{1} ]);

disp(totalData.(totalDataInd{1}));
subStruct = totalData.(totalDataInd{1});

numIndices = size(subStruct.meanMat,3);

% define fs
diffT = diff(subStruct.t)/1e3;
subStruct.fs =  1/diffT(1);

% stimulation electrode locations, each column is a subject
jp_vec = [3 2 2 8 7 7 8 4 ...
    3 4 3 3 3];
kp_vec = [6 5 3 3 8 6 8 3 ...
    4 4 7 6 5];
jm_vec = [4 2 2 8 7 8 7 4 ...
    2 1 3 3 3];
km_vec = [6 6 4 4 7 6 8 4 ...
    4 4 2 3 4];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stimChansIndices = [jp_vec; kp_vec; jm_vec; km_vec];

stimChansVecOnly = {22 30; 13 14; 11 12; 59 60; 56 55; 54 62; 64 56};

badTotal = {};
if eliminateBadChannels
    badTotal{1} = [[stimChansVecOnly{1,:}] 17 18 19];
    badTotal{2} = [[stimChansVecOnly{2,:}] 23 27 28 29 30 32 44 52 60];
    badTotal{3} = [[stimChansVecOnly{3,:}] 57];
    badTotal{4} = [[stimChansVecOnly{4,:}] 2 3 31 57];
    badTotal{5} = [[stimChansVecOnly{5,:}] 1 49 58 59];
    badTotal{6} = [[stimChansVecOnly{6,:}] 57:64];
    badTotal{7} = [[stimChansVecOnly{7,:}] 1 9 10 35 43];
else
    badTotal{1} = [[stimChansVecOnly{1,:}]];
    badTotal{2} = [[stimChansVecOnly{2,:}]];
    badTotal{3} = [[stimChansVecOnly{3,:}]];
    badTotal{4} = [[stimChansVecOnly{4,:}]];
    badTotal{5} = [[stimChansVecOnly{5,:}]];
    badTotal{6} = [[stimChansVecOnly{6,:}]];
    badTotal{7} = [[stimChansVecOnly{7,:}]];
end

subStruct.badTotal = badTotal;


subStruct.stimChansIndices = stimChansIndices;

% loop through trials within structure
for index = 1:numIndices
    
    %subStruct.badChans = [];
    %subStruct.badTotal{index} = [subStruct.stimChans(index,:) subStruct.badChans];
    
    subStruct.meanData{index} = subStruct.meanMat(:,1,index);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get electrode locations
    
    load(fullfile(folderCoords,['subj_' num2str(subStruct.subjectNum(index)) '_bis_trodes.mat']));
    subStruct.locs{index} = AllTrodes;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % one layer theory fitlm
    
    %  subStruct.oneLayerVals{index} = compute_1layer_theory_coords(subStruct.locs{index},subStruct.stimChans(index,:));
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subStruct.dataSelect = cell2mat(subStruct.meanData);
subStruct.gridData = nan(15,15,numIndices);

end

