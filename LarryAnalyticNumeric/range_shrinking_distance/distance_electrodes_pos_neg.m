function [distances] = distance_electrodes_pos_neg(electrodes,gridSize)
% function to calculate the distances from a positive and negative
% stimulation electrode
% David.J.Caldwell 8.22.2018

distances = zeros(gridSize(1)*gridSize(2),2);
[elecX,elecY] = ind2sub([gridSize(1),gridSize(2)],electrodes);
[X,Y] = meshgrid(1:gridSize(1),1:gridSize(2));
X = X';
Y = Y';
distances(:,1) = reshape(((elecX(1)-X).^2 + (elecY(1)-Y).^2 ).^0.5, gridSize(1)*gridSize(2),1);
distances(:,2) = reshape(((elecX(2)-X).^2 + (elecY(2)-Y).^2 ).^0.5, gridSize(1)*gridSize(2),1);


end