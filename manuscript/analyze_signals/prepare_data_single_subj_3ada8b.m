%% script to prepare the data for the one layer point theory

function [subStruct] = prepare_data_single_subj_3ada8b(eliminateBadChannels)
load('america')

plotText = 0;
useMNI = 0;
cd(fileparts(which('prepare_data_single_subj_3ada8b')));
locationsDir = pwd;
folderData = fullfile(locationsDir, '..','data');
folderCoords = fullfile(locationsDir,'..','coordinates');

totalData = load(fullfile(folderData,'recorded_waveform_data_3ada8b.mat'));

subStruct = struct;
totalDataInd = fieldnames(totalData)';
disp(['Field named: ' totalDataInd{1} ]);

disp(totalData.(totalDataInd{1}));
subStruct = totalData.(totalDataInd{1});

numIndices = size(subStruct.meanMat,3);

% define fs
diffT = diff(subStruct.t)/1e3;
subStruct.fs =  1/diffT(1);

stimChansVecOnly = subStruct.stimChans;
badTotal = {};
if eliminateBadChannels
%     badTotal{1} = [[stimChansVecOnly{1,:}] 17 18 19];
%     badTotal{2} = [[stimChansVecOnly{2,:}] 23 27 28 29 30 32 44 52 60];
%     badTotal{3} = [[stimChansVecOnly{3,:}] 57];
%     badTotal{4} = [[stimChansVecOnly{4,:}] 2 3 31 57];
%     badTotal{5} = [[stimChansVecOnly{5,:}] 1 49 58 59];
%     badTotal{6} = [[stimChansVecOnly{6,:}] 57:64];
%     badTotal{7} = [[stimChansVecOnly{7,:}] 1 9 10 35 43];
else
    for ii = 1:numIndices
        badTotal{ii} = stimChansVecOnly(ii,:);
    end
end

subStruct.badTotal = badTotal;


%subStruct.stimChansIndices = stimChansIndices;

% loop through trials within structure
for index = 1:numIndices
    
    %subStruct.badChans = [];
    %subStruct.badTotal{index} = [subStruct.stimChans(index,:) subStruct.badChans];
    numChansInterest = 64;
    subStruct.meanData{index} = subStruct.meanMat(1:numChansInterest,1,index);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % get electrode locations CT first and then MNI
    
    % CT
    load(fullfile(folderCoords,['3ada8b_bis_trodes.mat']));
    
    AllTrodes = AllTrodes(1:64,:);
    % [Center,Radius] = sphereFit(AllTrodes);
    highPolyModel = fullfile(folderCoords,['3ada8b_cortex_both_hires.mat']);
    load(highPolyModel);
    
    [Center,Radius] = sphereFit(cortex.vertices);
    % figure out center of sphere
    
    [x,y,z] = sphere;
    x = Radius*x  + Center(1);
    y = Radius*y + Center(2);
    z = Radius*z + Center(3);
    subStruct.rFixed{index} = Radius;
    
    
    ctMNIFig = figure;
    ctMNIFig.Units = "inches";
    ctMNIFig.Position = [1 1 8 3];
    subplot(1,2,1)
    s = surf(x,y,z);
    %set(s,'EdgeColor','none');
    % set(s,'FaceAlpha',0.25);
    set(s,'FaceColor','none');
    hold on
    locs = AllTrodes(1:64,:);
    
    % take labeling from plot dots direct
    scatter3(locs(:,1),locs(:,2),locs(:,3),[100],[1 0 0],'filled');
    %
    gridSize = 64;
    trodeLabels = [1:gridSize];
    
    if plotText
        for chan = 1:gridSize
            txt = num2str(trodeLabels(chan));
            t = text(locs(chan,1),locs(chan,2),locs(chan,3),txt,'FontSize',10,'HorizontalAlignment','center','VerticalAlignment','middle');
            set(t,'clipping','on');
        end
    end
    title(['CT Coords - Subject ' num2str(index)])
    
    AllTrodes = [AllTrodes(:,1) - Center(1) AllTrodes(:,2) - Center(2) AllTrodes(:,3) - Center(3)];
    subStruct.CTlocs{index} = AllTrodes;
    
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
    
    if index == 1
        curveCTFig = figure;
        curveCTFig.Units = "inches";
        curveCTFig.Position = [1 1 8 3];
        subplot(1,2,1)
        trisurf(TR,GC);
        caxis([-max(abs(GC)) max(abs(GC))])
        h = colorbar;
        h.Label.String = '1/mm';
        title(['Subject ' num2str(index) ' CT Gaussian Curvature'])
        %   set(gca,'fontsize',14)
        subplot(1,2,2)
        trisurf(TR,MC);
        colorbar
        caxis([-max(abs(MC)) max(abs(MC))])
        title(['Subject ' num2str(index) ' CT Mean Curvature'])
        colormap(cm)
    end
    %     set(gca,'fontsize',12)
    
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
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % one layer theory fitlm
        
        %  subStruct.oneLayerVals{index} = compute_1layer_theory_coords(subStruct.locs{index},subStruct.stimChans(index,:));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subStruct.dataSelect = cell2mat(subStruct.meanData);
subStruct.gridData = nan(15,15,numIndices);

end

