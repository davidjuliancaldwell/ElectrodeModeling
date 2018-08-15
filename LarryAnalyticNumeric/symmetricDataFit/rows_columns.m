
figure;plot(ch1(:,2))
figure;plot(ch1(:,3))
figure;plot(ch2(:,2))
figure;plot(ch2(:,3))
figure;histfit(ch1(:,2))
figure;histfit(ch1(:,3))
figure;histfit(ch2(:,2))
figure;histfit(ch2(:,3))
figure;subplot(2,4,1);plot(ch1(:,2));hold on
subplot(2,4,2);plot(ch1(:,3));hold on
subplot(2,4,3);plot(ch2(:,2));hold on
subplot(2,4,4);plot(ch2(:,3));hold on
subplot(2,4,5);histfit(ch1(:,2));hold on
subplot(2,4,6);histfit(ch1(:,3));hold on
subplot(2,4,7);histfit(ch2(:,2));hold on
subplot(2,4,8);histfit(ch2(:,3));hold on
figure;subplot(2,4,1);plot(ch1(:,2)./ch2(:,2));hold on
subplot(2,4,2);plot(ch1(:,3)./ch2(:,2));hold on
subplot(2,4,3);plot(ch1(:,2)./ch2(:,3));hold on
subplot(2,4,4);plot(ch1(:,3)./ch2(:,3));hold on
subplot(2,4,5);histfit(ch1(:,2)./ch2(:,2));hold on
subplot(2,4,6);histfit(ch1(:,2)./ch2(:,2));hold on
subplot(2,4,7);histfit(ch2(:,3)./ch2(:,3));hold on
subplot(2,4,8);histfit(ch2(:,3)./ch2(:,3));hold on
figure;subplot(2,4,1);plot(ch1(:,2)./ch2(:,2));hold on
subplot(2,4,2);plot(ch1(:,3)./ch2(:,2));hold on
subplot(2,4,3);plot(ch1(:,2)./ch2(:,3));hold on
subplot(2,4,4);plot(ch1(:,3)./ch2(:,3));hold on
subplot(2,4,5);histfit(ch1(:,2)./ch2(:,2));hold on
subplot(2,4,6);histfit(ch1(:,3)./ch2(:,2));hold on
subplot(2,4,7);histfit(ch1(:,2)./ch2(:,3));hold on
subplot(2,4,8);histfit(ch1(:,3)./ch2(:,3));hold on
figure;subplot(3,1,1);plot(ch1(:,2),ch1(:,3));hold on
subplot(3,1,2);plot(ch1(:,2),ch2(:,2));hold on
subplot(3,1,3);plot(ch1(:,2),ch2(:,3));hold on
meanch1=0.5*(ch1(:,2)+ch1(:,3));
meanch2=0.5*(ch2(:,2)+ch2(:,3));
figure;subplot(4,1,1);plot(meanch1,ch1(:,2));hold on
subplot(4,1,2);plot(meanch1,ch1(:,3));hold on
subplot(4,1,3);plot(meanch1,ch2(:,2));hold on
subplot(4,1,4);plot(meanch1,ch2(:,3));hold on
figure;subplot(1,4,1);plot(meanch1,ch1(:,2));hold on
subplot(1,4,2);plot(meanch1,ch1(:,3));hold on
subplot(1,4,3);plot(meanch1,ch2(:,2));hold on
subplot(1,4,4);plot(meanch1,ch2(:,3));hold on
figure;subplot(1,4,1);plot(meanch2,ch1(:,2));hold on
subplot(1,4,2);plot(meanch2,ch1(:,3));hold on
subplot(1,4,3);plot(meanch2,ch2(:,2));hold on
subplot(1,4,4);plot(meanch2,ch2(:,3));hold on
figure;histfit(ch1(:,2)./ch2(:,2));hold on
figure;histfit(ch1(:,3)./ch2(:,2));hold on
figure;histfit(ch1(:,2)./ch2(:,3));hold on
figure;histfit(ch1(:,3)./ch2(:,3));hold on
figure;subplot(1,4,1);plot(meanch2,ch1(:,2));hold on
subplot(1,4,2);plot(meanch2,ch1(:,3));hold on
subplot(1,4,3);plot(meanch2,ch2(:,2));hold on
subplot(1,4,4);plot(meanch2,ch2(:,3));hold on
range=[1:100];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[101:200];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[201:300];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[30:400];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[301:400];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[401:500];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[501:600];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[601:700];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[701:800];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[801:900];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[901:1000];figure;subplot(2,4,1);plot(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,2);plot(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,3);plot(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,4);plot(ch1(range,3)./ch2(range,3));hold on
subplot(2,4,5);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(2,4,6);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(2,4,7);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(2,4,8);histfit(ch1(range,3)./ch2(range,3));hold on
range=[1:200];figure
subplot(3,4,1);plot(ch1(range,2));hold on
subplot(3,4,2);plot(ch1(range,3));hold on
subplot(3,4,3);plot(ch2(range,2));hold on
subplot(3,4,4);plot(ch2(range,3));hold on
subplot(3,4,5);plot(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,6);plot(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,7);plot(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,8);plot(ch1(range,3)./ch2(range,3));hold on
subplot(3,4,9);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,10);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,11);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,12);histfit(ch1(range,3)./ch2(range,3));hold on
range=[201:400];figure
subplot(3,4,1);plot(ch1(range,2));hold on
subplot(3,4,2);plot(ch1(range,3));hold on
subplot(3,4,3);plot(ch2(range,2));hold on
subplot(3,4,4);plot(ch2(range,3));hold on
subplot(3,4,5);plot(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,6);plot(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,7);plot(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,8);plot(ch1(range,3)./ch2(range,3));hold on
subplot(3,4,9);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,10);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,11);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,12);histfit(ch1(range,3)./ch2(range,3));hold on
range=[401:600];figure
subplot(3,4,1);plot(ch1(range,2));hold on
subplot(3,4,2);plot(ch1(range,3));hold on
subplot(3,4,3);plot(ch2(range,2));hold on
subplot(3,4,4);plot(ch2(range,3));hold on
subplot(3,4,5);plot(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,6);plot(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,7);plot(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,8);plot(ch1(range,3)./ch2(range,3));hold on
subplot(3,4,9);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,10);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,11);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,12);histfit(ch1(range,3)./ch2(range,3));hold on
range=[601:800];figure
subplot(3,4,1);plot(ch1(range,2));hold on
subplot(3,4,2);plot(ch1(range,3));hold on
subplot(3,4,3);plot(ch2(range,2));hold on
subplot(3,4,4);plot(ch2(range,3));hold on
subplot(3,4,5);plot(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,6);plot(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,7);plot(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,8);plot(ch1(range,3)./ch2(range,3));hold on
subplot(3,4,9);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,10);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,11);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,12);histfit(ch1(range,3)./ch2(range,3));hold on
range=[801:1000];figure
subplot(3,4,1);plot(ch1(range,2));hold on
subplot(3,4,2);plot(ch1(range,3));hold on
subplot(3,4,3);plot(ch2(range,2));hold on
subplot(3,4,4);plot(ch2(range,3));hold on
subplot(3,4,5);plot(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,6);plot(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,7);plot(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,8);plot(ch1(range,3)./ch2(range,3));hold on
subplot(3,4,9);histfit(ch1(range,2)./ch2(range,2));hold on
subplot(3,4,10);histfit(ch1(range,3)./ch2(range,2));hold on
subplot(3,4,11);histfit(ch1(range,2)./ch2(range,3));hold on
subplot(3,4,12);histfit(ch1(range,3)./ch2(range,3));hold on
range=[801:1000];
mean(ch1(range,2))
mean(ch1(range,3))
mean(ch2(range,2))
mean(ch2(range,3))
mean(ch1(range,2)./ch2(range,2))
mean(ch1(range,3)./ch2(range,2))
mean(ch1(range,2)./ch2(range,3))
mean(ch1(range,3)./ch2(range,3))
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[1:200];
mean(ch1(range,2))
mean(ch1(range,3))
mean(ch2(range,2))
mean(ch2(range,3))
mean(ch1(range,2)./ch2(range,2))
mean(ch1(range,3)./ch2(range,2))
mean(ch1(range,2)./ch2(range,3))
mean(ch1(range,3)./ch2(range,3))
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[1:200];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[201:400];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[401:600];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[601:800];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[801:1000];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[1:100];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[101:200];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[201:300];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[301:400];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[401:500];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[501:600];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[601:700];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[701:800];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[801:900];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
range=[901:1000];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))
in=[33.3229 33.3231 33.3223 33.3233 33.3237 33.3240 33.3246 33.3245 33.3247 33.3247];
mean(in)
std(in)
figure;plot(in)
range=[1:1000];
100*mean(ch1(range,2)./ch2(range,2))-100
100*mean(ch1(range,3)./ch2(range,2))-100
100*mean(ch1(range,2)./ch2(range,3))-100
100*mean(ch1(range,3)./ch2(range,3))-100
std(ch1(range,2)./ch2(range,2))
std(ch1(range,3)./ch2(range,2))
std(ch1(range,2)./ch2(range,3))
std(ch1(range,3)./ch2(range,3))