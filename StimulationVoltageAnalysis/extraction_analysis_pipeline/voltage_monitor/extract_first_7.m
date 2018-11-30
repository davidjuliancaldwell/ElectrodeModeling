close all;clear all;clc

Z_Constants_VoltageMonitoring
SUB_DIR = fullfile(myGetenv('subject_dir'));
%%
for i = 1:length(SIDS)
    sid = SIDS{i};
    switch sid
        case '8adc5c'
            tp = strcat(SUB_DIR,'\8adc5c\data\D6\8adc5c_BetaTriggeredStim');
            block = 'Block-67';

        case '9ab7ab'
            tp = strcat(SUB_DIR,'\9ab7ab\data\d7\9ab7ab_BetaTriggeredStim');
            block = 'BetaPhase-3';
        case 'ecb43e'
            tp = strcat(SUB_DIR,'\ecb43e\data\d7\BetaStim');
            block = 'BetaPhase-3';
            
            
        case 'd5cd55'
            tp = strcat(SUB_DIR,'\d5cd55\data\D8\d5cd55_BetaTriggeredStim');
            block = 'Block-49';
            stims = [54 62];
        case 'c91479'
            tp = strcat(SUB_DIR,'\c91479\data\d7\c91479_BetaTriggeredStim');
            block = 'BetaPhase-14';
            stims = [55 56];
            
        case '7dbdec'
            tp = strcat(SUB_DIR,'\7dbdec\data\d7\7dbdec_BetaTriggeredStim');
            block = 'BetaPhase-17';
            stims = [11 12];
        case '702d24'
            tp = strcat(SUB_DIR,'\702d24\data\d7\702d24_BetaStim');
            block = 'BetaPhase-4';
            stims = [13 14];
        case '0b5a2e' % added DJC 7-23-2015
            tp = strcat(SUB_DIR,'\0b5a2e\data\d8\0b5a2e_BetaStim\0b5a2e_BetaStim');
            block = 'BetaPhase-2';
            stims = [22 30];
     
        case '0a8cf'
            tp = strcat(SUB_DIR,'\0a80cf\data\d10\0a80cf_BetaStim\0a80cf_BetaStim');
            block = 'BetaPhase-4';
                        stims = [27 28];

        case '3f2113'
                       tp =  strcat(SUB_DIR,'\',sid,'\data\data\d6\BetaStim\BetaStim');
            block = 'BetaPhase-5';
            stims = [31 32];
    end
    
    tank = TTank;
    tank.openTank(tp);
    tank.selectBlock(block);
    [smon, info] = tank.readWaveEvent('SMon', 2);
    stim = tank.readWaveEvent('SMon', 4)';
    
    Stim.data = stim;
    Sing.data = smon;
    Stim.info.SamplingRateHz = info.SamplingRateHz;
    Sing.info.SamplingRateHz = info.SamplingRateHz;
    
    save(fullfile(OUTPUT_DIR,[sid '_stimMonitor.mat']),'-v7.3','Sing','Stim')
    
    close all
    clearvars -except SIDS i SUB_DIR OUTPUT_DIR
    
end