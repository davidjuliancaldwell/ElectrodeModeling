% GLOBAL FIT including "bad Channels
% stimulation channels as a linear index
stimChansVecOnly = {22 30; 13 14; 11 12; 59 60; 56 55; 54 62; 64 56};

stimChansVecTotal = {};
stimChansVecTotal{1} = [[stimChansVecOnly{1,:}] 17 18 19];
stimChansVecTotal{2} = [[stimChansVecOnly{2,:}] 23 27 28 29 30 32 44 52 60];
stimChansVecTotal{3} = [[stimChansVecOnly{3,:}] 57];
stimChansVecTotal{4} = [[stimChansVecOnly{4,:}] 2 3 31 57];
stimChansVecTotal{5} = [[stimChansVecOnly{5,:}] 1 49 58 59];
stimChansVecTotal{6} = [[stimChansVecOnly{6,:}] 57:64];
stimChansVecTotal{7} = [[stimChansVecOnly{7,:}] 1 9 10 35 43];

subStruct.stimChansVecTotal = stimChansVecTotal;

dataSelect = cell2mat(dataInterestStruct.meanData);
gridData = nan(15,15,numIndices);
mid = 8;

% define colors for lines

color1 = [27,201,127]/256;
color2 = [190,174,212]/256;
color3 = [ 253,192,134]/256;
