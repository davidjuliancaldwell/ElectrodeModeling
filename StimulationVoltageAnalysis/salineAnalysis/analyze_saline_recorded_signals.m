close all;clear all;clc
Z_Constants_Resistivity
plotIt = 0;

%% go through first seven subjects first
fs = 12207;
preSamps = 3;
postSamps = 3;
figTotal = figure;
plotIt = 1;

% data for further analysis
meanMatAll_1st7 = zeros(64,2,7);
stdMatAll_1st7 = zeros(64,2,7);
numberStimsAll_1st7 = zeros(7,1);
stdEveryPoint_1st7 = {};


