%% symmetrize data from recorded ECoG surface grids, assuming their stimulation locations are known
% David.J.Caldwell 9.24.2018

%% run script to load data, declare stimulation channels, etc
% starting with subject 1. move everything in a block

figind = figure;
figindLog = figure;
cmap = flipud(cbrewer('div','RdBu',40));
load('america')
cmap = cm;

for index = 1:numTrialsAll
    
    % select subject data
    dataInt = reshape(dataSelect(:,index),8,8);
    
    % figure out shift needed to align
    
    xShift = mid - stimChansIndices(2,index) + 1;
    yShift = mid - stimChansIndices(1,index) + 1;
    
    %     % figure out how many 90 degree turns are needed
    %     rotation = [stimChansIndices(1,index)-stimChansIndices(3,index); stimChansIndices(2,index)-stimChansIndices(4,index)];
    %
    %     if rotation(1) < 0 && rotation(2) == 0
    %         rotateDirect = 0;
    %     elseif rotation(1) > 0 && rotation(2) == 0
    %         rotateDirect = 2;
    %     elseif rotation(1) == 0 && rotation(2) > 0
    %         rotateDirect = 3;
    %     elseif rotation(1) == 0 && rotation(2) < 0
    %         rotateDirect = 1;
    %     end
    %
    % manual correction
    
    gridData(xShift:xShift+7,yShift:yShift+7,index) = dataInt/currentMat(index);
    
    switch index
        case 1
            rotateDirect = 0;
            adjustNeg = [0 0];
        case 2
            rotateDirect = 1;
            adjustNeg = [1 -1];
        case 3
            rotateDirect = 1;
            adjustNeg = [1 -1];
        case 4
            rotateDirect = 1;
            adjustNeg = [1 -1];
        case 5
            rotateDirect = 3;
            adjustNeg = [1 1];
        case 6
            rotateDirect = 0;
            adjustNeg = [0 0];
        case 7
            rotateDirect =  2;
            adjustNeg = [2 0];
    end
    % rotate data
    
    gridData(:,:,index) = rot90(gridData(:,:,index),rotateDirect);
    
    tempGrid = gridData(:,:,index);
    tempGridLog = log(abs(1e3*tempGrid));
    tempGridLog(tempGrid>0) = 1*tempGridLog(tempGrid>0);
    tempGridLog(tempGrid<0) = -1*tempGridLog(tempGrid<0);
    gridDataLog(:,:,index) = tempGridLog;
    
    if plotIt
        figure(figind);
        subplot(2,4,index)
        imAlpha=ones(size(gridData(:,:,index)));
        imAlpha(isnan(gridData(:,:,index)))=0;
        imagesc(gridData(:,:,index),'AlphaData',imAlpha,[-max(abs(gridData(:))), max(abs(gridData(:)))])
        set(gca,'color',1*[0.7 0.7 0.7]);
        textStrings = {'+','-'};  %# Create strings from the matrix values
        textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
        hStrings = text([yShift+stimChansIndices(1,index)-1,yShift+stimChansIndices(3,index)-1+adjustNeg(1)],...
            [xShift+stimChansIndices(2,index)-1,xShift+stimChansIndices(4,index)-1+adjustNeg(2)],textStrings(:),...      %# Plot the strings
            'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',18);
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        set(gca,'ytick',[])
        set(gca,'yticklabel',[])
        set(gca,'fontsize',18)
        
        title(['subject ' num2str(index) ' aligned'])
        
        figure(figindLog)
        subplot(2,4,index)
        imAlpha=ones(size(gridData(:,:,index)));
        imAlpha(isnan(gridData(:,:,index)))=0;
        imagesc(gridDataLog(:,:,index),'AlphaData',imAlpha,[-max(abs(gridDataLog(:))), max(abs(gridDataLog(:)))])
        set(gca,'color',1*[0.7 0.7 0.7]);
        
        textStrings = {'+','-'};  %# Create strings from the matrix values
        textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
        hStrings = text([yShift+stimChansIndices(1,index)-1,yShift+stimChansIndices(3,index)-1+adjustNeg(1)],...
            [xShift+stimChansIndices(2,index)-1,xShift+stimChansIndices(4,index)-1+adjustNeg(2)],textStrings(:),...      %# Plot the strings
            'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',18);
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        set(gca,'ytick',[])
        set(gca,'yticklabel',[])
        set(gca,'fontsize',18)
        
        title(['subject ' num2str(index) ' aligned'])
    end
end

if plotIt
    figure(figind)
    cbar = colorbar();
    cbar.Label.String = 'V/I';
    caxis([-max(abs(gridData(:))), max(abs(gridData(:)))])
    
    colormap(cmap)
    if saveIt
        SaveFig(workingDirec,'individual','png','-r600');
    end
    
    figure(figindLog)
    cbar = colorbar();
    cbar.Label.String = '+/- log(abs(1e3 * V/I)';
    caxis([-max(abs(gridDataLog(:))), max(abs(gridDataLog(:)))])
    
    colormap(cmap)
    if saveIt
        SaveFig(workingDirec,'individualLog','png','-r600');
    end
end

%%
xShift = mid - stimChansIndices(2,1) + 1;
yShift = mid - stimChansIndices(1,1) + 1;

% take average, no symmetry
gridDataAvg = nanmean(gridData,3);

stimChansIndicesSym = [yShift+stimChansIndices(1,1)-1,  xShift+stimChansIndices(2,1)-1,...
    yShift+stimChansIndices(3,1)-1,xShift+stimChansIndices(4,1)-1];

if plotIt
    imAlpha=ones(size(gridDataAvg));
    imAlpha(isnan(gridDataAvg))=0;
    figure
    imagesc(gridDataAvg,'AlphaData',imAlpha,[-max(abs(gridDataAvg(:))), max(abs(gridDataAvg(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    
    title('averaged - no symmetry')
    cbar = colorbar();
    cbar.Label.String = 'V/I';
    caxis([-max(abs(gridDataAvg(:))), max(abs(gridDataAvg(:)))])
    colormap(cmap)
    
    if saveIt
        SaveFig(workingDirec,'averageNoSymmetry','png','-r600');
    end
end

% take average, no symmetry
gridDataAvgLog = log(abs(1e3*gridDataAvg));
gridDataAvgLog(gridDataAvg>0) = 1*gridDataAvgLog(gridDataAvg>0);
gridDataAvgLog(gridDataAvg<0) = -1*gridDataAvgLog(gridDataAvg<0);

if plotIt
    imAlpha=ones(size(gridDataAvg));
    imAlpha(isnan(gridDataAvg))=0;
    figure
    imagesc(gridDataAvgLog,'AlphaData',imAlpha,[-max(abs(gridDataAvgLog(:))), max(abs(gridDataAvgLog(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    
    title('averaged - no symmetry')
    cbar = colorbar();
    cbar.Label.String = '+/- log(abs(1e3 * V/I)';
    caxis([-max(abs(gridDataAvgLog(:))), max(abs(gridDataAvgLog(:)))])
    colormap(cmap)
    
    if saveIt
        SaveFig(workingDirec,'averageNoSymmetryLog','png','-r600');
    end
    
end
%%
% pad to make left right flip easier
gridDataExpandLR = cat(2,gridData,nan(15,1,numTrialsAll));
gridDataLRavg =  nanmean(cat(3,-fliplr(gridDataExpandLR),gridDataExpandLR),3);
% now shrink
gridDataLRavg = gridDataLRavg(:,1:end-1,:);

if plotIt
    imAlpha=ones(size(gridDataLRavg));
    imAlpha(isnan(gridDataLRavg))=0;
    
    figure
    imagesc(gridDataLRavg,'AlphaData',imAlpha,[-max(abs(gridDataLRavg(:))), max(abs(gridDataLRavg(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    
    title('averaged - LR symmetry')
    colormap(cmap)
    cbar = colorbar();
    cbar.Label.String = 'V/I';
    caxis([-max(abs(gridDataLRavg(:))), max(abs(gridDataLRavg(:)))])
    
    if saveIt
        SaveFig(workingDirec,'averageLRsym','png','-r600');
    end
end

gridDataLRavgLog = log(abs(1e3*gridDataLRavg));
gridDataLRavgLog(gridDataLRavg>0) = 1*gridDataLRavgLog(gridDataLRavg>0);
gridDataLRavgLog(gridDataLRavg<0) = -1*gridDataLRavgLog(gridDataLRavg<0);

if plotIt
    figure
    
    imagesc(gridDataLRavgLog,'AlphaData',imAlpha,[-max(abs(gridDataLRavg(:))), max(abs(gridDataLRavg(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    
    title('averaged - LR symmetry')
    colormap(cmap)
    cbar = colorbar();
    cbar.Label.String = '+/- log(abs(1e3 * V/I)';
    caxis([-max(abs(gridDataLRavgLog(:))), max(abs(gridDataLRavgLog(:)))])
    
    if saveIt
        SaveFig(workingDirec,'averageLRsymLog','png','-r600');
    end
    
end
%%
% flip up down and average
gridDataUD = cat(3,flipud(gridData),gridData);
gridDataUDavg = nanmean(gridDataUD,3);

if plotIt
    imAlpha=ones(size(gridDataUDavg));
    imAlpha(isnan(gridDataUDavg))=0;
    
    figure
    imagesc(gridDataUDavg,'AlphaData',imAlpha,[-max(abs(gridDataUDavg(:))), max(abs(gridDataUDavg(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    
    title('averaged - UD symmetry ')
    colormap(cmap)
    cbar = colorbar();
    cbar.Label.String = 'V/I';
    caxis([-max(abs(gridDataUDavg(:))), max(abs(gridDataUDavg(:)))])
    
    
    if saveIt
        SaveFig(workingDirec,'averageUDsym','png','-r600');
    end
end

gridDataUDavgLog = log(abs(1e3*gridDataUDavg));
gridDataUDavgLog(gridDataUDavg>0) = 1*gridDataUDavgLog(gridDataUDavg>0);
gridDataUDavgLog(gridDataUDavg<0) = -1*gridDataUDavgLog(gridDataUDavg<0);

if plotIt
    figure
    imagesc(gridDataUDavgLog,'AlphaData',imAlpha,[-max(abs(gridDataUDavg(:))), max(abs(gridDataUDavg(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    
    title('averaged - UD symmetry ')
    colormap(cmap)
    cbar = colorbar();
    cbar.Label.String = '+/- log(abs(1e3 * V/I)';
    caxis([-max(abs(gridDataUDavgLog(:))), max(abs(gridDataUDavgLog(:)))])
    
    if saveIt
        SaveFig(workingDirec,'averageUDsymLog','png','-r600');
    end
end
%%
% pad and expand UD
gridDataExpandUD = cat(3,flipud(gridData),gridData);
gridDataExpandUD = cat(2,gridDataExpandUD,nan(15,1,numTrialsAll*2));
% combine left right up down
gridDataLRUD = cat(3,gridDataExpandLR,-fliplr(gridDataExpandLR),gridDataExpandUD,grid);
%average
gridDataLRUDavg = nanmean(gridDataLRUD,3);
% now shrink
gridDataLRUDavg = gridDataLRUDavg(:,1:end-1,:);

if plotIt
    imAlpha=ones(size(gridDataLRUDavg));
    imAlpha(isnan(gridDataLRUDavg))=0;
    
    figure
    imagesc(gridDataLRUDavg,'AlphaData',imAlpha,[-max(abs(gridDataLRUDavg(:))), max(abs(gridDataLRUDavg(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    colormap(cmap)
    cbar = colorbar();
    cbar.Label.String = 'V/I';
    caxis([-max(abs(gridDataLRUDavg(:))), max(abs(gridDataLRUDavg(:)))])
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    
    title('averaged - LRUD symmetry')
    if saveIt
        SaveFig(workingDirec,'averageLRUDsym','png','-r600');
    end
end

gridDataLRUDavgLog = log(abs(1e3*gridDataLRUDavg));
gridDataLRUDavgLog(gridDataLRUDavg>0) = 1*gridDataLRUDavgLog(gridDataLRUDavg>0);
gridDataLRUDavgLog(gridDataLRUDavg<0) = -1*gridDataLRUDavgLog(gridDataLRUDavg<0);

if plotIt
    
    figure
    imagesc(gridDataLRUDavgLog,'AlphaData',imAlpha,[-max(abs(gridDataLRUDavgLog(:))), max(abs(gridDataLRUDavgLog(:)))])
    set(gca,'color',1*[0.7 0.7 0.7]);
    
    
    colormap(cmap)
    cbar = colorbar();
    cbar.Label.String = '+/- log(abs(1e3 * V/I)';
    caxis([-max(abs(gridDataLRUDavgLog(:))), max(abs(gridDataLRUDavgLog(:)))])
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
        [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
    
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'fontsize',18)
    title('averaged - LRUD symmetry')
    if saveIt
        SaveFig(workingDirec,'averageLRUDsym','png','-r600');
    end
end

if saveIt
    save('symmetricDataDavid_9_24_2018.mat','gridData','gridDataLRUDavg',...
        'gridDataLRUD','gridDataLRavg','gridDataExpandLR','gridDataUD','gridDataUDavg')
end

