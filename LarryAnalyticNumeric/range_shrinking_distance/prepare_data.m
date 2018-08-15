%% script to prepare the data for the one layer point theory and 3 layer analytic models
%
% David.J.Caldwell 8.13.2018

load('meansStds_3_28_2018.mat')

% define matrices to iterate over
dataTotal_8x8 = squeeze(4.*meanMatAll_1st7(:,1,:));
dataTotal_8x4 = squeeze(4.*meanMatAll_2nd5(1:32,1,:));
% include subject 8
sidVec = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e','m2012','m2804','m2318','m2219','m2120'};

% just first seven
sidVec = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e'};

% stimulation currents in A
currentMat = [0.00175 0.00075 0.0035 0.00075 0.003 0.0025 0.00175 0.0005 0.0005 0.0005 0.0005 0.0005] ;

% GLOBAL FIT
% stimulation channels as a linear index 
stimChansVec = {22 30; 13 14; 11 12; 59 60; 55 56; 54 62; 56 64; 12 20; 4 28; 18 23; 19 22; 21 20};

% LOCAL FIT
%stimChansVec = {1:40; 1:33; 1:32; 40:64; [1,33:64]; 39:64; 25:64};

% stimulation electrode locations, each column is a subject 
jp_vec = [3 2 2 8 7 7 7 3 4 3 3 3];
kp_vec = [6 5 3 3 7 6 8 4 4 7 6 5];
jm_vec = [4 2 2 8 7 8 8 2 1 3 3 3];
km_vec = [6 6 4 4 8 6 8 4 4 2 3 4];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
