%% prepare work space
%close all;clear all;clc

%% add everything to path that is necessary
addpath(genpath('/gscratch/gridlab/djcald/SharedCode/ElectrodeModeling'))

%% load in the data and define common constants 
prepare_data


%% run three layer distance model 
three_layer_distance

