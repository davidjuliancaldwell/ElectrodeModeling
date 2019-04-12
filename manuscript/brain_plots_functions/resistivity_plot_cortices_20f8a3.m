%% script to plot cortices for resistivity modeling
%
% David.J.Caldwell 9/25/2018

clear all;close all;clc
Z_Constants_resistivity_brainPlots

%% parameters
count = 1;

stimChansVec = [ 20 12;21 20; 22 19; 23 18; 28 4];
subjid = '20f8a3';
for stims = stimChansVec'
    load('C:\Users\david\Data\Subjects\20f8a3\trodes.mat')
    trodeLabels = 1:48;
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



