% GLOBAL FIT including "bad Channels
% stimulation channels as a linear index
stimChansVecOnly = {22 30; 13 14; 11 12; 59 60; 56 55; 54 62; 64 56; 28 27;...
    12 20; 4 28; 18 23; 19 22; 21 20};

stimChansVec = {};
stimChansVec{1} = [[stimChansVecOnly{1,:}] 17 18 19];
stimChansVec{2} = [[stimChansVecOnly{2,:}] 23 27 28 29 30 32 44 52 60];
stimChansVec{3} = [[stimChansVecOnly{3,:}] 57];
stimChansVec{4} = [[stimChansVecOnly{4,:}] 2 3 31 57];
stimChansVec{5} = [[stimChansVecOnly{5,:}] 1 49 58 59];
stimChansVec{6} = [[stimChansVecOnly{6,:}] 57:64];
stimChansVec{9} = [[stimChansVecOnly{7,:}] 1 9 10 35 43];
stimChansVec{8} = [[stimChansVecOnly{8,:}] 49:64];

dataSelect = cell2mat(dataInterestStruct.meanData);

gridData = nan(15,15,numTrialsAll);
mid = 8;

% define colors for lines

color1 = [27,201,127]/256;
color2 = [190,174,212]/256;
color3 = [ 253,192,134]/256;
