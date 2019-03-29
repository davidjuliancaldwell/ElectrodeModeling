function [] = plot_EPs_fromEpochedData(dataEpoched,t,uniqueLabels,labels,stimChans)


% determine number of subplot
numChans = size(dataEpoched,2);
subPlots = numSubplots(numChans);
p = subPlots(1);
q = subPlots(2);
% %%
% % plot each condition separately e.g. 1000 uA, 2000 uA, and so on
% % intialize counter for plotting
% k = 1;
% 
% for i=uniqueLabels
%     figure;
%     dataInterest = dataEpoched(:,:,labels==i);
%     for j = 1:numChans
%         subplot(p,q,j);
%         plot(t,squeeze(dataInterest(:,j,:)));
%         xlim([min(t) max(t)]);
%         
%         % change y axis scaling if necessary
%         ylim([-600 600])
%         
%         % put a box around the stimulation channels of interest if need be
%         if ismember(j,stimChans)
%             ax = gca;
%             ax.Box = 'on';
%             ax.XColor = 'red';
%             ax.YColor = 'red';
%             ax.LineWidth = 2;
%             title(num2str(j),'color','red');
%             
%         else
%             title(num2str(j));
%             
%         end
%         vline(0);
%         
%     end
%     
%     % label axis
%     xlabel('time (ms)');
%     ylabel(['voltage in \muV']);
%     subtitle(['Individual traces - Current set to ',num2str(uniqueLabels(k)),' \muA']);
%     
%     % get cell of raw values, can use this to analyze later
%     dataRaw{k} = dataInterest;
%     
%     % get averages to plot against each for later
%     % cell function, can use this to analyze later
%     dataAvgs{k} = mean(dataInterest,3);
%     
%     %increment counter
%     k = k + 1;
%     
%     
% end

%% plot each condition separately e.g. 1000 uA, 2000 uA, and so on
% intialize counter for plotting
k = 1;

for i=uniqueLabels
    figLabels = figure;
    figLabels.Units = "inches";
    figLabels.Position = [1 1 8 8];
    
    dataInterest = dataEpoched(:,:,labels==i);
    for j = 1:numChans
        smplot(14,8,j,'top',0.1);
        plot(t,mean(squeeze(dataInterest(:,j,:)),2),'linewidth',2);
        xlim([min(t) max(t)]);
        xlim([-50 150])
        % change y axis scaling if necessary
    ylim([-1500 1500])
        
        % put a box around the stimulation channels of interest if need be
        if ismember(j,stimChans)
            ax = gca;
            ax.Box = 'on';
            ax.XColor = 'red';
            ax.YColor = 'red';
            ax.LineWidth = 2;
            title(num2str(j),'color','red');
            
        else
            title(num2str(j));
            
        end
        vline(0);
        if j < numChans
        set(gca,'Yticklabel',[]) 
set(gca,'Xticklabel',[]) 
        end
    end

    % label axis
    xlabel('time (ms)');
    ylabel(['voltage (\muV)']);
   sgtitle(['average traces - Current set to ',num2str(uniqueLabels(k)),' \muA']);
    
    % get cell of raw values, can use this to analyze later
    dataRaw{k} = dataInterest;
    
    % get averages to plot against each for later
    % cell function, can use this to analyze later
    dataAvgs{k} = mean(dataInterest,3);
    
    %increment counter
    k = k + 1;
    
    figure
    
    plot(t,mean(squeeze(dataInterest(:,32,:)),2),'linewidth',2);
    xlim([min(t) max(t)]);
    xlim([-50 150])
    % change y axis scaling if necessary
    ylim([-1000 1000])
    xlabel('time (ms)');
    ylabel(['voltage in \muV']);
    
end


%% plot averages for conditions on the same graph

k = 1;
figure;
for k = 1:length(dataAvgs)
    
    tempData = dataAvgs{k};
    
    for j = 1:numChans
        s = subplot(p,q,j);
        plot(t,squeeze(tempData(:,j)),'linewidth',2);
        hold on;
        xlim([min(t) max(t)]);
        
        ylim([-1000 1000])
        
        
        if ismember(j,stimChans)
            ax = gca;
            ax.Box = 'on';
            ax.XColor = 'red';
            ax.YColor = 'red';
            ax.LineWidth = 2;
            title(num2str(j),'color','red')
            
        else
            title(num2str(j));
            
        end
        
        vline(0);
        
    end
    gcf;
end
xlabel('time (ms)');
ylabel(['voltage (\muV)']);
subtitle(['Averages for all conditions']);
legLabels = {[num2str(uniqueLabels(1))]};

k = 2;
if length(uniqueLabels>1)
    for i = uniqueLabels(2:end)
        legLabels{end+1} = [num2str(uniqueLabels(k))];
        k = k+1;
    end
end

legend(s,legLabels);

end