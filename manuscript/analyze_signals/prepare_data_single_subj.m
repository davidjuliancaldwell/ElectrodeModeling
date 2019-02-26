%% script to prepare the data for the one layer point theory

function [subStruct] = prepare_data_single_subj(eliminateBadChannels)
load('america')

useMNI = 0;
cd(fileparts(which('prepare_data_single_subj')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','data');
folderCoords = fullfile(locationsDir,'..','coordinates');

totalData = load(fullfile(folderData,'recorded_voltages.mat'));

subStruct = struct;
totalDataInd = fieldnames(totalData)';
disp(['Field named: ' totalDataInd{1} ]);

disp(totalData.(totalDataInd{1}));
subStruct = totalData.(totalDataInd{1});

numIndices = size(subStruct.meanMat,3);

% define fs
diffT = diff(subStruct.t)/1e3;
subStruct.fs =  1/diffT(1);

% stimulation electrode locations, each column is a subject
jp_vec = [3 2 2 8 7 7 8 4 ...
    3 4 3 3 3];
kp_vec = [6 5 3 3 8 6 8 3 ...
    4 4 7 6 5];
jm_vec = [4 2 2 8 7 8 7 4 ...
    2 1 3 3 3];
km_vec = [6 6 4 4 7 6 8 4 ...
    4 4 2 3 4];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stimChansIndices = [jp_vec; kp_vec; jm_vec; km_vec];

stimChansVecOnly = {22 30; 13 14; 11 12; 59 60; 56 55; 54 62; 64 56};

badTotal = {};
if eliminateBadChannels
    badTotal{1} = [[stimChansVecOnly{1,:}] 17 18 19];
    badTotal{2} = [[stimChansVecOnly{2,:}] 23 27 28 29 30 32 44 52 60];
    badTotal{3} = [[stimChansVecOnly{3,:}] 57];
    badTotal{4} = [[stimChansVecOnly{4,:}] 2 3 31 57];
    badTotal{5} = [[stimChansVecOnly{5,:}] 1 49 58 59];
    badTotal{6} = [[stimChansVecOnly{6,:}] 57:64];
    badTotal{7} = [[stimChansVecOnly{7,:}] 1 9 10 35 43];
else
    badTotal{1} = [[stimChansVecOnly{1,:}]];
    badTotal{2} = [[stimChansVecOnly{2,:}]];
    badTotal{3} = [[stimChansVecOnly{3,:}]];
    badTotal{4} = [[stimChansVecOnly{4,:}]];
    badTotal{5} = [[stimChansVecOnly{5,:}]];
    badTotal{6} = [[stimChansVecOnly{6,:}]];
    badTotal{7} = [[stimChansVecOnly{7,:}]];
end

subStruct.badTotal = badTotal;


subStruct.stimChansIndices = stimChansIndices;

% loop through trials within structure
for index = 1:numIndices
    
    %subStruct.badChans = [];
    %subStruct.badTotal{index} = [subStruct.stimChans(index,:) subStruct.badChans];
    
    subStruct.meanData{index} = subStruct.meanMat(:,1,index);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get electrode locations CT first and then MNI
    
    % CT
    load(fullfile(folderCoords,['subj_' num2str(subStruct.subjectNum(index)) '_bis_trodes.mat']));
    AllTrodes = AllTrodes(1:64,:);
    subStruct.CTlocs{index} = AllTrodes;
    % [Center,Radius] = sphereFit(AllTrodes);
    highPolyModel = fullfile(folderCoords,['subj' num2str(index) '_cortex_both_hires.mat']);
    load(highPolyModel);
    
    
    [Center,Radius] = sphereFit(cortex.vertices);
    % figure out center of sphere
    
    [x,y,z] = sphere;
    x = Radius*x  + Center(1);
    y = Radius*y + Center(2);
    z = Radius*z + Center(3);
    
    %    x = Radius*x ;
    %   y = Radius*y;
    %   z = Radius*z;
    ctMNIFig = figure;
    subplot(2,1,1)
    s = surf(x,y,z);
    %set(s,'EdgeColor','none');
    set(s,'FaceAlpha',0.25);
    set(s,'FaceColor',[0.5 0.5 0.5]);
    hold on
    locs = AllTrodes(1:64,:);
    
    % take labeling from plot dots direct
    scatter3(locs(:,1),locs(:,2),locs(:,3),[100],[1 0 0],'filled');
    %
    gridSize = 64;
    trodeLabels = [1:gridSize];
    for chan = 1:gridSize
        txt = num2str(trodeLabels(chan));
        t = text(locs(chan,1),locs(chan,2),locs(chan,3),txt,'FontSize',10,'HorizontalAlignment','center','VerticalAlignment','middle');
        set(t,'clipping','on');
    end
    title(['CT Coords - Subject ' num2str(index)])
    AllTrodes = [AllTrodes(:,1) - Center(1) AllTrodes(:,2) - Center(2) AllTrodes(:,3) - Center(3)];
    
    [az,el,r]  = cart2sph(AllTrodes(:,1),AllTrodes(:,2),AllTrodes(:,3));
    subStruct.CTlocsSpherical{index}(:,1) = az;
    subStruct.CTlocsSpherical{index}(:,2) = el;
    subStruct.CTlocsSpherical{index}(:,3) = r;
    
    gridSize = [8,8];
    [X,Y] = meshgrid(1:gridSize(1),1:gridSize(2));
    X = X(:);
    Y = Y(:);
    DT = delaunayTriangulation(X,Y);
    TR = triangulation(DT.ConnectivityList,locs(:,1),locs(:,2),locs(:,3));
    
    [GC MC]= curvatures(locs(:,1),locs(:,2),locs(:,3),DT.ConnectivityList);
    subStruct.CT_GC{index} = GC;
    subStruct.CT_MC{index} = MC;
    figure
    set(gcf,'position',[378.3333 123.6667 664.6667 1.2047e+03])
    
    subplot(2,1,1)
    trisurf(TR,GC);
    caxis([-max(abs(GC)) max(abs(GC))])
    colorbar()
    title(['Subject ' num2str(index) ' CT Gaussian Curvature'])
    
    subplot(2,1,2)
    trisurf(TR,MC);
    colorbar()
    caxis([-max(abs(MC)) max(abs(MC))])
    title(['Subject ' num2str(index) ' CT Mean Curvature'])
    colormap(cm)
    
    % MNI
    load(fullfile(folderCoords,['subj' num2str(subStruct.subjectNum(index)) '_trode_coords_MNIandTal.mat']));
    MNIcoords = MNIcoords(1:64,:);
    subStruct.MNIlocs{index} = MNIcoords;
    
    load('MNI_cortex_both_hires.mat')
    [Center,Radius] = sphereFit(cortex.vertices);
    
    % [Center,Radius] = sphereFit(MNIcoords);
    % figure out center of sphere
    
    [x,y,z] = sphere;
    x = Radius*x  + Center(1);
    y = Radius*y + Center(2);
    z = Radius*z + Center(3);
    figure(ctMNIFig);
    subplot(2,1,2)
    s = surf(x,y,z);
    %set(s,'EdgeColor','none');
    set(s,'FaceAlpha',0.25);
    set(s,'FaceColor',[0.5 0.5 0.5]);
    hold on
    locs = MNIcoords(1:64,:);
    
    % take labeling from plot dots direct
    scatter3(locs(:,1),locs(:,2),locs(:,3),[100],[1 0 0],'filled');
    %
    gridSize = 64;
    trodeLabels = [1:gridSize];
    for chan = 1:gridSize
        txt = num2str(trodeLabels(chan));
        t = text(locs(chan,1),locs(chan,2),locs(chan,3),txt,'FontSize',10,'HorizontalAlignment','center','VerticalAlignment','middle');
        set(t,'clipping','on');
    end
    title(['MNI Coords - Subject ' num2str(index)])
    
    [az,el,r]  = cart2sph(MNIcoords(:,1) - Center(1),MNIcoords(:,2)-Center(2),MNIcoords(:,3)-Center(3));
    subStruct.MNIlocsSpherical{index}(:,1) = az;
    subStruct.MNIlocsSpherical{index}(:,2) = el;
    subStruct.MNIlocsSpherical{index}(:,3) = r;
    
    gridSize = [8,8];
    [X,Y] = meshgrid(1:gridSize(1),1:gridSize(2));
    X = X(:);
    Y = Y(:);
    DT = delaunayTriangulation(X,Y);
    TR = triangulation(DT.ConnectivityList,locs(:,1),locs(:,2),locs(:,3));
    
    [GC MC]= curvatures(locs(:,1),locs(:,2),locs(:,3),DT.ConnectivityList);
    subStruct.MNI_GC{index} = GC;
    subStruct.MNI_MC{index} = MC;
    figure
    set(gcf,'position',[378.3333 123.6667 664.6667 1.2047e+03])
    subplot(2,1,1)
    trisurf(TR,GC);
    caxis([-max(abs(GC)) max(abs(GC))])
    colorbar()
    title(['Subject ' num2str(index) ' MNI Gaussian Curvature'])
    
    subplot(2,1,2)
    trisurf(TR,MC);
    colorbar()
    caxis([-max(abs(MC)) max(abs(MC))])
    title(['Subject ' num2str(index) ' MNI Mean Curvature'])
    colormap(cm)
    
    
    % determine whether to use MNI or CT for further calculations
    if ~useMNI
        subStruct.locs{index} = subStruct.CTlocs{index};
        subStruct.locsSpherical{index}(:,1) = subStruct.CTlocsSpherical{index}(:,1);
        subStruct.locsSpherical{index}(:,2) = subStruct.CTlocsSpherical{index}(:,2);
        subStruct.locsSpherical{index}(:,3) = subStruct.CTlocsSpherical{index}(:,3);
    else
        subStruct.locs{index} = subStruct.MNIlocs{index};
        subStruct.locsSpherical{index}(:,1) = subStruct.MNIlocsSpherical{index}(:,1);
        subStruct.locsSpherical{index}(:,2) = subStruct.MNIlocsSpherical{index}(:,2);
        subStruct.locsSpherical{index}(:,3) = subStruct.MNIlocsSpherical{index}(:,3);
        
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % one layer theory fitlm
    
    %  subStruct.oneLayerVals{index} = compute_1layer_theory_coords(subStruct.locs{index},subStruct.stimChans(index,:));
    clearvars AllTrodes MNIcoords
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subStruct.dataSelect = cell2mat(subStruct.meanData);
subStruct.gridData = nan(15,15,numIndices);

end

