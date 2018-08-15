% DJC - 1/10/2018
% script to plot the monitored stimulation voltage from the 20f8a3 1.2 ms
% pulse experiments
load('20f8a3_stimOutput.mat')

%%
pair_vec = {'pair_20_12','pair_21_20','pair_22_19','pair_23_18','pair_28_4'};
% 21 20 pair
figure
i = 1;
for pair = pair_vec
    subplot(2,3,i)
    pair = char(pair);
    plot(eval(strcat('dataStruct.',pair,'.time_vec')),mean(eval(strcat('dataStruct.',pair,'.stim_data')),2),'linewidth',2);
    
    pair_inds = strsplit(pair,'_');
    
    %pair_title = strrep(pair,'_','\_');
    title(['Electrode Pair ' pair_inds{2} ' ' pair_inds{3}])
    %title([pair_title ' Monitored Output Voltage for Current = ' num2str(eval(strcat('dataStruct.',pair,'.stim_current'))) ' uA'])
    i = i + 1;
    xlim([-0.2 4])
    ylim([-2.5 2.5])
end
xlabel('time (ms)');
ylabel('Voltage (V)');
