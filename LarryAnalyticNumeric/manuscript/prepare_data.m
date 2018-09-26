%% script to prepare the data for the one layer point theory and 3 layer analytic models
%
% David.J.Caldwell 8.13.2018

load('meansStds_8_25_2018.mat')

% define matrices to iterate over
dataTotal_8x8 = squeeze(4.*meanMatAll_1st8(:,1,:));
dataTotal_8x4 = squeeze(4.*meanMatAll_2nd5(1:32,1,:));
% include subject 8
%sidVec = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e','m2012','m2804','m2318','m2219','m2120'};

% just first eight
sidVec = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e','0a80cf'};

% stimulation currents in A
currentMat = [0.00175 0.00075 0.0035 0.00075 0.003 0.0025 0.00175 0.002...
    0.0005 0.0005 0.0005 0.0005 0.0005] ;

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
stimChansVec{7} = [[stimChansVecOnly{7,:}] 1 9 10 35 43];
stimChansVec{8} = [[stimChansVecOnly{8,:}] 49:64];

% LOCAL FIT
%stimChansVec = {1:40; 1:33; 1:32; 40:64; [1,33:64]; 39:64; 25:64};

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

numSubjs = 7;
dataSelect = 4.*squeeze(meanMatAll_1st8(:,1,1:numSubjs));

gridData = nan(15,15,numSubjs);
mid = 8;

% define colors for lines

color1 = [27,201,127]/256;
color2 = [190,174,212]/256;
color3 = [ 253,192,134]/256;

%
% electrode radius
a=0.00115;
% important for 3 layer summation 
R=0.00115;
% assumed uniform thickness of gray matter
d=0.0035;
