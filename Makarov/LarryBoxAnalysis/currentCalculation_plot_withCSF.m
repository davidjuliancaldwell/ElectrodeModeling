function [] = currentCalculation_plot_withCSF(input_struct)

% extract current from structure
current = input_struct.Current;

% calculate the magnitude of the current vector at each point
netCurrent_pt = power((power(current(:,1),2)+power(current(:,2),2)+power(current(:,3),2)),0.5);
total_sum = sum(netCurrent_pt);

% generate profile 
points_total = input_struct.Points;
z_dimension = points_total(:,3)*-1000;

keys = unique(z_dimension)';
%keys = keys(keys>6e-6);

i = 1;
summed_level = zeros(numel(keys),1);
for ind = keys
   summed_level(i) = (sum(netCurrent_pt(z_dimension==ind))/total_sum);
    
    i = i+1;
end

%plot(keys,summed_level,'linewidth',2)
plot(keys,summed_level,'o','markersize',5)
%xlim([min(keys) max(keys)])
xlim([min(keys) 10])

end