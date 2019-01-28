%% script to plot cortices for resistivity modeling
%
% David.J.Caldwell 9/25/2018

%clear all;close all;clc
Z_Constants_resistivity_brainPlots

%% parameters
count = 1;
for sid = SIDS
    subjid = sid{:};
    switch(subjid)
        case '0b5a2e'
            stims = [22 30];
            beta = 31;
            trodeLabels = [1:64];
            
        case '702d24'
            stims = [13 14];
            beta = 5;
            trodeLabels = [1:64];
        case '7dbdec'
            stims = [11 12];
            beta = 4;
            trodeLabels = [1:64];
            trodeLabels = reshape(trodeLabels,8,8);
            trodeLabels = flipud(trodeLabels);
            trodeLabels = trodeLabels(:);
            
        case '9ab7ab'
            stims = [59 60];
            beta = 51;
            
            trodeLabels = [1:64];
            trodeLabels = reshape(trodeLabels,8,8);
            trodeLabels = flipud(fliplr(trodeLabels));
            trodeLabels = trodeLabels(:);
            
            
        case 'c91479'
            stims = [56 55];
            beta = 64;
            trodeLabels = [1:64];
            trodeLabels = reshape(trodeLabels,8,8);
            trodeLabels = fliplr(trodeLabels);
            trodeLabels = trodeLabels(:);
            
        case 'd5cd55'
            stims = [54 62];
            beta = 53;
            trodeLabels = [1:64];
            trodeLabels = reshape(trodeLabels,8,8);
            trodeLabels = flipud(fliplr(trodeLabels));
            trodeLabels = trodeLabels(:);
            
            
        case 'ecb43e'
            stims = [64 56];
            beta = 55;
            trodeLabels = [1:64];
            trodeLabels = reshape(trodeLabels,8,8);
            trodeLabels = flipud(fliplr(trodeLabels));
            trodeLabels = trodeLabels(:);
            
        otherwise
            error('unknown SID entered');
            
    end
    
    %%
    plotBrains_electrodeNums(subjid,stims,trodeLabels)
    title(['Subject ' num2str(count)])
    
    plotObj = gcf;
    objhl = flipud(findobj(plotObj, 'type', 'line')); % objects of legend of type patch
    %leg = legend([objhl(minChanIndex) objhl(maxChanIndex)],{['distribution width = ' num2str(minChanVal)],['distribution width = ' num2str(maxChanVal)]});
    
    count = count+1;
    set(gca,'fontsize',18)
    
    
end

leg = legend([objhl(stims(1)),objhl(stims(2))],...
    {['positive stimulation electrode '],['negative stimulation electrode']});



