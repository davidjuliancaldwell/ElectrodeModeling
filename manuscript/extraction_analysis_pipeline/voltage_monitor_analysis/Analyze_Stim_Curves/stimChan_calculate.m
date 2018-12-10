function [outputArg1,outputArg2] = stimChan_calculate(stim1Epoched,fs)
%STIMCHAN_CALCULATE Summary of this function goes here

stim_avg = mean(stim1Epoched,2);
figure
plot(stim_avg,'-o')

diff_stim = [0; diff(stim_avg)];
hold on
plot(diff_stim,'-o')

[~,maxi] = max(diff_stim);

rsquare_mat = [];

i_vec = 4:10;

for i = i_vec
    jumps = stim_avg(maxi+2:maxi+i);
   % figure
    %plot(jumps,'o')
    
    t_vec = (1:length(jumps))'/fs;
    
    [fit_lin,gof,object] = fit(t_vec,jumps,'poly1');
    
    figure
    plot(fit_lin)
    hold on
    plot(t_vec,jumps,'o')
    rsquare_mat = [rsquare_mat gof.rsquare];
end

[~,maxr] = max(rsquare_mat);
best_inds = i_vec(maxr);
jumps = stim_avg(maxi+1:maxi+best_inds);
t_vec = (1:length(jumps))'/fs;

[fit_lin,gof,object] = fit(t_vec,jumps,'poly1');

num_pts = best_inds-1
fit_lin
gof
end

