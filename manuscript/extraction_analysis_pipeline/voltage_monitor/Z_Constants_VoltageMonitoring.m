SIDS = {'8adc5c','0a8cf', 'd5cd55', 'c91479', '7dbdec', '9ab7ab', '702d24', 'ecb43e','0b5a2e','3f2113','0a80cf'};

%OUTPUT_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'LarryStimulation', 'figures');
OUTPUT_DIR = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\ECoG_Subjects\Voltage_Monitor';
TouchDir(OUTPUT_DIR);
META_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'LarryStimulation', 'meta');
TouchDir(META_DIR);

%OUTPUT_DIR = char(System.IO.Path.GetFullPath(OUTPUT_DIR)); % modified DJC 7-23-2015 - temporary fix to save figures