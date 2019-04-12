%% script to plot cortices for resistivity modeling
%
% David.J.Caldwell 9/25/2018

clear all;close all;clc
Z_Constants_resistivity_brainPlots

%% parameters
count = 1;

stimChansVec = [ 29 28; 30 27; 31 26; 32 25; 36 28; 44 20; 52 12; 60 4];
subjid = '3f2113';
for stims = stimChansVec'
    load('C:\Users\david\Data\Subjects\3f2113\trodes.mat')
    trodeLabels = 1:64;
    %%
    plotBrains_electrodeNums(subjid,stims,trodeLabels)
    %title(['Subject ' num2str(count)])
    
    plotObj = gcf;
    objhl = flipud(findobj(plotObj, 'type', 'line')); % objects of legend of type patch
    %leg = legend([objhl(minChanIndex) objhl(maxChanIndex)],{['distribution width = ' num2str(minChanVal)],['distribution width = ' num2str(maxChanVal)]});
    
    count = count+1;
    set(gca,'fontsize',18)
    
    
end

leg = legend([objhl(stims(1)),objhl(stims(2))],...
    {['positive stimulation electrode '],['negative stimulation electrode']});



