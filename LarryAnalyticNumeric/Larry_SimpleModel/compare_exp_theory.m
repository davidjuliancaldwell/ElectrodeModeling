load('m2804.mat')
load('m2318.mat')
load('m2219.mat')
load('m2120.mat')
load('m2012.mat')
load('theory2804.mat')
load('theory2318.mat')
load('theory2219.mat')
load('theory2120.mat')
load('theory2012.mat')

figure;for j=1:10;plot(m2012(j,:));hold on;end
hold on;plot(0.000065*theory2012,'r*');hold on;

figure;for j=1:17;plot(m2120(j,:));hold on;end
hold on;plot(0.000065*theory2120(1:32),'r*')

figure;for j=1:10;plot(m2219(j,:));hold on;end
hold on;plot(0.0000625*theory2219,'r*');

figure;for j=1:10;plot(m2318(j,:));hold on;end
hold on;plot(0.0000525*theory2318,'r*');hold on;

figure;for j=1:10;plot(m2804(j,:));hold on;end
hold on;plot(0.0000625*theory2804,'r*');hold on;