function [vals,indices,numberNonNaN] = sort_voltage_data(data)

[vals,indices] = sort(abs(data),'descend');

numberNonNaN = numel(indices(~isnan(vals)));

end
