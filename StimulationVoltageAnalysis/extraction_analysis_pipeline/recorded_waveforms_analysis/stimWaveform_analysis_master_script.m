%% setup workspace
close all;clear all;clc
Z_Constants_Resistivity
addpath(SUBJECT_DIR)

%% global parameters
preSamps = 3; % for voltage extaction algorithm
postSamps = 3; % for voltage extraction algorithm 
plotIt = 1; % plot and save plots

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ECoG BELOW HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subj_first_7_waveform

%%
subj_0a80cf_waveform

%%
subj_20f8a3_waveform

%%
subj_2fd831_waveform

%%
subj_3ada8b_waveform

%%
subj_a7a181_waveform

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DBS BELOW HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
subj_5e0cf_DBS_waveform

%%
subj_b26b7_DBS_waveform

%%
subj_3972f_DBS_waveform

%%
subj_46c2a_DBS_waveform

%%
subj_9f852_DBS_waveform

%%
subj_71c6c_DBS_waveform

%%
subj_8e907_DBS_waveform


%% save the data 

saveIt = 1;
if saveIt
    
    save('recorded_waveform_data.mat',...
        'first_7_struct','subj_20f8a3_struct','subj_3ada8b_struct','subj_2fd831_struct','subj_3ada8b_struct','subj_a7a181_struct','subj_DBS_5e0cf_struct','subj_DBS_b26b7_struct');
    %     save('meansStds_10_26_2018.mat','meanMatAll_DBS_5e0cf','stdMatAll_DBS_5e0cf','numberStimsAll_DBS_5e0cf',...
    %         'meanMatAll_DBS_b26b7','stdMatAll_DBS_b26b7','numberStimsAll_DBS_b26b7',...
    %         'meanMatAll_2nd5','stdMatAll_2nd5','numberStimsAll_2nd5',...
    %         'meanMatAll_1st7','stdMatAll_1st7','numberStimsAll_1st7',...
    %         'meanMatAll_0a80cf','stdMatAll_0a80cf','numberStimsAll_0a80cf','stdEveryPoint_0a80cf',...
    %         'stdEveryPoint_DBS_b26b7','stdEveryPoint_1st7','stdEveryPoint_2nd5','stdEveryPoint_DBS_b26b7',...
    %         'stimChansVec_20f8a3','stimChansVec_first7','stimChansVec_b26b7','stimChansVec_5e0cf',...
    %         'currentMat_first7','currentMat_20f8a3','currentMat_b26b7','currentMat_5e0cf',...
    %                 'meanMatAll_2fd831','stdMatAll_0a80cf','numberStimsAll_0a80cf','stdEveryPoint_0a80cf')
end