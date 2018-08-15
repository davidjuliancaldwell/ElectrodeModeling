E=voltage1;
for k=1:100;
    thy=th1;
    Limit=2e-4*k;
    
    for j=1:64;
        
        if thy(j)>=Limit
            thy(j)=NaN;
        end
        
        if thy(j)<=-Limit
            thy(j)=NaN;
        end
        
    end
    
    dlm=fitlm(thy,E);
    OUT(:,:,k)=dlm.Coefficients{:,:};
end;

for k=1:100;m1(k)=OUT(2,1,k);end;



E=voltage2;
for k=1:100;
    thy=th2;
    Limit=2e-4*k;
    
    for j=1:64;
        
        if thy(j)>=Limit
            thy(j)=NaN;
        end
        
        if thy(j)<=-Limit
            thy(j)=NaN;
        end
        
    end
    
    dlm=fitlm(thy,E);
    OUT(:,:,k)=dlm.Coefficients{:,:};
end;
for k=1:100;m2(k)=OUT(2,1,k);end;



E=voltage3;
for k=1:100;
    thy=th3;
    Limit=2e-4*k;
    
    for j=1:64;
        if thy(j)>=Limit
            thy(j)=NaN;
        end
        
        if thy(j)<=-Limit
            thy(j)=NaN;
        end
        
    end
    
    dlm=fitlm(thy,E);
    OUT(:,:,k)=dlm.Coefficients{:,:};
end;
for k=1:100;m3(k)=OUT(2,1,k);end;



E=voltage4;
for k=1:100;
    thy=th4;
    Limit=2e-4*k;
    
    for j=1:64;
        
        if thy(j)>=Limit
            thy(j)=NaN;
        end
        
        if thy(j)<=-Limit
            thy(j)=NaN;
        end
        
    end
    
    dlm=fitlm(thy,E);
    OUT(:,:,k)=dlm.Coefficients{:,:};
end;
for k=1:100;m4(k)=OUT(2,1,k);end;


E=voltage5;
for k=1:100;
    thy=th5;
    Limit=2e-4*k;
    
    for j=1:64;
        
        if thy(j)>=Limit
            thy(j)=NaN;
        end
        
        if thy(j)<=-Limit
            thy(j)=NaN;
        end
        
    end
    
    dlm=fitlm(thy,E);
    OUT(:,:,k)=dlm.Coefficients{:,:};
end;
for k=1:100;m5(k)=-OUT(2,1,k);end;


E=voltage6;
for k=1:100;
    thy=th6;
    Limit=2e-4*k;
    
    for j=1:64;
        
        if thy(j)>=Limit
            thy(j)=NaN;
        end
        
        if thy(j)<=-Limit
            thy(j)=NaN;
        end
        
    end
    
    dlm=fitlm(thy,E);
    OUT(:,:,k)=dlm.Coefficients{:,:};
end;
for k=1:100;m6(k)=OUT(2,1,k);end;


E=voltage7;
for k=1:100;
    thy=th7;
    Limit=2e-4*k;
    
    for j=1:64;
        
        if thy(j)>=Limit
            thy(j)=NaN;
        end
        
        if thy(j)<=-Limit
            thy(j)=NaN;
        end
        
    end
    
    dlm=fitlm(thy,E);
    OUT(:,:,k)=dlm.Coefficients{:,:};
end;
for k=1:100;m7(k)=-OUT(2,1,k);end;

figure;subplot(2,4,1);plot(m1)
hold on;subplot(2,4,2);plot(m2)
hold on;subplot(2,4,3);plot(m3)
hold on;subplot(2,4,4);plot(m4)
hold on;subplot(2,4,5);plot(m5)
hold on;subplot(2,4,6);plot(m6)
hold on;subplot(2,4,7);plot(m7)

figure;plot(m1,'b')
hold on;plot(m2,'r')
hold on;plot(m3,'g')
hold on;plot(m4,'c')
hold on;plot(m5,'m')
hold on;plot(m6,'y')
hold on;plot(m7,'k')