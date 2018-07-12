E=symexp(1:10,3:11);
figure;imagesc(E)

T=symthy2(1:10,3:11);
figure;imagesc(T)

% set stim electrodes to zero

figure;imagesc(T)
figure;imagesc(E)
figure;imagesc(E./T)