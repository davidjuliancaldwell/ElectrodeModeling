function [dataSubset,tSubset] = data_subset(data,t,pre,post)
% 
% data: t x c x r (time x channels x trials) data 
% t: t x 1 vector of times (time in ms)
% pre: time in ms before to extract
% post: time in ms after to extract

selection = (t>=-pre & t<=post);
dataSubset = data(selection,:,:);
tSubset = t(selection);


end