%% symmetrize data from recorded ECoG surface grids, assuming their stimulation locations are known
% David.J.Caldwell 9/24/2018

%% clean workspace and load data
close all;clear all;clc
workingDirec = pwd;
saveIt = 0;
%% run script to load data, declare stimulation channels, etc
prepare_data

stimChansIndices = [jp_vec; kp_vec; jm_vec; km_vec];
% adjust 5 and 7
stimChansIndices(:,5) = [jm_vec(5); km_vec(5); jp_vec(5); kp_vec(5)];
stimChansIndices(:,7) = [jm_vec(7); km_vec(7); jp_vec(7); kp_vec(7)];

numSubjs = 7;
data = meanMatAll_1st8(:,1,1:numSubjs);

gridData = nan(15,15,numSubjs);
mid = 8;

% starting with subject 1. move everything in a block

figure
cmap = flipud(cbrewer('div','PiYG',40));

for index = 1:numSubjs
    
    % select subject data
    dataInt = reshape(data(:,index),8,8);
    
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
    
    gridData(:,:,index) = 1e3*rot90(gridData(:,:,index),rotateDirect);
    
    subplot(2,4,index)
    imAlpha=ones(size(gridData(:,:,index)));
    imAlpha(isnan(gridData(:,:,index)))=0;
    imagesc(gridData(:,:,index),'AlphaData',imAlpha,[-max(abs(gridData(:))), max(abs(gridData(:)))])
    set(gca,'color',0*[1 1 1]);
    
    textStrings = {'+','-'};  %# Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
    hStrings = text([yShift+stimChansIndices(1,index)-1,yShift+stimChansIndices(3,index)-1+adjustNeg(1)],...
        [xShift+stimChansIndices(2,index)-1,xShift+stimChansIndices(4,index)-1+adjustNeg(2)],textStrings(:),...      %# Plot the strings
        'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',18);
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    title(['subject ' num2str(index) ' aligned'])
end
cbar = colorbar();
cbar.Label.String = 'Recorded Voltage/Stimulation Current';
caxis([-max(abs(gridData(:))), max(abs(gridData(:)))])

colormap(cmap)
if saveIt
    SaveFig(workingDirec,'individual','png','-r600');
end

%%
xShift = mid - stimChansIndices(2,1) + 1;
yShift = mid - stimChansIndices(1,1) + 1;

% take average, no symmetry
gridDataAvg = nanmean(gridData,3);
imAlpha=ones(size(gridDataAvg));
imAlpha(isnan(gridDataAvg))=0;
figure
imagesc(gridDataAvg,'AlphaData',imAlpha,[-max(abs(gridDataAvg(:))), max(abs(gridDataAvg(:)))])
set(gca,'color',0*[1 1 1]);

textStrings = {'+','-'};  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
    [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
    'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);

set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
title('averaged - no symmetry')
cbar = colorbar();
cbar.Label.String = 'Recorded Voltage/Stimulation Current';
caxis([-max(abs(gridDataAvg(:))), max(abs(gridDataAvg(:)))])
colormap(cmap)

if saveIt
    SaveFig(workingDirec,'averageNoSymmetry','png','-r600');
end
%%
% pad to make left right flip easier
gridDataExpandLR = cat(2,gridData,nan(15,1,numSubjs));
gridDataLRavg =  nanmean(cat(3,-fliplr(gridDataExpandLR),gridDataExpandLR),3);
% now shrink
gridDataLRavg = gridDataLRavg(1:end-1,1:end-1,:);
imAlpha=ones(size(gridDataLRavg));
imAlpha(isnan(gridDataLRavg))=0;

figure
imagesc(gridDataLRavg,'AlphaData',imAlpha,[-max(abs(gridDataLRavg(:))), max(abs(gridDataLRavg(:)))])
set(gca,'color',0*[1 1 1]);

textStrings = {'+','-'};  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
    [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
    'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
title('averaged - LR symmetry')
colormap(cmap)
cbar = colorbar();
cbar.Label.String = 'Recorded Voltage/Stimulation Current';
caxis([-max(abs(gridDataLRavg(:))), max(abs(gridDataLRavg(:)))])

if saveIt
    SaveFig(workingDirec,'averageLRsym','png','-r600');
end
%%
% flip up down and average
gridDataUD = cat(3,flipud(gridData),gridData);
gridDataUDavg = nanmean(gridDataUD,3);
imAlpha=ones(size(gridDataUDavg));
imAlpha(isnan(gridDataUDavg))=0;

figure
imagesc(gridDataUDavg,'AlphaData',imAlpha,[-max(abs(gridDataUDavg(:))), max(abs(gridDataUDavg(:)))])
set(gca,'color',0*[1 1 1]);

textStrings = {'+','-'};  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
hStrings = text([yShift+stimChansIndices(1,1)-1,yShift+stimChansIndices(3,1)-1],...
    [xShift+stimChansIndices(2,1)-1,xShift+stimChansIndices(4,1)-1],textStrings(:),...      %# Plot the strings
    'HorizontalAlignment','center','color',[255 165 0]/256,'fontsize',30);
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
title('averaged - UD symmetry ')
colormap(cmap)
cbar = colorbar();
cbar.Label.String = 'Recorded Voltage/Stimulation Current';
caxis([-max(abs(gridDataUDavg(:))), max(abs(gridDataUDavg(:)))])


if saveIt
    SaveFig(workingDirec,'averageUDsym','png','-r600');
end
%%
% pad and expand UD
gridDataExpandUD = cat(3,flipud(gridData),gridData);
gridDataExpandUD = cat(2,gridDataExpandUD,nan(15,1,numSubjs*2));
% combine left right up down
gridDataLRUD = cat(3,gridDataExpandLR,-fliplr(gridDataExpandLR),gridDataExpandUD);
%average
gridDataLRUDavg = nanmean(gridDataLRUD,3);
% now shrink
gridDataLRUDavg = gridDataLRUDavg(1:end-1,1:end-1,:);

imAlpha=ones(size(gridDataLRUDavg));
imAlpha(isnan(gridDataLRUDavg))=0;

figure
imagesc(gridDataLRUDavg,'AlphaData',imAlpha,[-max(abs(gridDataLRUDavg(:))), max(abs(gridDataLRUDavg(:)))])
set(gca,'color',0*[1 1 1]);


colormap(cmap)
cbar = colorbar();
cbar.Label.String = 'Recorded Voltage/Stimulation Current';
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

title('averaged - LRUD symmetry')
if saveIt
    SaveFig(workingDirec,'averageLRUDsym','png','-r600');
end

if saveIt
    save('symmetricDataDavid_9_24_2018.mat','gridData','gridDataLRUDavg',...
        'gridDataLRUD','gridDataLRavg','gridDataExpandLR','gridDataUD','gridDataUDavg')
end

