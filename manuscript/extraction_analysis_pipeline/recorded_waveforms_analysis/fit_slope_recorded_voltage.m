function voltageSlopeStruct = fit_slope_recorded_voltage(subStruct,plotIt,saveIt)

intercept = true;
voltageSlopeStruct = struct;

numIndices = size(subStruct.meanMat,3);

% loop through trials within structure
for index = 1:numIndices
    
    numChans = size(subStruct.meanMat,1);
    dataInt = subStruct.extractCell{index};
    fs = subStruct.fs;
    current = subStruct.currentMat(index);
    for chan = 1:numChans
        dataIntChan = dataInt{chan};
        
        for phase = 1:2
            dataIntChanPhase = dataIntChan{phase};
            tTemp = (0:length(dataIntChanPhase)-1)/fs;
            % use MSE
            if ~isempty(dataIntChanPhase)
                if ~intercept
                    dlm=fitlm(tTemp,dataIntChanPhase,'intercept',false);
                    tempStruct.slopeCalc(chan,phase)=dlm.Coefficients{1,1};
                    tempStruct.offset(chan,phase) = 0;
                    tempStruct.capac(chan,phase) = current/dlm.Coefficients{1,1};
                    
                else
                    dlm=fitlm(tTemp,dataIntChanPhase);
                    tempStruct.slopeCalc(chan,phase)=dlm.Coefficients{2,1};
                    tempStruct.offset(chan,phase) = dlm.Coefficients{1,1};
                    tempStruct.capac(chan,phase) = current/dlm.Coefficients{2,1};
                end
                tempStruct.MSE(chan,phase) = dlm.RMSE;
                tempStruct.bestVals{chan,phase} = dlm.Fitted;
            else
                tempStruct.slopeCalc(chan,phase) = nan;
                tempStruct.capac(chan,phase) = nan;
                tempStruct.MSE(chan,phase) = nan;
                tempStruct.offset(chan,phase) = nan;
            end
            
        end
    end
    
    voltageSlopeStruct.slope{index} = tempStruct;
    
    clearvars tempsStruct
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plotIt
    figure
    for index=1:numIndices
        subplot(2,4,index)
        plot(voltageSlopeStruct.slope{index}.slopeCalc,'linewidth',3)
        title(['Subject ' num2str(index)])
        set(gca,'fontsize',16)
    end
    legend({'First phase', 'second phase'})
    xlabel('Electrode Number')
    ylabel('Slope (Volts/seconds)')
    if saveIt
    end
    
    figure
    
    for index=1:numIndices
        subplot(2,4,index)
        plot(voltageSlopeStruct.slope{index}.slopeCalc(:,1),'linewidth',3)
        title(['Subject ' num2str(index)])
        set(gca,'fontsize',16)
    end
    legend({'First phase'})
    xlabel('Electrode Number')
    ylabel('Slope (Volts/seconds)')
    if saveIt
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        figure
    for index=1:numIndices
        subplot(2,4,index)
        plot(voltageSlopeStruct.slope{index}.capac,'linewidth',3)
        title(['Subject ' num2str(index)])
        set(gca,'fontsize',16)
    end
    legend({'First phase', 'second phase'})
    xlabel('Electrode Number')
    ylabel('Capacitance')
    if saveIt
    end
    
    figure
    
    for index=1:numIndices
        subplot(2,4,index)
        plot(voltageSlopeStruct.slope{index}.capac(:,1),'linewidth',3)
        title(['Subject ' num2str(index)])
        set(gca,'fontsize',16)
    end
    legend({'First phase'})
    xlabel('Electrode Number')
    ylabel('Capacitance')
    if saveIt
    end
end
