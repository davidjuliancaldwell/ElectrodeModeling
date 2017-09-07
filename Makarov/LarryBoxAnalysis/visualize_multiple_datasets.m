% script to show various visualizations on the same graph

[filename,rawpath] = uigetfile('select a beginning file to convert');
cd(rawpath)
D = dir([rawpath, '\*.mat']);
Num = length(D(not([D.isdir])));

files = dir([rawpath,'\*.mat']);

ind = 1;
%stackedData = zeros(480,640,Num); % this is if using entire screen oof caemra 
figure
hold on
for file = files'
    
    load(file.name);
    currentCalculation_plot(current);

end


ylabel('Current Ratio')
xlabel('Depth in mm')

title('Ratio of currents through each layer')
legend({'5 mm spacing','10 mm spacing','20 mm spacing','30 mm spacing','40 mm spacing'})

