function [ratio,total_sum,upper_sum] = currentCalculation(input_struct)

% extract current from structure
current = input_struct.Current;

% calculate the magnitude of the current vector at each point
netCurrent_pt = power((power(current(:,1),2)+power(current(:,2),2)+power(current(:,3),2)),0.5);
total_sum = sum(netCurrent_pt);

% extract points of interest 
points_total = input_struct.Points;
indices = points_total(:,3)>-0;
points_top = points_total(indices,:);

currents_top = netCurrent_pt(indices);
upper_sum = sum(currents_top);

ratio = upper_sum/total_sum;

end