function [thy1] = compute_1layer_theory_coords(locs,stimChans)

sizeData = size(locs,1);
thy1 = zeros(sizeData,1);

% default scale to 1 because will fitlm later 
scale = 1;

% positive and negative stim channels
jp = stimChans(2);
jm = stimChans(1);

for j=1:sizeData
    dp=norm(locs(j,:)-locs(jp,:));
    dm=norm(locs(j,:)-locs(jm,:));
    thy1(j)=scale*((1000/dp)-(1000/dm));
end

end