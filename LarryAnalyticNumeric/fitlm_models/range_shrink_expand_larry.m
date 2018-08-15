E=voltage6;

for j=1:20;
thy=th6;
Limit=0.001*j;

for j=1:64;
if thy(j)>=Limit 
thy(j)=NaN;
end
if thy(j)<=-Limit 
thy(j)=NaN;
end
end

dlm=fitlm(thy,E);dlm
end;





E=voltage1;
for j=1:20;
thy=th1;
Limit=0.001*j;

for j=1:64;
if thy(j)<=Limit 
thy(j)=NaN;
end
if thy(j)<=-Limit 
thy(j)=NaN;
end
end

dlm=fitlm(thy,E);dlm
end;