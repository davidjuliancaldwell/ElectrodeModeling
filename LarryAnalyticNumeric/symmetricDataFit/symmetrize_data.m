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

gridData = zeros(15,15,numSubjs);
mid = 8;

% starting with subject 1. move everything in a block

figure

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
    
    switch index
        case 1
            rotateDirect = 0;
        case 2
            rotateDirect = 1;
        case 3
            rotateDirect = 1;
        case 4
            rotateDirect = 1;
        case 5
            rotateDirect = 3;
        case 6
            rotateDirect = 0;
        case 7
            rotateDirect =  2;
    end
    
    gridData(xShift:xShift+7,yShift:yShift+7,index) = dataInt;
    % rotate data
    
    gridData(:,:,index) = rot90(gridData(:,:,index),rotateDirect);
    
    subplot(2,4,index)
    imagesc(gridData(:,:,index))
    title(['subject ' num2str(index) ' aligned'])
end
if saveIt
    SaveFig(workingDirec,'individual','png','-r600');
    
end


% take average, no symmetry
gridDataAvg = nanmean(gridData,3);
figure
imagesc(gridDataAvg)
title('averaged - no symmetry')

if saveIt
    SaveFig(workingDirec,'averageNoSymmetry','png','-r600');
end

% pad to make left right flip easier
gridDataExpandLR = cat(2,gridData,nan(15,1,numSubjs));
gridDataLRavg =  nanmean(cat(3,-fliplr(gridDataExpandLR),gridDataExpandLR),3);
% now shrink
gridDataLRavg = gridDataLRavg(1:end-1,1:end-1,:);

figure
imagesc(rot90(gridDataLRavg,1))
title('averaged - LR symmetry')
if saveIt
    SaveFig(workingDirec,'averageLRsym','png','-r600');
end

% flip up down and average
gridDataUD = cat(3,flipud(gridData),gridData);
gridDataUDavg = nanmean(gridDataUD,3);

figure
imagesc(gridDataUDavg)
title('averaged - UD symmetry ')
if saveIt
    SaveFig(workingDirec,'averageUDsym','png','-r600');
end

% pad and expand UD
gridDataExpandUD = cat(3,flipud(gridData),gridData);
gridDataExpandUD = cat(2,gridDataExpandUD,nan(15,1,numSubjs*2));
% combine left right up down
gridDataLRUD = cat(3,gridDataExpandLR,gridDataExpandUD);
%average
gridDataLRUDavg = nanmean(gridDataLRUD,3);
% now shrink
gridDataLRUDavg = gridDataLRUDavg(1:end-1,1:end-1,:);

figure
imagesc(gridDataLRUDavg)
title('averaged - LRUD symmetry')
if saveIt
    SaveFig(workingDirec,'averageLRUDsym','png','-r600');
end

if saveIt
save('symmetricDataDavid_9_24_2018.mat','gridData','gridDataLRUDavg',...
    'gridDataLRUD','gridDataLRavg','gridDataExpandLR','gridDataUD','gridDataUDavg')
end

