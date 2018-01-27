function [h_loss,huber_all] = huber_loss_electrodeModel(theory,experiment,sigma)

% subtract the two vectors 
resid = theory - experiment';

% build up huber loss for all points
huber_all = (sigma.^2)*(sqrt(1+(resid/sigma).^2)-1);

h_loss = nansum(huber_all(:));

end