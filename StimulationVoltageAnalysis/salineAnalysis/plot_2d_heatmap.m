function [] = plot_2d_heatmap(meanMatAll,numChans,uniqueLabels,stimChans)

%% 2d plot

% label the grid - from http://stackoverflow.com/questions/3942892/how-do-i-visualize-a-matrix-with-colors-and-values-displayed

textStrings = num2str([1:numChans]');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x,y] = meshgrid(1:8);   %# Create x and y coordinates for the strings

x = x';
y= y';
meanMatAll(isnan(meanMatAll)) = 0;

valScale = squeeze(max((abs(meanMatAll(:,1,:)))));

for i = 1:length(uniqueLabels)
    figure
    % plot first phase
    imagesc(transpose(reshape(meanMatAll(:,1,i),8,8)));
    % color map
    
    hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center');
    
        hStringsStims = text(x(stimChans),y(stimChans),textStrings(stimChans),...      %# Plot the strings
        'HorizontalAlignment','center','color','red');
    load('america.mat')
    colormap(cm)
    axis off
    colorbar
    caxis([-valScale(i) valScale(i)])
    
    title({['2D plot of recorded voltages ',num2str(uniqueLabels(i)),' \muA'],['stimulation channels ' num2str(stimChans)]});
    
end

end
