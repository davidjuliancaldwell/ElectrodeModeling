
trodeLabels = [1:64];
subjid = '3ada8b';
load(fullfile(getSubjDir(subjid), 'trodes.mat'));
clims = [-1 1];

figure

map = [.2 1 0; 1 1 1; 1 0 1];
%map = [0.5 0.5 1; 1 1 1; 1 0.5 0.5];

w = zeros(size(Grid, 1), 1);
clims = [-1 1];
PlotDotsDirect(subjid, Grid, w, determineHemisphereOfCoverage(subjid), clims, 15, map, trodeLabels, true);
