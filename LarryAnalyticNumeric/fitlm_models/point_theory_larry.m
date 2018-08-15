% Calculate the raw theoretical voltages, the T's
% Note that this assumes point stim electrodes

% 1 0b5a2e
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
theory1(j,k)=((100/dp)-(100/dm));
end;
end;

% 2 702d24
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
theory2(j,k)=((100/dp)-(100/dm));
end;
end;

% 3 7dbdec
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
theory3(j,k)=((100/dp)-(100/dm));
end;
end;

% 4 9ab7ab
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
theory4(j,k)=((100/dp)-(100/dm));
end;
end;

% 5 c91479
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
theory5(j,k)=((100/dp)-(100/dm));
end;
end;

% 6 d5cd55
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
theory6(j,k)=((100/dp)-(100/dm));
end;
end;

% 7 ecb43e
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
theory7(j,k)=((100/dp)-(100/dm));
end;
end;