%% this is a script to plot a plane of currents, or potentials from simulation output

%current = current{1};

%potential = current{1}.Potentiall;
%input_struct = current{1};
current = input_struct.Current;

% calculate the magnitude of the current vector at each point
netCurrent_pt = power((power(current(:,1),2)+power(current(:,2),2)+power(current(:,3),2)),0.5);
potential_pt = input_struct.Potential;
total_sum = sum(netCurrent_pt);

% generate profile
points_total = input_struct.Points;
y_dimension = points_total(:,2)*1000;
z_dimension = points_total(:,3)*1000;

keys_y = unique(y_dimension)';
keys_z = unique(z_dimension)';

dims_y = range(keys_y);
dims_z = range(keys_z);


[Y,Z] = meshgrid(keys_y,keys_z);
data = reshape(netCurrent_pt,[length(keys_y) length(keys_z)]);
colormap('parula')

% figure
% mesh(X,Y,data)
% title('Magnitude of Current in Space - xy plane')
%
% figure
% contour(X,Y,data)
% title('Magnitude of Current in Space - xy plane')

figure
pcolor(Y,Z,data')
shading interp
colorbar()
title('Magnitude of Current in Space - yz plane')

data = reshape(potential_pt,[length(keys_y) length(keys_z)]);
% figure
% mesh(X,Y,data)
% title('Electric Potential in Space - xy plane')
%
% figure
% contour(X,Y,data)
% title('Electric Potential in Space - xy plane')

figure
pcolor(Y,Z,data')
shading interp
CT=cbrewer('div', 'RdBu', 13);
colormap(CT)
caxis([-max(abs(potential_pt)) max(abs(potential_pt))])
colorbar()
title('Electric Potential in Space - yz plane')