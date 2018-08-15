%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rhoA_vec = [];

%%

% loop through subjects
for i = 1:length(sidVec)
    %for i = 1
    
    % select particular values for constants
    i0 = currentMat(i);
    sid = sidVec(i);
    stimChans = stimChansVec{i};
    jp = jp_vec(i);
    kp = kp_vec(i);
    jm = jm_vec(i);
    km = km_vec(i);
    
    if i <= 7
        dataMeas = dataTotal_8x8(:,i);
    else
        dataMeas = dataTotal_8x4(:,i-7);
    end
    
    [vals,indices,numberNonNaN] = sort_voltage_data(dataMeas);
    
    % perform 1d optimization
    rhoA = 1;
    offset = 0;
    % extract measured data and calculate theoretical ones
    if i <= 7 % 8x8 cases
        [l1] = computePotentials_8x8_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
        % c91479 was flipped l1 l3
        if strcmp(sid,'c91479') || strcmp(sid,'ecb43e')
            l1 = -l1;
        end
        
    else % 8x4 case
        [l1] = computePotentials_8x4_l1(jp,kp,jm,km,rhoA,i0,stimChans,offset);
    end
    
    for k=1:100
        data=dataMeas;
        Limit=2e-4*k;
        for j=1:64
            if data(j)>=Limit
                data(j)=NaN;
            end
            if data(j)<=-Limit
                data(j)=NaN;
            end
        end
        dlm=fitlm(l1,data);
        OUT(:,:,k)=dlm.Coefficients{:,:};
    end
    rhoA_vec(:,i)=squeeze(OUT(2,1,:));
    
    fprintf(['complete for subject ' num2str(i) '\n']);
    
    
    
end


%%
figure
for i=1:length(sidVec)
    subplot(2,4,i)
    plot(2e-4*(1:100),fliplr(rhoA_vec(:,i)))
    
    set(gca,'fontsize',14)
    ylim([0 7])
    title(['Subject ' num2str(i)])
end
xlabel('limit in V')
ylabel('apparent resistivity (Ohm-m)')