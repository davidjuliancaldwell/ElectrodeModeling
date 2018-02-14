%SIDS = {'8adc5c', 'd5cd55', 'c91479', '7dbdec', '9ab7ab', '702d24', 'ecb43e','0b5a2e','20f8a3'};
SIDS = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e'};
%OUTPUT_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'Resistivity', 'figures');
OUTPUT_DIR = 'G:\My Drive\GRIDLabDavidShared\Stimulation_Modeling_paper\Figures';
TouchDir(OUTPUT_DIR);
META_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'Resistivity', 'meta');
TouchDir(META_DIR);
SUBJECT_DIR = 'G:\My Drive\GRIDLabDavidShared\SharedForDavidLarryStephen';

%OUTPUT_DIR = char(System.IO.Path.GetFullPath(OUTPUT_DIR)); % modified DJC 7-23-2015 - temporary fix to save figures