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
zSliceVec = unique(blockGeo(:,3));
zSliceVec = 100;
for zSliceInt = zSliceVec'
    zSliceInt;
    zIndex = blockGeo(:,3)==zSliceInt;
    scatter(blockGeo(zIndex,1),blockGeo(zIndex,2),[],blockV(zIndex),'filled')
end

%%
centerB = [0 0 100];
cutOffLow = 90;
cutOffHigh = 100;
blockIndex = (blockGeo(:,3)<=cutOffHigh & blockGeo(:,3)>=cutOffLow);
geoB = blockGeo(blockIndex,:);
vB = blockV(blockIndex);
figure
scatter3(geoB(:,1),geoB(:,2),geoB(:,3),25,log(vB),'filled')
%% define sample points of interest for x y grid
[gridX,gridY] = meshgrid([-35:10:35],[-40:10:30]);
pointsGrid = [gridX(:) gridY(:)];
pointsGrid(:,3) = repmat(100,length(pointsGrid),1);
figure
scatter3(blockGeo(:,1),blockGeo(:,2),blockGeo(:,3),25,(blockV),'filled')
colorbar()
title('Block Linear Voltage')
hold on
scatter3(pointsGrid(:,1),pointsGrid(:,2),pointsGrid(:,3),50,'k','filled')

%% define anonymous functions to allow for conversion to mercator, and subsequent rotation
vRot = @(v,theta,k)(v*cos(theta) + cross(k,v)*sin(theta) + k*(dot(k,v))*(1-cos(theta)));
long = @(x,R)(x/R);
lat = @(y,R)(2.*atan(exp(y./R)) - pi/2);
invX = @(R,lat,long)(R.*cos(lat).*cos(long));
invY = @(R,lat,long)(R.*cos(lat).*sin(long));
invZ = @(R,lat,long)(R.*sin(lat));

%% convert x y grid points to mercator, and then rotate to be on top of the sphere
R = 60;
unitVecRotate = [0 1 0];
rotateAngle = -pi/2;
longitude = long(pointsGrid(:,1),R);
latitude = lat(pointsGrid(:,2),R);

xOrig = invX(R,longitude,latitude);
yOrig = invY(R,longitude,latitude);
zOrig = invZ(R,longitude,latitude);

vecOrig = [xOrig,yOrig,zOrig];

for index = 1:size(vecOrig,1)
    vecNew(index,:) = vRot(vecOrig(index,:),rotateAngle,unitVecRotate);
end

figure
scatter3(xOrig,yOrig,zOrig)
hold on
scatter3(vecNew(:,1),vecNew(:,2),vecNew(:,3))

figure
scatter3(sphereGeo1_1(:,1),sphereGeo1_1(:,2),sphereGeo1_1(:,3),25,sphereV1_1,'filled');
hold on
scatter3(vecNew(:,1),vecNew(:,2),vecNew(:,3),50,'k','filled')

figure
scatter3(sphereGeo1(:,1),sphereGeo1(:,2),sphereGeo1(:,3),25,sphereV1,'filled');
hold on
scatter3(vecNew(:,1),vecNew(:,2),vecNew(:,3),50,'k','filled')

%% scattered interpolation to get idea of voltage values at arbitrary points

electrodeCenter(:,1) = [-5,0,100];
electrodeCenter(:,2) = [5,0,100];
blockDistances(:,1) = vecnorm((blockGeo - repmat(electrodeCenter(:,1)',length(blockGeo(:,1)),1)),2,2);
blockDistances(:,2) = vecnorm((blockGeo - repmat(electrodeCenter(:,2)',length(blockGeo(:,1)),1)),2,2);

blockSubsetIndices = blockDistances(:,1) > 9 & blockDistances(:,2) > 9;

figure
scatter3(blockGeo(blockSubsetIndices,1),blockGeo(blockSubsetIndices,2),blockGeo(blockSubsetIndices,3),[],blockV(blockSubsetIndices),'filled')


%%
Fblock = scatteredInterpolant(blockGeo(blockSubsetIndices,1),blockGeo(blockSubsetIndices,2),blockGeo(blockSubsetIndices,3),blockV(blockSubsetIndices));
Fsphere1 = scatteredInterpolant(sphereGeo2(:,1),sphereGeo2(:,2),sphereGeo2(:,3),sphereV2);
%Fblock.Method = 'nearest';
%Fsphere1.Method = 'nearest';
blockValuesInt = Fblock(pointsGrid(:,1),pointsGrid(:,2),pointsGrid(:,3));
sphereValuesInt = Fsphere1(vecNew(:,1),vecNew(:,2),vecNew(:,3));
%%


figure
subplot(1,2,1)
scatter3(pointsGrid(:,1),pointsGrid(:,2),pointsGrid(:,3),25,log(blockValuesInt),'filled');
subplot(1,2,2)
scatter3(vecNew(:,1),vecNew(:,2),vecNew(:,3),25,log(sphereValuesInt),'filled');

figure
subplot(1,2,1)
scatter3(blockGeo(:,1),blockGeo(:,2),blockGeo(:,3),25,blockV,'filled')
hold on
scatter3(pointsGrid(:,1),pointsGrid(:,2),pointsGrid(:,3),50,blockValuesInt,'filled','MarkerEdgeColor',[0 0 0]);
subplot(1,2,2)
scatter3(sphereGeo1_1(:,1),sphereGeo1_1(:,2),sphereGeo1_1(:,3),25,sphereV1_1,'filled');
hold on
scatter3(vecNew(:,1),vecNew(:,2),vecNew(:,3),50,sphereValuesInt,'filled','MarkerEdgeColor',[0 0 0]);

%%
bins = 10*(repmat([1:8],2,1)+[0;1])';
binCenter = mean(bins,2);
rhoA = 1;
i0 = 1e-3;
%%
stimChans = [29 37];
centerSpace = [0,0,100];
distances = vecnorm((pointsGrid-repmat(centerSpace,length(pointsGrid(:,1)),1)),2,2);

blockValuesInt(stimChans) = nan;
l1 = compute_1layer_theory_coords(pointsGrid,stimChans);
scaleA=(i0*rhoA)/(2*pi);
l1 = scaleA*l1;

[rhoAoutput,MSE,subjectResiduals,offset,bestVals] = distance_selection_MSE_bins_fitlm(blockValuesInt,l1,bins,distances);

tempStruct = struct;

tempStruct.bestVals = bestVals;
tempStruct.MSE = MSE;
tempStruct.rhoAcalc = rhoAoutput;
tempStruct.offset = offset;
% bin
fprintf(['rhoA = ' num2str(rhoAoutput) ' offset = ' num2str(offset) ' \n ']);

% global
intercept = false;
tempStruct = struct;

% use MSE
if ~intercept
    dlm=fitlm(l1,blockValuesInt,'intercept',false);
    tempStruct.rhoAcalc=dlm.Coefficients{1,1};
    tempStruct.offset = 0;
else
    dlm=fitlm(l1,blockValuesInt);
    tempStruct.rhoAcalc=dlm.Coefficients{2,1};
    tempStruct.offset = dlm.Coefficients{1,1};
end
tempStruct.MSE = dlm.RMSE;
tempStruct.bestVals = dlm.Fitted;


fitStruct.calc{index} = tempStruct;
fprintf([ ' rhoA = ' num2str(tempStruct.rhoAcalc) ' offset = ' num2str(tempStruct.offset) ' \n ']);



%%
stimChans = [37 29];

centerSpace = [0,0,60];
distances = vecnorm((vecNew-repmat(centerSpace,length(vecNew(:,1)),1)),2,2);

sphereValuesInt(stimChans) = nan;

l1 = compute_1layer_theory_coords_spherical(vecNew,stimChans);
scaleA=(i0*rhoA)/(4*pi);
l1 = scaleA*l1;

[rhoAoutput,MSE,subjectResiduals,offset,bestVals] = distance_selection_MSE_bins_fitlm(sphereValuesInt,l1,bins,distances);

tempStruct = struct;

tempStruct.bestVals = bestVals;
tempStruct.MSE = MSE;
tempStruct.rhoAcalc = rhoAoutput;
tempStruct.offset = offset;
% bin
fprintf(['rhoA = ' num2str(rhoAoutput) ' offset = ' num2str(offset) ' \n ']);

% global


% global
intercept = true;
tempStruct = struct;

% use MSE
if ~intercept
    dlm=fitlm(l1,sphereValuesInt,'intercept',false);
    tempStruct.rhoAcalc=dlm.Coefficients{1,1};
    tempStruct.offset = 0;
else
    dlm=fitlm(l1,sphereValuesInt);
    tempStruct.rhoAcalc=dlm.Coefficients{2,1};
    tempStruct.offset = dlm.Coefficients{1,1};
end
tempStruct.MSE = dlm.RMSE;
tempStruct.bestVals = dlm.Fitted;



fitStruct.calc{index} = tempStruct;
fprintf([ ' rhoA = ' num2str(tempStruct.rhoAcalc) ' offset = ' num2str(tempStruct.offset) ' \n ']);

