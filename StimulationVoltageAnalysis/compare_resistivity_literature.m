
davidrhos=[.865 .862 .99 .866 1.001 1.252 .793];
stephenrhos=[.8 .75 1. .98 .69 .76 .68];
larryrhos=[0.8600 0.9000 1.3800 0.8800 1.1400 0.7200 0.8100];

gray = [
3.85
3.62 
2.2 
3.0  
3.5 
2.3 
1.92  
1.45   
2.25  
4.18  
3.92  
5.13 
4.65 
];

white = [
5.88 
7.94 
0.88 
7.69
7.0 
2.13
12.5
3.33   
2.56   
5.26  
3.77  
7.80  
0.83  
];

csf = [
0.56 
0.64 
0.61 
0.56 
0.65 
0.60  
0.48  
0.57  
0.56 
];

figure;semilogy(davidrhos)
hold on;semilogy(larryrhos,'r')
hold on;semilogy(stephenrhos,'k')

a = hline(gray,'g')
b = hline(white,'r')
c = hline(csf,'b')

legend('david rhos','larry rhos','stephen rhos','gray matter','white matter','csf')