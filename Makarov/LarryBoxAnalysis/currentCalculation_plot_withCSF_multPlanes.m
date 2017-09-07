function [] = currentCalculation_plot_withCSF_multPlanes(input_struct)

% extract current from structure

for ind = 1:3
current = input_struct{ind}.Current;

% calculate the magnitude of the current vector at each point
netCurrent_pt = power((power(current(:,1),2)+power(current(:,2),2)+power(current(:,3),2)),0.5);
total_sum = sum(netCurrent_pt);

% generate profile 
points_total = input_struct{ind}.Points;
z_dimension = points_total(:,3)*-1000;

keys = unique(z_dimension)';
%keys = keys(keys>6e-6);

k = 1;
summed_level = zeros(numel(keys),1);
for ind_inner = keys
   summed_level(k) = (sum(netCurrent_pt(z_dimension==ind_inner))/total_sum);
    
    k = k+1;
end

%plot(keys,summed_level,'linewidth',2)
figure
plot(keys,summed_level,'o','markersize',5)
%xlim([min(keys) max(keys)])
xlim([min(keys) 10])

end

% do the imagesc ones to look @ 2D planes 
for ind = 4:5
   
 current = input_struct{ind}.Current;

% calculate the magnitude of the current vector at each point
netCurrent_pt = power((power(current(:,1),2)+power(current(:,2),2)+power(current(:,3),2)),0.5);
potential_pt = input_struct{ind}.Potential;
total_sum = sum(netCurrent_pt);

% generate profile 
points_total = input_struct{ind}.Points;
x_dimension = points_total(:,1)*-1000;
y_dimension = points_total(:,2)*-1000;

keys_x = unique(x_dimension)';
keys_y = unique(y_dimension)';

dims_x = range(keys_x);
dims_y = range(keys_y); 


[X,Y] = meshgrid(keys_x,keys_y);
data = reshape(netCurrent_pt,[length(keys_x) length(keys_y)]);
figure
mesh(X,Y,data)
figure
contour(X,Y,data)

data = reshape(potential_pt,[length(keys_x) length(keys_y)]);
figure
mesh(X,Y,data)
figure
contour(X,Y,data)

end

end