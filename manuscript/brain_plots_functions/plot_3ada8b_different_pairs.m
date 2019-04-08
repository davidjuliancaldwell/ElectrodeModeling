%% script to plot all of the 3ada8b pairs on one cortex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David.J.Caldwell 12.9.2018

clear all;close all;clc
Z_Constants_resistivity_brainPlots

project = 1;
plotLabels = 0;
%% parameters
figure
%PlotCortex('MNI')
PlotCortex('3ada8b')
hold on

stimChansVec = [3 4; 4 12; 4 20; 5 7; 12 13; 11 14; 10 15; 9 16];

count = 1;
for stimChans = stimChansVec'
    
    load('C:\Users\david\Data\Subjects\3ada8b\trodes.mat')
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
    0.55      0.833     0.78
    ];

figure
PlotCortex('3ada8b')
hold on

stimChansVec = [3 4; 4 12; 4 20; 5 7; 12 13; 11 14; 10 15; 9 16];

count = 1;
for stimChans = stimChansVec'
    
    load('C:\Users\david\Data\Subjects\3ada8b\trodes.mat')
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
    
  %  markerSize = 15;
    logicIndex = [1 2];
    % plot3(locs(logicIndex,1),locs(logicIndex,2),locs(logicIndex,3),'o',...
     %   'MarkerFaceColor',colors(count,:), 'MarkerSize',markerSize,'MarkerEdgeColor','k');

     markerSize = 250;
     if count == 2 || count == 3
     locs(logicIndex,:) = locs(logicIndex,:) + count;
     end
     scatter3(locs(logicIndex,1),locs(logicIndex,2),locs(logicIndex,3),markerSize,'filled',...
        'MarkerFaceColor',colors(count,:),...
        'MarkerEdgeColor','k',...
        'MarkerFaceAlpha', 0.7);


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
%title(['Subject Eight Stimulation Electrodes'])
set(gca,'fontsize',14')


plotObj = gcf;
%objhl = flipud(findobj(plotObj, 'type', 'line')); % objects of legend of type patch
%leg = legend([objhl(minChanIndex) objhl(maxChanIndex)],{['distribution width = ' num2str(minChanVal)],['distribution width = ' num2str(maxChanVal)]});
objhl = flipud(findobj(plotObj, 'type', 'Scatter')); % objects of legend of type patch

count = count+1;
set(gca,'fontsize',18)

leg = legend([objhl(1),objhl(2),objhl(3),objhl(4),objhl(5),objhl(6),objhl(7),objhl(8)],...
    {'3/4','4/12','4/20','5/7','12/13','11/14','10/15','9/16'})

stimChansVec = [3 4; 4 12; 4 20; 5 7; 12 13; 11 14; 10 15; 9 16];
