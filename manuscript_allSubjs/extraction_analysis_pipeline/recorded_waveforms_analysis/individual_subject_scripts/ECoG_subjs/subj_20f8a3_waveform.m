%% now go through the next 5 spacing
dataStruct = struct('pair_21_20',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_20_12',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_22_19',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_23_18',struct('stim_current',[],'time_vec',[],'stim_data',[])...
    ,'pair_28_4',struct('stim_current',[],'time_vec',[],'stim_data',[]));

% vector to loop through
stimChansVec = [ 20 12;21 20; 22 19; 23 18; 28 4];
currentMatVec = [0.0005 0.0005 0.0005 0.0005 0.0005]' ;
pair_vec = {'pair_20_12','pair_21_20','pair_22_19','pair_23_18','pair_28_4'};
preSamps = 3;
postSamps = 3;
figTotal =  figure('units','normalized','outerposition',[0 0 1 1]);

ii = 1;
jj = 1;
counterIndex = 1;
meanMatAll = zeros(110,2,5,1);
stdMatAll = zeros(110,2,5,1);
numberStimsAll = zeros(5,1,1);
numRows = 2;
numColumns = 3;
stdEveryPoint = {};
extractCellAll = {};
numChansInt = 110;
sid = '20f8a3';

basedir = 'G:\My Drive\GRIDLabDavidShared\resistivityDataSets\ECoG_Subjects\Voltage_Monitor\20f8a3\StimulationSpacingChunked';

for pair = pair_vec
    
    switch(char(pair))
        case 'pair_20_12'
            load(fullfile(basedir,'stim_widePulse_20_12.mat'))
        case 'pair_21_20'
                        load(fullfile(basedir,'stim_widePulse_21_20.mat'))
        case 'pair_22_19'
                        load(fullfile(basedir,'stim_widePulse_22_19.mat'))
        case 'pair_23_18'
                        load(fullfile(basedir,'stim_widePulse_23_18.mat'))
        case 'pair_28_4'
                                    load(fullfile(basedir,'stim_widePulse_28_4.mat'))
    end
    fprintf(['running for pair ' char(pair) '\n']);
    fs = fs_data;
    stimChans = stimChansVec(ii,:);
    ECoGData = dataEpoched;
    ECoGData = ECoGData(:,1:110,:);
    
    [meanMat,stdMat,stdCellEveryPoint,extractCell,numberStims] = voltage_extract_avg(ECoGData,'fs',fs,'preSamps',preSamps,'postSamps',postSamps,'plotIt',0);
    
    [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] =  ECoG_subject_processing(ii,jj,...
        meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
        meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,...
        stimChans,currentMatVec,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex);
    
        [dataSubset,tSubset] = data_subset(ECoGData,t,preExtract,postExtract);
    dataSubsetCell{counterIndex} = dataSubset;
    
    pair_inds = strsplit(char(pair),'_');
    subjectNum(counterIndex) = 10;
    sidCell{counterIndex} = sid;
    ii = ii + 1;
    counterIndex = counterIndex + 1;
    
end

if plotIt
    figure(figTotal)
    legend('first phase','second phase')
    xlabel('electrode')
    ylabel('Voltage (V)')
    SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid ]),'png');
end

[subj_20f8a3_struct] =  convert_mats_to_struct(meanMatAll,stdMatAll,stdEveryPoint,stimChansVec,...
    currentMatVec,numberStimsAll,extractCellAll,sidCell,subjectNum,dataSubsetCell,tSubset);

clearvars meanMatAll stdMatAll numberStimsAll stdEveryPoint stimChans currentMat currentMatVec stimChansVec numberStimsAll extractCellAll sidCell subjectNum sid ii jj counterIndex tSubset dataSubset dataSubsetCell