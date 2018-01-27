function [yfit,P] = linearModelFit(measured,theory)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

P=polyfit(measured(~isnan(theory)),theory(~isnan(theory)),1);
yfit=P(1)*theory(~isnan(theory))+P(2);

end

