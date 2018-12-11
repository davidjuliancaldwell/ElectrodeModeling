function [meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,figTotal] = ECoG_subject_processing(ii,jj,meanMat,stdMat,numberStims,stdCellEveryPoint,extractCell,...
    meanMatAll,stdMatAll,numberStimsAll,stdEveryPoint,extractCellAll,stimChans,...
    currentMat,numChansInt,sid,plotIt,OUTPUT_DIR,figTotal,numRows,numColumns,counterIndex)

meanMat(stimChans,:) = nan;
stdMat(stimChans,:) = nan;
extractCell{stimChans(1)}{1} = nan;
extractCell{stimChans(1)}{2}= nan;
extractCell{stimChans(2)}{1}= nan;
extractCell{stimChans(2)}{2}= nan;
stdCellEveryPoint{stimChans(1)} = {nan,nan};
stdCellEveryPoint{stimChans(2)} =  {nan,nan};

extractCellAll{ii,jj} = extractCell;

meanMatAll(:,:,ii,jj) = meanMat;
stdMatAll(:,:,ii,jj) = stdMat;
numberStimsAll(ii,jj) = numberStims;
stdEveryPoint{ii,jj} = stdCellEveryPoint;

saveIt = 0;
if plotIt
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     chanVec = [1:numChansInt];
    %     figure
    %     errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
    %     hold on
    %     errorbar(chanVec+0.3,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
    %     legend('first phase','second phase')
    %     xlabel('electrode')
    %     ylabel('Voltage (V)')
    %     % title(['Subject ' num2str(ii)])
    %     title(['Mean and Standard Deviation for Recorded Biphasic Pulse'])
    %     vline(stimChans(1),'g');
    %     vline(stimChans(2),'b');
    %     legend('- chan','+ chan')
    %
    %     set(gca,'fontsize',16)
    %%%%%%%%%%%%%%%%%%%%%%%%%
    chanVec = [1:numChansInt];
    
    figure(figTotal)
    subplot(numRows,numColumns,counterIndex)
    errorbar(chanVec,abs(meanMat(:,1)),stdMat(:,1),'linewidth',2)
    hold on
    errorbar(chanVec,abs(meanMat(:,2)),stdMat(:,2),'linewidth',2)
    v2 = vline(stimChans(1),'g');
    v3 = vline(stimChans(2),'b');
    title(['Subject ' num2str(ii) ' subject ID ' sid ' stim channels ' num2str(stimChans(1)) ' ' num2str(stimChans(2)),...
        ' current ' num2str(1e6*currentMat(ii,jj)) '\muA' ])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,1,1)
    hold on
    plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
    plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
    
    for chan = chanVec
        dataInt = stdCellEveryPoint{chan};
        dataInt1st = dataInt{1};
        dataInt2nd = dataInt{2};
        scatter(jitter(repmat(chan,size(dataInt1st)),0.01),abs(meanMat(chan,1))+dataInt1st,'markeredgecolor',[0,0.4470,0.7410])
        scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),abs(meanMat(chan,2))+dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980])
    end
    v2 = vline(stimChans(1),'g');
    v3 = vline(stimChans(2),'b');
    xlabel('electrode')
    ylabel('Voltage (V)')
    % title(['Subject ' num2str(ii)])
    title({['Subject ' num2str(ii) ' subject ID ' sid ' stim channels ' num2str(stimChans(1)) ' ' num2str(stimChans(2)) ],...
        [' current ' num2str(1e6*currentMat(ii,jj)) '\muA'],...
        'Mean and Average Standard Deviation across windows for Recorded Biphasic Pulse'})
    set(gca,'fontsize',16)
    
    subplot(2,1,2)
    hold on
    for chan = chanVec
        dataInt = stdCellEveryPoint{chan};
        dataInt1st = dataInt{1};
        dataInt2nd = dataInt{2};
        h1{chan} =scatter(jitter(repmat(chan,size(dataInt1st)),0.01),dataInt1st,'markeredgecolor',[0,0.4470,0.7410]);
        h2{chan} =scatter(jitter(repmat(chan+0.3,size(dataInt2nd)),0.01),dataInt2nd,'markeredgecolor',[0.8500,0.3250,0.0980]);
    end
    
    v2 = vline(stimChans(1),'g');
    v3 = vline(stimChans(2),'b');
    
    set(gca,'YScale','log')
    xlabel('electrode')
    ylabel('standard deviation (V)')
    title({'Standard Deviation for each sample in the stable part','of the artifact for Recorded Biphasic Pulse'})
    legend([h1{1} h2{1} v2 v3],{'first phase','second phase','- chan','+ chan'})
    set(gca,'fontsize',16)
    if saveIt
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_' sid '_stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_current_' num2str(1e6*currentMat(ii,jj))]),'png');
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % new version of scatter plot
    %%
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,1,1)
    hold on
    plot(chanVec,abs(meanMat(:,1)),'linewidth',2)
    plot(chanVec+0.3,abs(meanMat(:,2)),'linewidth',2)
    
    h{1} = errorbar(chanVec,abs(meanMat(:,1)),3.*stdMat(:,1),'linewidth',2,'color',[0,0.4470,0.7410]);
    h{2} = errorbar(chanVec+0.3,abs(meanMat(:,2)),3.*stdMat(:,2),'linewidth',2,'color',[0.8500,0.3250,0.0980]);
    v2 = vline(stimChans(1),'g');
    v3 = vline(stimChans(2),'b');
    xlabel('electrode')
    ylabel('Voltage (V)')
    % title(['Subject ' num2str(ii)])
    title({['Subject ' num2str(ii) ' subject ID ' sid ' stim channels ' num2str(stimChans(1)) ' ' num2str(stimChans(2)) ],...
        [' current ' num2str(1e6*currentMat(ii,jj)) '\muA'],...
        'Mean and 3x average standard deviation for mean waveform for recorded biphasic pulse'})
    legend([h{1} h{2} v2 v3],{'first phase','second phase','- chan','+ chan'})
    
    set(gca,'fontsize',16)
    
    %     subplot(3,1,2)
    %     hold on
    %     h{1} = scatter(chanVec,100*stdMat(:,1)./abs(meanMat(:,1)),'filled');
    %     h{2} = scatter(chanVec,100*stdMat(:,2)./abs(meanMat(:,2)),'filled');
    %     set(gca,'YScale','log')
    %     v2 = vline(stimChans(1),'g');
    %     v3 = vline(stimChans(2),'b');
    %
    %     xlabel('electrode')
    %     ylabel('Percent percent of mean')
    %     title({'Percent of mean, standard Deviation across mean waveform','of the artifact for Recorded Biphasic Pulse'})
    %     legend([h1{1} h2{1} v2 v3],{'first phase','second phase','- chan','+ chan'})
    %     set(gca,'fontsize',16)
    
    subplot(2,1,2)
    hold on
    h{1} = scatter(chanVec,stdMat(:,1),'filled');
    h{2} = scatter(chanVec,stdMat(:,2),'filled');
    
    
    set(gca,'YScale','log')
    v2 = vline(stimChans(1),'g');
    v3 = vline(stimChans(2),'b');
    
    xlabel('electrode')
    ylabel('Voltage (V)')
    title({'standard Deviation across mean waveform','of the artifact for recorded biphasic pulse'})
    % legend([h1{1} h2{1} v2 v3],{'first phase','second phase','- chan','+ chan'})
    set(gca,'fontsize',16)
    if saveIt
        SaveFig(OUTPUT_DIR, sprintf(['meansAndStds_v2_' sid '_stimChans_' num2str(stimChans(1)) '_' num2str(stimChans(2)) '_current_' num2str(1e6*currentMat(ii,jj))]),'png');
    end
end

end

