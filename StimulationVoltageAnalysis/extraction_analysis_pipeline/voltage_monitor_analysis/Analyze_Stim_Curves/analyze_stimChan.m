%% 2-10-2018 - script to look at the stimulation monitor output
close all;clear all;clc

load('5e0cf_stimChans.mat')
%%
fs = 48828;

stimChan_calculate(stim1Epoched,fs)
