%% script to fit layered models to saline stimulation
%
% David.J.Caldwell 7.19.2018
close all;clear all;clc
dataDir = 'G:\My Drive\GRIDLabDavidShared\SummerStudents2018\chris_and_sonia\7-18-2018\processedData';
highResist = '2-91ms-cm-solution5';
lowResist = '19-57ms-cm-solution1';

for ii = [1:2]
    stimChansVec = [28 29; 28 36];
    badChansVec = {[27],[27]};
    
    stimChans = stimChansVec(ii,:);
    badChans = badChansVec{ii};
    
    if ii == 1
        load(fullfile(dataDir,highResist,['salineAnalysis_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']))
        
        jp=4;
        kp=5;
        jm=4;
        km=4;
        
    elseif ii == 2
        load(fullfile(dataDir,lowResist,['salineAnalysis_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '.mat']))
        
        jp=5;
        kp=4;
        jm=4;
        km=4;
        
    end
    %%
    
    conditionInterest = 6; % condition of interest
    i0 = uniqueLabels(conditionInterest)/1e6; % current in uA to A
        dataInt = meanMatAll(:,1,conditionInterest);

    % multiply by 4
    dataInt = 4*dataInt;
    dataInt(stimChans) = nan;
    dataInt(badChans) = nan;
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
    
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figValid = figure;
figValid.Units = "inches";
figValid.Position = [0.5 0.5 10 3];
%funcLine = @(x)(fitStruct.calc{1}.offset+fitStruct.calc{1}.rhoAcalc*x)
dataPt(1,1) = min(fitStruct.calc{1}.bestVals);
dataPt(2,1) = max(fitStruct.calc{1}.bestVals);
dataPt(:,2) = dataPt(:,1);

subplot(1,2,1)
scatter(fitStruct.calc{1}.bestVals,dataIntCell{1},'o')
hold on
plot(dataPt(:,1),dataPt(:,2))
text(0,0,['\rho_{apparent} = ' num2str(fitStruct.calc{1}.rhoAcalc)])
xlabel('Theoretical Voltage (V)')
ylabel('Experimental Voltage (V)')
set(gca,'fontsize',14)
title('Saline Validation Solution 3.44 ohm-m')
%

%funcLine = @(x)(fitStruct.calc{2}.offset+fitStruct.calc{2}.rhoAcalc*x);
dataPt(1,1) = min(fitStruct.calc{2}.bestVals);
dataPt(2,1) = max(fitStruct.calc{2}.bestVals);
dataPt(:,2) = dataPt(:,1);

subplot(1,2,2)
scatter(fitStruct.calc{2}.bestVals,dataIntCell{2},'o')
hold on
plot(dataPt(:,1),dataPt(:,2))
text(0,0,['\rho_{apparent} = ' num2str(fitStruct.calc{2}.rhoAcalc)])
xlabel('Theoretical Voltage (V)')
%ylabel('Experimental Voltage (V)')
set(gca,'fontsize',14)
title('Saline Solution 0.51 ohm-m')
