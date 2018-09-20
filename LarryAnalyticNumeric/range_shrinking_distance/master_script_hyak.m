%% prepare work space
%close all;clear all;clc

%% add everything to path that is necessary
addpath(genpath('/gscratch/gridlab/djcald/SharedCode/ElectrodeModeling'))

%% load in the data and define common constants 
prepare_data

%% find 1 layer offsets to then feed into three layer model 
one_layer_distance_fitlm_findOffset

%% run three layer distance model 
three_layer_distance_offset

