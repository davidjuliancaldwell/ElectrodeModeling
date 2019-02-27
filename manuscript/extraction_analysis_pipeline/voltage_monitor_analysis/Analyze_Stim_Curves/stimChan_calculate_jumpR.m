function [vJumpAvg,vJumpInd] = stimChan_calculate_jumpR(stimEpoched,fs)
%STIMCHAN_CALCULATE Summary of this function goes here

stimAvg = mean(stimEpoched,2);
figure
plot(stimAvg,'-o')

diffStim = [0; diff(stimAvg)];
hold on
plot(diffStim,'-o')

[~,maxi] = max(diffStim);

jumps = stimAvg(maxi-1:maxi);
% figure
%plot(jumps,'o')

tVec = (1:length(jumps))'/fs;

[fitLin,gof,object] = fit(tVec,jumps,'poly1');

figure
plot(fitLin)
hold on
plot(tVec,jumps,'o')

vJumpAvg = fitLin(tVec(end))-fitLin(tVec(1));

vJumpInd = [];
for ii = 1:size(stimEpoched,2)
    jumps = stimEpoched(maxi-1:maxi,ii);
    
    [fitLin,gof,object] = fit(tVec,jumps,'poly1');
    vJumpTemp = fitLin(tVec(end))-fitLin(tVec(1));
    
    vJumpInd = [vJumpInd vJumpTemp];
end

end

