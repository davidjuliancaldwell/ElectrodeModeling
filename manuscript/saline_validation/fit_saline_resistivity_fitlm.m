%% script to fit layered models to saline stimulation
%
% David.J.Caldwell 7.19.2018
close all;clear all;clc
dataDir = 'G:\My Drive\GRIDLabDavidShared\SummerStudents2018\chris_and_sonia\7-18-2018\processedData';
highResist = '2-91ms-cm-solution5';
lowResist = '19-57ms-cm-solution1';

vJumpMat = [];
vJumpCell = {};
vJumpAvgMat = [];
currentMatVec = [];
correction = 1;
for ii = [1,2,3,4]
    stimChansVec = [28 29; 28 36; 36 37; 28 36];
    badChansVec = {[27],[27],[27],[27]};
    
    stimChans = stimChansVec(ii,:);
    badChans = badChansVec{ii};
    
    if ii == 1
        load(fullfile(dataDir,highResist,['salineAnalysis_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']))
        jp=4;
        kp=5;
        jm=4;
        km=4;
        uniqueStimLabels = [repmat(1:length(uniqueLabels),20,1)];
        uniqueStimLabels = uniqueStimLabels(:);
        
        
    elseif ii == 2
        load(fullfile(dataDir,lowResist,['salineAnalysis_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']))
        jp=5;
        kp=4;
        jm=4;
        km=4;
        uniqueStimLabels = [repmat(1:length(uniqueLabels),20,1)];
        uniqueStimLabels = uniqueStimLabels(:);
        
    elseif ii == 3
        load(fullfile(dataDir,highResist,['salineAnalysis_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']))
        jp=5;
        kp=5;
        jm=5;
        km=4;
        uniqueStimLabels = [repmat(1:length(uniqueLabels),20,1)];
        uniqueStimLabels = uniqueStimLabels(:);
        
    elseif ii == 4
        load(fullfile(dataDir,highResist,['salineAnalysis_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']))
        jp=5;
        kp=4;
        jm=4;
        km=4;
        uniqueStimLabels = [repmat(1:length(uniqueLabels),20,1)];
        uniqueStimLabels = uniqueStimLabels(:);
    end
    %%
    fsStim = 24414;
    
    for conditionInterest = 1:7
        i0 = uniqueLabels(conditionInterest)/1e6; % current in uA to A
        
        currentMatVec = [currentMatVec i0];
        %% 2 point
        stimEpochedInt = stim1Epoched(:,uniqueStimLabels==conditionInterest);
        
        [vJumpAvg,vJumpInd] = stimChan_calculate_jumpR(stimEpochedInt,fsStim);
        vJumpMat = [vJumpMat vJumpInd];
        vJumpCell{ii} = vJumpInd;
        vJumpAvgMat = [vJumpAvgMat vJumpAvg];
        
        dividedVICell{ii} = vJumpCell{ii}/currentMatVec(ii);
        twoPointRCell{ii} = 2*.00115*dividedVICell{ii}/(correction);
        stdVJump(ii) = std(vJumpCell{ii});
        
        dividedVI = vJumpAvg./i0;
        if conditionInterest == 5
            %   vJumpAvg
            % dividedVI
            twoPointR = (2*.00115*dividedVI/(correction))
        end
    end
    
    %% 3 point
    conditionInterest = 5; % condition of interest
    i0 = uniqueLabels(conditionInterest)/1e6 % current in uA to A
    
    dataInt = meanMatAll(:,1,conditionInterest);
    
    % multiply by 4
    dataInt = 4*dataInt;
    dataInt(stimChans) = nan;
    dataInt(badChans) = nan;
    dataIntCell{ii} = dataInt;
    dataIntReshape = reshape(dataInt,8,8);
    
    a=0.00115;
    R=0.00115;
    jLength = 8;
    kLength = 8;
    %%
    
    offset = 0;
    rhoA = 1;
    [l1,tp] = computePotentials_1layer(jp,kp,jm,km,rhoA,i0,stimChans,offset,jLength,kLength);
    
    intercept = true;
    tempStruct = struct;
    
    % use MSE
    if ~isempty(dataInt)
        if ~intercept
            dlm=fitlm(l1,dataInt,'intercept',false);
            tempStruct.rhoAcalc=dlm.Coefficients{1,1};
            tempStruct.offset = 0;
        else
            dlm=fitlm(l1,dataInt);
            tempStruct.rhoAcalc=dlm.Coefficients{2,1};
            tempStruct.offset = dlm.Coefficients{1,1};
        end
        tempStruct.MSE = dlm.RMSE;
        tempStruct.bestVals = dlm.Fitted;
        
    else
        tempStruct.rhoAcalc = nan;
        tempStruct.MSE = nan;
        tempStruct.offset = nan;
    end
    
    fitStruct.calc{ii} = tempStruct;
    dataIntCell{ii} = dataInt;
    fprintf(['complete for trial ' num2str(ii) ' rhoA = ' num2str(tempStruct.rhoAcalc) ' offset = ' num2str(tempStruct.offset) ' \n ']);
    
    %% 4 point
    
    [rho1] = four_point_histogram_calculation_nChoose(jp,kp,jm,km,i0,stimChans,jLength,kLength,dataInt);
    rho1 = rho1(~isnan(rho1) & ~isinf(rho1));
    rho1 = rho1(rho1<=10 & rho1>0);
    fprintf(['complete for trial ' num2str(ii) ' four-point median rhoA = ' num2str(nanmedian(rho1)) ' \n ']);
    rho1Cell{ii} = rho1;
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figValid = figure;
figValid.Units = "inches";
figValid.Position = [0.5 0.5 8 10];
stringCell = {'Stim Pair 28/29 - 3.44 ohm-m saline','Stim Pair 28/36 - 0.51 ohm-m saline',...
    'Stim Pair 36/37 - 3.44 ohm-m saline','Stim Pair 28/36 - 3.44 ohm-m saline'};

for ii = 1:4
    
    subplot(2,2,ii)
    dataPt(1,1) = min(fitStruct.calc{ii}.bestVals);
    dataPt(2,1) = max(fitStruct.calc{ii}.bestVals);
    dataPt(:,2) = dataPt(:,1);
    
    scatter(fitStruct.calc{ii}.bestVals,dataIntCell{ii},'o')
    hold on
    plot(dataPt(:,1),dataPt(:,2))
    text(0,0,['\rho_{apparent} = ' num2str(fitStruct.calc{ii}.rhoAcalc)])
    
    set(gca,'fontsize',10)
    title(stringCell{ii},'fontweight','normal')
    %
end
xlabel('Theoretical Voltage (V)')
ylabel('Experimental Voltage (V)')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figValid = figure;
figValid.Units = "inches";
figValid.Position = [0.5 0.5 8 10];

bins = [0:0.1:10];

stringCell = {'Stim Pair 28/29 - 3.44 ohm-m saline','Stim Pair 28/36 - 0.51 ohm-m saline',...
    'Stim Pair 36/37 - 3.44 ohm-m saline','Stim Pair 28/36 - 3.44 ohm-m saline'};

for ii = 1:4
    
    subplot(2,2,ii)
    histogram(rho1Cell{ii},bins);
    stringMedian = sprintf(['Median = ' sprintf('%0.2f',median(rho1Cell{ii})) '\n',...
        'MAD = ' sprintf('%0.2f',mad(rho1Cell{ii},1))]);
    stringMean = sprintf(['Mean = ' sprintf('%0.2f',mean(rho1Cell{ii})) '\n',...
        'std = '  sprintf('%0.2f',std(rho1Cell{ii},1))]);
    set(gca,'fontsize',10)
    title(stringCell{ii},'fontweight','normal')
    xlim([0 8])
    
    
    h1 = vline(median(rho1Cell{ii}),'k:',stringMedian);
    h2 = vline(mean(rho1Cell{ii}),'k:',stringMean);
    
end

xlabel('Resistivity (ohm-m)')
ylabel('Count')