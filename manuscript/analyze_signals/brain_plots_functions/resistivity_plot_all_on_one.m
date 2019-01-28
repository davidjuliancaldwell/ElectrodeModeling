%% script to plot cortices for resistivity modeling
%
% David.J.Caldwell 9.25.2017 

%clear all;close all;clc
Z_Constants_resistivity_brainPlots

project = 1;
plotLabels = 1;
%% parameters
figure
PlotCortex('MNI')
hold on

count = 1;
leftSide = [1 2 4 6 7];
rightSide = [3 5];
for sid = SIDS
    subjid = sid{:};
    switch(subjid)
        case '0b5a2e'
            stims = [22 30];
        case '702d24'
            stims = [13 14];
        case '7dbdec'
            stims = [11 12];
        case '9ab7ab'
            stims = [59 60];
        case 'c91479'
            stims = [56 55];
        case 'd5cd55'
            stims = [54 62];
        case 'ecb43e'
            stims = [64 56];
        otherwise
            error('unknown SID entered');
    end
    
    load(fullfile('C:\Users\david\Data\Subjects\coords',...
        [subjid,'_trode_coords_MNIandTal.mat']))
    % project all to same hemisphere
    
    
    %locsStruct.(strcat('x',i{:})) = locs;
    locs = MNIcoords(1:64,:);
    
    
    weights = [1 -1];
    map = [.2 1 0; 1 1 1; 1 0 1];
    map = [0.5 0.5 1; 1 1 1; 1 0.5 0.5];
    locs = locs(stims,:);
    clims = [-1 1]; % we want the color limits to be the same for all sets of dots
    
    % project all onto the same sides
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

count = 1;
leftSide = [1 2 4 6 7];
rightSide = [3 5];
for sid = SIDS
    subjid = sid{:};
    switch(subjid)
        case '0b5a2e'
            stims = [22 30];
        case '702d24'
            stims = [13 14];
        case '7dbdec'
            stims = [11 12];
        case '9ab7ab'
            stims = [59 60];
        case 'c91479'
            stims = [56 55];
        case 'd5cd55'
            stims = [54 62];
        case 'ecb43e'
            stims = [64 56];
        otherwise
            error('unknown SID entered');
    end
    
    load(fullfile('C:\Users\david\Data\Subjects\coords',...
        [subjid,'_trode_coords_MNIandTal.mat']))
    
    %locsStruct.(strcat('x',i{:})) = locs;
    locs = MNIcoords(1:64,:);
    
    
    weights = [1 1];
    map = colors(count,:);
    
    locs = locs(stims,:);
    clims = [-1 1]; % we want the color limits to be the same for all sets of dots
    
    % project all onto the same side
    if project
        locs = projectToHemisphere(locs, 'l');
    end
    
    
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