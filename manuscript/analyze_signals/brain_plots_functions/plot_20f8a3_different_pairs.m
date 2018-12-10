%% script to plot all of the 20f8a3 pairs on one cortex 
% need to finish this 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David.J.Caldwell 12.9.2018 

clear all;close all;clc
Z_Constants_resistivity_brainPlots

project = 1;
plotLabels = 1;
%% parameters
figure
PlotCortex('MNI')
hold on

stimChansVec = [ 20 12;21 20; 22 19; 23 18; 28 4];

count = 1;
for stimChans = stimChansVec'
 
load('C:\Users\david\Data\Subjects\20f8a3\bis_trodes.mat')
    % project all to same hemisphere
    stims = stimChans;
    weights = [1 -1];
    map = [.2 1 0; 1 1 1; 1 0 1];
    map = [0.5 0.5 1; 1 1 1; 1 0.5 0.5];
    locs = AllTrodes(stims,:);
    clims = [-1 1]; % we want the color limits to be the same for all sets of dots
    
    % project all onto the same side
    if project
        locs = projectToHemisphere(locs, 'l');
    end
    
    PlotDotsDirect('mni',locs,weights,'b',clims,10,map,[],[],true)
    
    trodeLabels = repmat(count,2,1);
    if (plotLabels)
        
        for chan = 1:2
            
            txt = num2str(trodeLabels(chan));
            
            t = text(locs(chan,1),locs(chan,2),locs(chan,3),txt,'FontSize',10,'HorizontalAlignment','center','VerticalAlignment','middle');
            set(t,'clipping','on');
        end
    end
    count = count + 1;
end
title(['composite stimulation electrode plot'])
set(gca,'fontsize',14')


plotObj = gcf;
objhl = flipud(findobj(plotObj, 'type', 'line')); % objects of legend of type patch
%leg = legend([objhl(minChanIndex) objhl(maxChanIndex)],{['distribution width = ' num2str(minChanVal)],['distribution width = ' num2str(maxChanVal)]});

count = count+1;
set(gca,'fontsize',18)

leg = legend([objhl(1),objhl(2)],...
    {['positive stimulation electrode '],['negative stimulation electrode']});
%% no positive negative
colors = [
    0.1059    0.6196    0.4667;
    0.8510    0.3725    0.0078;
    0.4588    0.4392    0.7020;
    0.9059    0.1608    0.5412;
    0.4000    0.6510    0.1176;
    0.9020    0.6706    0.0078;
    0.6510    0.4627    0.1137;
    0.4000    0.4000    0.4000;
    ];
figure
PlotCortex('MNI')
hold on

figure
PlotCortex('MNI')
hold on

stimChansVec = [ 20 12;21 20; 22 19; 23 18; 28 4];

count = 1;
for stimChans = stimChansVec'
 
load('C:\Users\david\Data\Subjects\20f8a3\bis_trodes.mat')
    % project all to same hemisphere
    stims = stimChans;
    weights = [1 1];
    map = [.2 1 0; 1 1 1; 1 0 1];
    map = [0.5 0.5 1; 1 1 1; 1 0.5 0.5];
    locs = AllTrodes(stims,:);
    clims = [-1 1]; % we want the color limits to be the same for all sets of dots
   
    weights = [1 1];
    map = colors(count,:);
        clims = [-1 1]; % we want the color limits to be the same for all sets of dots
    
    markerSize = 15;
    logicIndex = [1 2];
    plot3(locs(logicIndex,1),locs(logicIndex,2),locs(logicIndex,3),'o',...
        'MarkerFaceColor',colors(count,:), 'MarkerSize',markerSize,'MarkerEdgeColor','k');
    trodeLabels = repmat(count,2,1);
    if (plotLabels)
        
        for chan = 1:2
            
            txt = num2str(trodeLabels(chan));
            
            t = text(locs(chan,1),locs(chan,2),locs(chan,3),txt,'FontSize',10,'HorizontalAlignment','center','VerticalAlignment','middle');
            set(t,'clipping','on');
        end
    end
    
    count = count + 1;
end
title(['composite stimulation electrode plot'])
set(gca,'fontsize',14')


plotObj = gcf;
objhl = flipud(findobj(plotObj, 'type', 'line')); % objects of legend of type patch
%leg = legend([objhl(minChanIndex) objhl(maxChanIndex)],{['distribution width = ' num2str(minChanVal)],['distribution width = ' num2str(maxChanVal)]});

count = count+1;
set(gca,'fontsize',18)

leg = legend([objhl(1),objhl(2),objhl(3),objhl(4),objhl(5),objhl(6),objhl(7)],...
    {'subject 1','subject 2','subject 3','subject 4','subject 5','subject 6','subject 7'})