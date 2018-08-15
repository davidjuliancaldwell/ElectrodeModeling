

>> load('/Users/imac2/Desktop/meansStds_3_28_2018.mat')
>> voltage1=4*meanMatAll_1st7(:,1,1);
voltage2=4*meanMatAll_1st7(:,1,2);
voltage3=4*meanMatAll_1st7(:,1,3);
voltage4=4*meanMatAll_1st7(:,1,4);
voltage5=4*meanMatAll_1st7(:,1,5);
voltage6=4*meanMatAll_1st7(:,1,6);
voltage7=4*meanMatAll_1st7(:,1,7);
>> make_volt_matrices
>> VLR1(1:8,1:3)=volt(1:8,1:3);
Undefined function 'volt' for input arguments of type 'double'.
 
>> VLR1(1:8,1:3)=volt1(1:8,1:3);
>> VLR1(1:8,4)=0.5*(volt1(1:8,4)+volt1(1:8,8));
>> % fix volt1(4,5)
>> volt1(4,5)=volt1(4,7);
>> VLR1(1:8,5)=0.5*(volt1(1:8,5)+volt1(1:8,7));
>> VLR1(1:8,6)=volt1(1:8,6);
>> VLR1(1:8,7)=VLR1(1:8,5);
>> VLR1(1:8,8)=VLR1(1:8,4);
>> figure;imagesc(VLR1)
>> % 1 0b5a2e
i0(1)=1.75e-3;
jp=3;
kp=6;
jm=4;
km=6;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY1(j,k)=(i0(1)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> figure;imagesc(THY1)
>> vlr1=reshape(VLR1',[1,64]);
>> thy1=reshape(THY1',[1,64]);
>> figure;plot(vlr1)
>> figure;plot(thy1,'r')
>> hold on;plot(thy1,'r')
>> hold on;plot(voltage1,'g')
>> 
>> 
>> figure;plot(vlr1)
hold on;plot(4*thy1,'g')
hold on;plot(voltage1,'r')
>> figure;plot(vlr1)
hold on;plot(thy1,'m')
hold on;plot(voltage1,'r')
>> figure;plot(vlr1)
hold on;plot(thy1,'g')
hold on;plot(voltage1,'r')
>> 
>> 
>> 
>> E=vlr1;
for k=1:100;
thy=thy1;
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
figure;plot(m1)
>> 
>> 
>> 
>> % rotate volt2
>> rvolt=volt2';
>> VLR2(1:8,1)=0.5*(rvolt(1:8,1)+rvolt(1:8,3));
>> VLR2(1:8,2)=rvolt(1:8,2);
>> VLR2(1:8,3)=VLR(1:8,1);
Undefined function 'VLR' for input arguments of type 'double'.
 
>> VLR2(1:8,3)=VLR2(1:8,1);
>> VLR2(1:8,4:8)=rvolt(1:8,4:8);
>> 
>> 
>> 
>> % 2 702d24
i0(2)=0.75e-3;
jp=2;
kp=5;
jm=2;
km=6;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY2(j,k)=(i0(2)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> 
>> 
>> vlr2=reshape(VLR2',[1,64]);
thy2=reshape(THY2',[1,64]);
>> 
>> 
>> figure;plot(vlr2)
hold on;plot(thy2,'g')
hold on;plot(voltage2,'r')
>> cvlr2=reshape(VLR2',[1,64]);
cthy2=reshape(THY2',[1,64]);
>> cvlr2=reshape(VLR2,[1,64]);
cthy2=reshape(THY2,[1,64]);
>> figure;plot(cvlr2)
hold on;plot(cthy2,'g')
hold on;plot(voltage2,'r')
>> hold on;plot(thy2,'g')
>> 
>> 
>> 
>> 
>> % 2 702d24
i0(2)=0.75e-3;
jp=5;
kp=2;
jm=6;
km=2;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY2(j,k)=(i0(2)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> thy2=reshape(THY2',[1,64]);
>> figure;plot(vlr2)
hold on;plot(thy2,'g')
hold on;plot(voltage2,'r')
>> rvoltage2=reshape(volt2,[1,64]);
>> figure;plot(vlr2)
hold on;plot(thy2,'g')
hold on;plot(rvoltage2,'r')
>> figure;plot(vlr2)
hold on;plot(thy2,'g')
hold on;plot(4*rvoltage2,'r')
>> figure;plot(vlr2)
hold on;plot(4*thy2,'g')
hold on;plot(rvoltage2,'r')
>> 
>> 
>> 
>> % 2 702d24
i0(2)=0.75e-3;
jp=2;
kp=5;
jm=2;
km=6;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY2(j,k)=(i0(2)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> 
>> 
>> VLR(1,1:8)=0.5(volt2(1,1:8)+volt2(3,1:8));
 VLR(1,1:8)=0.5(volt2(1,1:8)+volt2(3,1:8));
               |
Error: Unbalanced or unexpected parenthesis or bracket.
 
>> VLR(1,1:8)=0.5*(volt2(1,1:8)+volt2(3,1:8));
>> VLR2(1,1:8)=0.5*(volt2(1,1:8)+volt2(3,1:8));
>> VLR2(2,1:8)=volt2(2,1:8);
>> VLR2(3,1:8)=VLR2(1,1:8);
>> VLR2(4:8,1:8)=volt2(4:8,1:8);
>> figure;imagesc(VLR2)
>> figure;imagesc(volt2)
>> % fix volt2
>> volt2(3,5)=volt2(1,5);
>> volt2(1,6)=volt2(3,6);
>> 
>> 
>> 
>> 
>> VLR(1,1:8)=0.5*(volt2(1,1:8)+volt2(3,1:8));
VLR2(1,1:8)=0.5*(volt2(1,1:8)+volt2(3,1:8));
VLR2(2,1:8)=volt2(2,1:8);
VLR2(3,1:8)=VLR2(1,1:8);
VLR2(4:8,1:8)=volt2(4:8,1:8);
figure;imagesc(VLR2)
figure;imagesc(volt2)
>> % set NaN's to zero for the plot
>> figure;imagesc(VLR2)
figure;imagesc(volt2)
>> % restore the NaN's
>> 
>> 
>> vlr2=reshape(VLR2',[1,64]);
thy2=reshape(THY2',[1,64]);
>> figure;plot(vlr2)
hold on;plot(thy2,'g')
hold on;plot(rvoltage2,'r')
>> figure;plot(vlr2)
hold on;plot(thy2,'g')
hold on;plot(voltage2,'r')
>> 
>> 
>> figure;plot(vlr2)
hold on;plot(4*thy2,'g')
hold on;plot(voltage2,'r')
>> close all
>> close all
>> close all
>> E=vlr1;
for k=1:100;
thy=thy1;
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
figure;plot(m1)

>> E=vlr2;
for k=1:100;
thy=thy2;
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
figure;plot(m2)
>> 
>> 
>> 
>> 
>> 
>> 
>> VLR3(1,1:8)=0.5*(volt3(1,1:8)+volt3(3,1:8));
VLR3(2,1:8)=volt3(2,1:8);
VLR3(3,1:8)=VLR3(1,1:8);
VLR3(4:8,1:8)=volt3(4:8,1:8);
>> 
>> 
>> % 3 7dbdec
i0(3)=3.5e-3;
jp=2;
kp=3;
jm=2;
km=4;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY3(j,k)=(i0(3)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> 
>> 
>> vlr3=reshape(VLR3',[1,64]);
thy3=reshape(THY3',[1,64]);
>> 
>> 
>> figure;plot(vlr3)
hold on;plot(thy3,'g')
hold on;plot(voltage3,'r')

figure;plot(vlr3)
hold on;plot(4*thy3,'g')
hold on;plot(voltage3,'r')
>> 
>> 
>> 
>> % set NaN's to zero for the plot
figure;imagesc(VLR2)
figure;imagesc(volt2)
% restore the NaN's
>> figure;imagesc(VLR3)
figure;imagesc(volt3)
>> 
>> 
>> 
>> 
>> E=vlr3;
for k=1:100;
thy=thy3;
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
figure;plot(m3)
>> VLR4=volt4;
>> 
>> 
>> % 4 9ab7ab
i0(4)=0.75e-3;
jp=8;
kp=3;
jm=8;
km=4;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY4(j,k)=(i0(4)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> 
>> 
>> vlr4=reshape(VLR4',[1,64]);
THY4=reshape(THY4',[1,64]);
>> 
>> 
>> figure;plot(vlr4)
hold on;plot(thy4,'g')
hold on;plot(voltage4,'r')

figure;plot(vlr4)
hold on;plot(4*thy4,'g')
hold on;plot(voltage4,'r')
Undefined function or variable 'thy4'.
 
>> % 4 9ab7ab
i0(4)=0.75e-3;
jp=8;
kp=3;
jm=8;
km=4;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY4(j,k)=(i0(4)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> vlr4=reshape(VLR4',[1,64]);
thy4=reshape(THY4',[1,64]);
Error using reshape
To RESHAPE the number of elements must not change.
 
>> % 4 9ab7ab
i0(4)=0.75e-3;
jp=8;
kp=3;
jm=8;
km=4;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THEORY4(j,k)=(i0(4)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> thy4=reshape(THEORY4',[1,64]);
>> 
>> 
>> figure;plot(vlr4)
hold on;plot(thy4,'g')
hold on;plot(voltage4,'r')

figure;plot(vlr4)
hold on;plot(4*thy4,'g')
hold on;plot(voltage4,'r')
>> figure;imagesc(VLR4)
figure;imagesc(volt4)
>> 
>> 
>> 
>> 
>> E=vlr4;
for k=1:100;
thy=thy4;
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
figure;plot(m4)
>> close all
>> close all
>> close all
>> 
>> 
>> 
>> VLR5(1:5,1:8)=volt5(1:5,1:8);
>> VLR5(6,1:8)=0.5*(volt5(6,1:8)+volt5(8,1:8));
>> VLR5(8,1:8)=VLR5(6,1:8);
>> VLR5(7,1:8)=volt5(7,1:8);
>> figure;imagesc(VLR5)
figure;imagesc(volt5)
>> vlr5=reshape(VLR5',[1,64]);
thy5=reshape(THY5',[1,64]);
Undefined function or variable 'THY5'.
 
>> % 5 c91479
i0(5)=3e-3;
jp=7;
kp=7;
jm=7;
km=8;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY5(j,k)=(i0(5)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> thy5=reshape(THY5',[1,64]);
>> 
>> 
>> 
>> figure;plot(vlr5)
hold on;plot(thy5,'g')
hold on;plot(voltage5,'r')

figure;plot(vlr5)
hold on;plot(4*thy5,'g')
hold on;plot(voltage5,'r')
>> 
>> 
>> figure;plot(vlr5)
hold on;plot(-thy5,'g')
hold on;plot(voltage5,'r')

figure;plot(vlr5)
hold on;plot(-4*thy5,'g')
hold on;plot(voltage5,'r')
>> 
>> 
>> 
>> E=vlr5;
for k=1:100;
thy=thy5;
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
for k=1:100;m5(k)=OUT(2,1,k);end;
figure;plot(m5)
>> figure;plot(-m5)
>> close all
>> VLR6(1:8,1:3)=volt6(1:8,1:3);
>> VLR6(1:8,6)=volt6(1:8,6);
>> VLR6(1:8,4)=0.5*(volt6(1:8,4)+volt6(1:8,8));
>> VLR6(1:8,8)=VLR6(1:8,4);
>> VLR6(1:8,5)=0.5*(volt6(1:8,5)+volt6(1:8,7));
>> VLR6(1:8,7)=VLR6(1:8,5);
>> figure;imagesc(VLR6)
figure;imagesc(volt6)
>> 
>> 
>> 
>> % 6 d5cd55
i0(6)=2.5e-3;
% Calculate distances
jp=7;
kp=6;
jm=8;
km=6;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY6(j,k)=(i0(6)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> vlr6=reshape(VLR6',[1,64]);
thy6=reshape(THY6',[1,64]);
>> figure;plot(vlr6)
hold on;plot(thy6,'g')
hold on;plot(voltage6,'r')

figure;plot(vlr6)
hold on;plot(4*thy6,'g')
hold on;plot(voltage6,'r')
>> 
>> 
>> 
>> 
>> E=vlr6;
for k=1:100;
thy=thy6;
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
figure;plot(m6)
>> close all
>> close all
>> close all
>> VLR7=volt7;
>> % 7 ecb43e
i0(7)=1.75e-3;
jp=7;
kp=8;
jm=8;
km=8;
for j=1:8;
for k=1:8;
dxp=j-jp;
dyp=k-kp;
dxm=j-jm;
dym=k-km;
dp=sqrt(dxp^2+dyp^2);
dm=sqrt(dxm^2+dym^2);
THY7(j,k)=(i0(7)/(2*pi))*((100/dp)-(100/dm));
end;
end;
>> vlr7=reshape(VLR7',[1,64]);
thy7=reshape(THY7',[1,64]);
>> 
>> figure;plot(vlr7)
hold on;plot(thy7,'g')
hold on;plot(voltage7,'r')

figure;plot(vlr7)
hold on;plot(4*thy7,'g')
hold on;plot(voltage7,'r')
>> 
>> 
>> figure;plot(vlr7)
hold on;plot(-thy7,'g')
hold on;plot(voltage7,'r')

figure;plot(vlr7)
hold on;plot(-4*thy7,'g')
hold on;plot(voltage7,'r')
>> 
>> 
>> figure;imagesc(VLR7)
figure;imagesc(volt7)
>> figure;imagesc(VLR7)
figure;imagesc(volt7)
>> 
>> 
>> E=vlr7;
for k=1:100;
thy=thy7;
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
for k=1:100;m7(k)=OUT(2,1,k);end;
figure;plot(-m7)
>> close all
>> close all
>> close all
>> 
>> 
>> 
>> 
>> figure;subplot(2,4,1);plot(m1)
hold on;subplot(2,4,2);plot(m2)
hold on;subplot(2,4,3);plot(m3)
hold on;subplot(2,4,4);plot(m4)
hold on;subplot(2,4,5);plot(-m5)
hold on;subplot(2,4,6);plot(m6)
hold on;subplot(2,4,7);plot(-m7)