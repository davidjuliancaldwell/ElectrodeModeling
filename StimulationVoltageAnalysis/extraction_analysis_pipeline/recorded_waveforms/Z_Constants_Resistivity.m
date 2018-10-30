%SIDS = {'8adc5c', 'd5cd55', 'c91479', '7dbdec', '9ab7ab', '702d24', 'ecb43e','0b5a2e','20f8a3'};
SIDS = {'0b5a2e','702d24','7dbdec','9ab7ab','c91479','d5cd55','ecb43e','0a80cf','3ada8b','a7a181'};

%OUTPUT_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'Resistivity', 'figures');
%OUTPUT_DIR = 'G:\My Drive\GRIDLabDavidShared\Stimulation_Modeling_paper\Figures';
OUTPUT_DIR = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\Plots\dataPlots';

TouchDir(OUTPUT_DIR);
META_DIR = fullfile(myGetenv('OUTPUT_DIR'), 'Resistivity', 'meta');
TouchDir(META_DIR);
SUBJECT_DIR = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\ECoG_Subjects\Raw_Data';
FIVE_SUBJECT_DIR = 'G:\My Drive\GRIDLabDavidShared\20f8a3\StimulationSpacingChunked';
DBS_DIR = 'G:\My Drive\GRIDLabDavidShared\DBS';
SUB_DIR = fullfile(myGetenv('dbs_subject_dir'));

DBS_SIDS = {'5e0cf','b26b7','3972f','46c2a','9f852','71c6c','8e907'};
