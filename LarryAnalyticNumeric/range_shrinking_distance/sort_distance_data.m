function [vals,indices] = sort_distance_data(distances)

[vals,indices] = sort(abs(distances),'descend');

numberNonNaN = numel(indices(~isnan(vals)));

end
