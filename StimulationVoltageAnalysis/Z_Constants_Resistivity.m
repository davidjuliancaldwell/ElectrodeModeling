%SIDS = {'8adc5c', 'd5cd55', 'c91479', '7dbdec', '9ab7ab', '702d24', 'ecb43e','0b5a2e','20f8a3'};
SIDS = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e','0a80cf'};

stimChans = [22 30;13 14;11 12;59 60;56 55;54 62;56 64; 28 27];
%OUTPUT_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'Resistivity', 'figures');
OUTPUT_DIR = 'G:\My Drive\GRIDLabDavidShared\Stimulation_Modeling_paper\Figures';
TouchDir(OUTPUT_DIR);
META_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'Resistivity', 'meta');
TouchDir(META_DIR);
SUBJECT_DIR = 'G:\My Drive\GRIDLabDavidShared\SharedForDavidLarryStephen';
FIVE_SUBJECT_DIR = 'G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked';
DBS_DIR = 'G:\My Drive\GRIDLabDavidShared\DBS';

DBS_SIDS = {'5e0cf','b26b7'};
