%% prepare work space
close all;clear all;clc

%% load in the data and define common constants 
prepare_data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% below this is distance dependent fitting
%% one layer apparent resistivity distance 

one_layer_distance

%% one layer apparent resistivity distance fitlm 

one_layer_distance_fitlm

%% three layer distance fitlm

three_layer_distance

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% below this is range shrinking
%% one layer apparent resistivity range shrinking
one_layer_range_shrinking

%% one layer apparent resistivity fitlm range shrinking 
one_layer_range_shrinking_fitlm

%% one layer exactly like Larry

one_layer_range_shrinking_fitlm_larry

%% one layer like Larry, but with limits on data rather than thy 

one_layer_range_shrinking_fitlm_larry_data

%% 3 layer constant voltage circular electrodes range shrinking
three_layer_range_shrinking 
% 
% %% plot range shrinking
% 
% %% one layer apparent resistivity distance shrinking
% one_layer_distance_shrinking
% 
% %% 3 layer constant voltage circular electrodes distance shrinking
% 
% %% plot distance shrinking 