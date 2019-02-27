function [outputArg1,outputArg2] = stimChan_calculate(stimEpoched,fs)
%STIMCHAN_CALCULATE Summary of this function goes here

stimAvg = mean(stimEpoched,2);
figure
plot(stimAvg,'-o')

diffStim = [0; diff(stimAvg)];
hold on
plot(diffStim,'-o')

[~,maxi] = max(diffStim);

rsquare_mat = [];

iVec = 4:10;


for i = iVec
    jumps = stimAvg(maxi+2:maxi+i);
   % figure
    %plot(jumps,'o')
    
    tVec = (1:length(jumps))'/fs;
    
    [fit_lin,gof,object] = fit(tVec,jumps,'poly1');
    
    figure
    plot(fit_lin)
    hold on
    plot(tVec,jumps,'o')
    rsquare_mat = [rsquare_mat gof.rsquare];
end

[~,maxr] = max(rsquare_mat);
bestInds = iVec(maxr);
jumps = stimAvg(maxi+1:maxi+bestInds);
tVec = (1:length(jumps))'/fs;

[fit_lin,gof,object] = fit(tVec,jumps,'poly1');

num_pts = bestInds-1
fit_lin
gof
end

