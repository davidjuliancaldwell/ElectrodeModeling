function smallMultiplesModeling(signal,t,varargin)
%% DJC - 5/10/2017 small multiples plotting
% plot small mutliple plots - time x channels x trials


% defaults
type1 = [];
type2 = [];
average = 0;
sameScale = 0;

for i=1:2:(length(varargin)-1)
    if ~ischar (varargin{i}),
        error (['Unknown type of optional parameter name (parameter' ...
            ' names must be strings).']);
    end
    % change the value of parameter
    switch lower (varargin{i})
        case 'type1'
            type1 = varargin{i+1};
        case 'type2'
            type2 = varargin{i+1};
        case 'average'
            average = varargin{i+1};
        case 'samescale'
            sameScale = varargin{i+1};
    end
end

%
totalFig = figure;
totalFig.Units = 'inches';
totalFig.Position = [1 1 8 8];;
CT = cbrewer('qual','Accent',8);
CT = flipud(CT);

[p,n] = numSubplots(size(signal,2));

for idx=1:size(signal,2)
    smplot(p(1),p(2),idx,'axis','on')
    
    if average
        if ismember(idx,type1)
            plot(1e3*t,1e3*signal(:,idx),'Color',CT(3,:),'LineWidth',2)
            title([num2str(idx)],'Color',CT(3,:))
        elseif ismember(idx,type2)
            plot(1e3*t,1e3*signal(:,idx),'Color',CT(2,:),'LineWidth',2)
            title([num2str(idx)],'Color',CT(2,:))
        else
            plot(1e3*t,1e3*signal(:,idx),'Color',CT(1,:),'LineWidth',2)
            title([num2str(idx)],'color',CT(1,:))
        end
        
    elseif ~average
        if ismember(idx,type1)
            plot(1e3*t,1e3*squeeze(signal(:,idx,:)),'Color',CT(3,:),'LineWidth',2)
            title([num2str(idx)],'Color',CT(3,:))
        elseif ismember(idx,type2)
            plot(1e3*t,1e3*squeeze(signal(:,idx)),'Color',CT(2,:),'LineWidth',2)
            title([num2str(idx)],'Color',CT(2,:))
        else
            plot(1e3*t,1e3*squeeze(signal(:,idx)),'Color',CT(1,:),'LineWidth',2)
            title([num2str(idx)],'color',CT(1,:))
        end
        
    end
    
    
    %  axis off
    %  axis tight
    xlim([0 6])
    set(gca,'fontsize',10)
    
    if sameScale
        ylim([-5 5])
    end
    % vline(0)
    
end
%'LL'(default), 'LR', 'UL', 'UR'
% xlabel('Time (ms)')
% ylabel('Voltage (V)')
end