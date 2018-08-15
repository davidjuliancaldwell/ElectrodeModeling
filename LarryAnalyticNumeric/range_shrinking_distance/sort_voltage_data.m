function [vals,indices,numberNonNaN] = sort_voltage_data(data)

[vals,indices] = sort(abs(data));

count = 1;

numberNonNaN = numel(indices(~isnan(vals)));

end
