DATA_DIR = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\sciRun';

%%
%If you want to plot the potential, use Geometry.node from file X_mesh.mat
% and V from file X_result.mat.
load(fullfile(DATA_DIR,'block','block_mesh.mat'));
load(fullfile(DATA_DIR,'block','block_result.mat'));

blockGeo = Geometry.node;
blockV = V;
%%
figure
subplot(2,1,1)
histogram(V);
set(gca,'YScale','log')
subplot(2,1,2)
histogram((abs(V)));
set(gca,'YScale','log')
set(gca,'XScale','log')

%%

figure
scatter3(blockGeo(:,1),blockGeo(:,2),blockGeo(:,3),25,(blockV),'filled')
colorbar()
title('Block Linear Voltage')
figure
scatter3(blockGeo(:,1),blockGeo(:,2),blockGeo(:,3),25,log(abs(blockV)),'filled')
colorbar()
title('Block Log Voltage')

%%
load(fullfile(DATA_DIR,'sphere','sphere1_mesh.mat'));
load(fullfile(DATA_DIR,'sphere','sphere1_result.mat'));

sphereGeo1_1 = Geometry.node;
sphereV1_1 = V;

%%
load(fullfile(DATA_DIR,'sphere','sphere2_mesh.mat'));
load(fullfile(DATA_DIR,'sphere','sphere2_1l_result.mat'));

sphereGeo1 = Geometry.node;
sphereV1 = V;
%%
load(fullfile(DATA_DIR,'sphere','sphere2_mesh.mat'));
load(fullfile(DATA_DIR,'sphere','sphere2_result.mat'));

sphereGeo2 = Geometry.node;
sphereV2 = V;

%%
max(blockV)
max(sphereV1_1)
max(sphereV1)
max(sphereV2)

distances1_1 = vecnorm(sphereGeo1_1,2,2);
distances1 = vecnorm(sphereGeo1,2,2);
distances2 = vecnorm(sphereGeo2,2,2);

max(sphereV1_1(distances1_1<=59))
max(sphereV1(distances1<=59))
max(sphereV2(distances2<=59))

%%
figure
scatter3(sphereGeo1(:,1),sphereGeo1(:,2),sphereGeo1(:,3),25,sphereV1,'filled')

figure
scatter3(sphereGeo2(:,1),sphereGeo2(:,2),sphereGeo2(:,3),25,sphereV2,'filled')
%%

minC = min([sphereV1;sphereV2]);
maxC = max([sphereV1;sphereV2]);
figure
ax(1) =subplot(1,2,1);
 scatter3(sphereGeo1(:,1),sphereGeo1(:,2),sphereGeo1(:,3),25,sphereV1,'filled');
title('2 layer with 1 conductivity')
caxis([minC,maxC])

ax(2) = subplot(1,2,2);
scatter3(sphereGeo2(:,1),sphereGeo2(:,2),sphereGeo2(:,3),25,sphereV2,'filled')
title('2 layer with 2 conductivities')
caxis([minC,maxC])

Link = linkprop(ax,{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim', 'ZLim'});
setappdata(gcf, 'StoreTheLink', Link);
colorbar()

%%

minC = min([sphereV1_1;sphereV1;sphereV2]);
maxC = max([sphereV1_1;sphereV1;sphereV2]);
figure
ax(1) =subplot(1,3,1);
 scatter3(sphereGeo1_1(:,1),sphereGeo1_1(:,2),sphereGeo1_1(:,3),25,sphereV1_1,'filled');
title('1 layer with 1 conductivity')
caxis([minC,maxC])

ax(2) =subplot(1,3,2);
 scatter3(sphereGeo1(:,1),sphereGeo1(:,2),sphereGeo1(:,3),25,sphereV1,'filled');
title('2 layer with 1 conductivity')
caxis([minC,maxC])

ax(3) = subplot(1,3,3);
scatter3(sphereGeo2(:,1),sphereGeo2(:,2),sphereGeo2(:,3),25,sphereV2,'filled')
title('2 layer with 2 conductivities')
caxis([minC,maxC])

Link = linkprop(ax,{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim', 'ZLim'});
setappdata(gcf, 'StoreTheLink', Link);
colorbar()
%%
figure
zSliceInt = 0;
zIndex = blockGeo(:,3)==zSliceInt;
imagesc(blockGeo(zIndex,1),blockGeo(zIndex,2),blockV(zIndex))

%%
% set light scale for visualization
lightScale = 0.8;
figure;
set(gca, 'ZDir','reverse')
p = patch(isosurface(blockGeo(:,1),blockGeo(:,2),blockGeo(:,3),blockV,1.25));
% get normals to the surface - this helps with lighting
isonormals(blockGeo(:,1),blockGeo(:,2),blockGeo(:,3),blockV,p)

% check MATLAB version for compatability
if verLessThan('matlab','8.5')
    set(p,'FaceColor',[0.8 0.8 0.8]);
    set(p,'EdgeColor','none');
else
    p.FaceColor = [0.8 0.8 0.8];
    p.EdgeColor = 'none';
    p.FaceAlpha = 0.7;
end
view(3);
%axis tight
box off
axis off
%%
% daspect should take care of the 1 mm, 1mm, 0.9 mm scales for visualizing
% the x, y, and z
daspect([1 1 0.9])
view(90,90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,-90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);
view(-90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);


%%

%Plot CSF Gray and White matter for LL slices
%x increases from front (anterior) to back (posterior), dx=1 mm
%y increases from top of head (dorsal) to bottom (basal), dy=1 mm
% z increases from left to the right. Z is slice number, dz=0.9 mm
% xy is MR slice, [256x256]
% 4-25-2018 - David J. Caldwell

clear all;clc
load LL_CSF.mat;
load LL_GrayMatter.mat;
load LL_WhiteMatter.mat;

% permute the order of x and y to make plotting easier
colOrder = [3 2 1];
CSF(:,colOrder) = flipud(CSF);
GrayMatter(:,colOrder) = flipud(GrayMatter);
WhiteMatter(:,colOrder) = flipud(WhiteMatter);

%%%%% first we will reshape it
jVec = [34:158]; % this iterates through the slices
x = [1:256];
y= [1:256];
z = [1:256];

% make a meshgrid to visualize the cube
[X,Y,Z] = meshgrid(x,y,z);

% make individual  matrices
CSFReshape = zeros(size(X));
GrayMatterReshape = zeros(size(Y));
WhiteMatterReshape = zeros(size(Z));
BrainReshape = zeros(size(X));

% iterate through the j vector
for j=jVec
    
    % CSF
    % take a slice
    SliceNumber=j;
    
    % take z dimension of CSF
    J1=CSF(:,3);
    J2=find(J1==SliceNumber);
    CSFSlice = CSF(J2,:);
    
    %convert to linear indices for indexing
    linearInd = sub2ind([256,256,256],CSFSlice(:,1),CSFSlice(:,2),CSFSlice(:,3));
    CSFReshape(linearInd) = 1;
    % assign CSF values of 1
    BrainReshape(linearInd) = 1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % GRAY MATTER
    J1=GrayMatter(:,3);
    J2=find(J1==SliceNumber);
    GrayMatterSlice = (GrayMatter(J2,:));
    linearInd = sub2ind([256,256,256],GrayMatterSlice(:,1),GrayMatterSlice(:,2),GrayMatterSlice(:,3));
    
    GrayMatterReshape(linearInd) = 1;
    BrainReshape(linearInd) = 3;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % WHITE MATTER
    J1=WhiteMatter(:,3);
    J2=find(J1==SliceNumber);
    WhiteMatterSlice = (WhiteMatter(J2,:));
    linearInd = sub2ind([256,256,256],WhiteMatterSlice(:,1),WhiteMatterSlice(:,2),WhiteMatterSlice(:,3));
    
    WhiteMatterReshape(linearInd) = 1;
    BrainReshape(linearInd) = 5;
    
end;

%
%BrainReshape = permute(BrainReshape,[3 1 2]);

%% Now plot the Cortex highlighting either the gray or white or CSF
% Highlight Gray Matter
% set light scale for visualization
lightScale = 0.8;
figure;
set(gca, 'ZDir','reverse')
p = patch(isosurface(X,Y,Z,BrainReshape,1.25));
% get normals to the surface - this helps with lighting
isonormals(x,y,z,BrainReshape,p)

% check MATLAB version for compatability
if verLessThan('matlab','8.5')
    set(p,'FaceColor',[0.8 0.8 0.8]);
    set(p,'EdgeColor','none');
else
    p.FaceColor = [0.8 0.8 0.8];
    p.EdgeColor = 'none';
    p.FaceAlpha = 0.7;
end
view(3);
%axis tight
box off
axis off

% daspect should take care of the 1 mm, 1mm, 0.9 mm scales for visualizing
% the x, y, and z
daspect([1 1 0.9])
view(90,90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,-90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);
view(-90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);

% lighting additions
lighting gouraud
material([.3 .8 .1 10 1]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Highlight White Matter
figure
set(gca, 'ZDir','reverse')
p = patch(isosurface(X,Y,Z,BrainReshape,3));
isonormals(x,y,z,BrainReshape,p)
if verLessThan('matlab','8.5')
    set(p,'FaceColor',[0.8 0.8 0.8]);
    set(p,'EdgeColor','none');
else
    p.FaceColor = [0.8 0.8 0.8];
    p.EdgeColor = 'none';
    p.FaceAlpha = 0.7;
    
end
view(3);
%axis tight
axis off
colormap(gray(50))
box off
axis off
daspect([1 1 0.9])
view(90,90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,-90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);
view(-90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);

lighting gouraud
material([.3 .8 .1 10 1]);


%% Now plot the cortex and a slice through it

% ui box for input
prompt = {'X limit?','Y limit?','Z limit?'};
dlg_title = 'Subvolumes';
num_lines = 1;
defaultans = {'[NaN NaN]','[NaN NaN]','[55 NaN]'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

xLim = str2num(answer{1});
yLim = str2num(answer{2});
zLim = str2num(answer{3});

% get limits of the volume we are interested in
limits = [xLim(1) xLim(2) yLim(1) yLim(2) zLim(1) zLim(2)];

% extract a subset of the volume data
[x, y, z, D] = subvolume(BrainReshape, limits);

% isosurface for the outside of the volume
[fo,vo] = isosurface(x,y,z,D,1.7);

% isocaps for the end caps of the volume
[fe,ve,ce] = isocaps(x,y,z,D,1.7);

figure
set(gca, 'ZDir','reverse')

% draw the outside of the volume
hiso = patch('Faces', fo, 'Vertices', vo);

% draw the end caps of the volume
hcap = patch('Faces', fe, 'Vertices', ve, ...
    'FaceVertexCData', ce);

% check MATLAB version for compatability

if verLessThan('matlab','8.5')
    set(hiso,'FaceColor',[0.7 0.7 0.7]);
    set(hiso,'EdgeColor','none');
    set(hcap,'FaceColor','interp');
    set(hcap,'EdgeColor','none');
else
    hiso.FaceColor = [0.7 0.7 0.7];
    %hiso.FaceAlpha = 0.7;
    hiso.EdgeColor = 'none';
    
    hcap.FaceColor = 'interp';
    hcap.EdgeColor = 'none';
    
end

colormap(gray(50))
box off
axis off
daspect([1 1 0.9])
view(90,90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,-90);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]*.3);
view(90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);
view(-90,0);
l = camlight('headlight');
set(l,'color',[lightScale lightScale lightScale]);

lighting gouraud
material([.3 .8 .1 10 1]);


