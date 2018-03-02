function [meanMatrix,stdMatrix,extractCell] = voltage_extract_avg(waveformMatrix,fs,preSamps,postSamps)
% expects time x channels x trials
% average across trials, and find the average stimulation waveform during
% each phase of a stimulus
% this returns a matrix of means channels x 1, and a matrix of standard
% deviations - channels x 1

[~,chanMax] = max(max(mean(waveformMatrix,3),[],1));
t_samps = [1:size(waveformMatrix,1)];
plotIt = 0;

for chan = 1:size(waveformMatrix,2)
    signal_int = mean(waveformMatrix(:,chan,:),3);
    diff_sig = [0; squeeze(diff(signal_int))];
    begin_ind = find(abs(zscore(diff_sig))>3,1,'first');
    end_ind = find(abs(zscore(diff_sig))>3,1,'last');
    
    sign_begin = signal_int(begin_ind+10);
    z_diff = zscore(diff_sig);
    if sign_begin>0
        [~,transition_pt] = max(-1* z_diff);
        [~,begin_ind] = max( z_diff(t_samps<transition_pt-3));
        [~,end_ind] = max( z_diff(t_samps>transition_pt+3));
        end_ind = end_ind + length(t_samps(t_samps<transition_pt+3));
    else
        [~,transition_pt] = max(z_diff);
        [~,begin_ind] = max(-1*z_diff(t_samps<transition_pt-3));
        [~,end_ind] = max(-1*z_diff(t_samps>transition_pt+3));
        end_ind = end_ind + length(t_samps(t_samps<transition_pt+3));
    end
    if plotIt && ~isempty(begin_ind)
        figure
        ax = axes;
        plot(1e3*t_samps/fs,signal_int,'linewidth',3)
        ylim([-3e-3 3e-3])
        beg = vline(1e3*begin_ind/fs,'g');
        trans = vline(1e3*transition_pt/fs,'k');
        en = vline(1e3*end_ind/fs,'r');
        high1 = highlight(ax,[1e3*(begin_ind+preSamps)/fs,1e3*(transition_pt-postSamps)/fs],[],[180 180 180]/256);
        high2 = highlight(ax,[1e3*(transition_pt+preSamps)/fs,1e3*(end_ind-postSamps)/fs],[],[180 180 180]/256);
        legend('signal','beginning','transition','end','extracted period')
        xlabel('time (ms)');
        ylabel(['Voltage (V)']);
        title('Signal Extraction');
        set(gca,'fontsize',14);
    end
    
    first_phase = signal_int(begin_ind+preSamps:transition_pt-postSamps);
    second_phase = signal_int(transition_pt+preSamps:end_ind-postSamps);
    extractCell{chan}{1} = first_phase;
    extractCell{chan}{2} = second_phase;
    
    meanMatrix(chan,1) = mean(first_phase);
    meanMatrix(chan,2) = mean(second_phase);
    stdMatrix(chan,1) = std(first_phase);
    stdMatrix(chan,2) = std(second_phase);
    
    
end

