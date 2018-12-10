function [distances] = distance_electrodes_center_coords(electrodes,gridSize)
% function to calculate the distances from the center of a positive
% negative stimulation dipole
% David.J.Caldwell 8.22.2018

distances = zeros(gridSize(1)*gridSize(2));
[elecX,elecY] = ind2sub([gridSize(1),gridSize(2)],electrodes);
[X,Y] = meshgrid(1:gridSize(1),1:gridSize(2));
X = X';
Y = Y';
distances = reshape((((elecX(1)+elecX(2))/2-X).^2 + ((elecY(1)+elecY(2))/2-Y).^2 ).^0.5, gridSize(1)*gridSize(2),1);


end