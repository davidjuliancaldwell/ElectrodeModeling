R=6;

load('0b5a2e_trode_coords_MNIandTal.mat')
jp=22;
jm=30;
for j=1:64;
MNIrb(j)=0.1*norm(MNIcoords(j,:)-MNIcoords(jp,:));
MNIra(j)=0.1*norm(MNIcoords(j,:)-MNIcoords(jm,:));
MNIthy1(j)=((100./MNIrb(j))-(100./MNIra(j)));
end;

for j=1:64;
MNIL(j)=0.1*norm(MNIcoords(j,:));
end;



for j=1:64;MNIs(j,:)=0.1*MNIcoords(j,:);end
for j=1:64;MNIb(1,:)=0.1*MNIcoords(jp,:);end
for j=1:64;MNIa(1,:)=0.1*MNIcoords(jm,:);end

for j=1:64;MNIout(j)=dot(MNIs(j,:),MNIa(1,:));end


for j=1:64;MNID(j)=norm(MNIs(j,:))*norm(MNIa(1,:));end

MNIcosine_beta=MNIout./MNID;

for j=1:64;MNIout2(j)=dot(MNIs(j,:),MNIb(1,:));end


for j=1:64;MNID2(j)=norm(MNIs(j,:))*norm(MNIb(1,:));end

MNIcosine_theta=MNIout2./MNID2;


for j=1:64;MNItop(j)=MNIra(j)+R*(1-MNIcosine_beta(j));end

for j=1:64;MNIbottom(j)=MNIrb(j)+R*(1-MNIcosine_theta(j));end

MNIratio=MNItop./MNIbottom;
MNIratio(22)=NaN;
MNIratio(30)=NaN;

MNIcorrection=(1/(2*R))*log(MNIratio);


figure;plot(MNIra)
hold on;plot(MNIrb,'r')
figure;plot(MNIout./MNID)
hold on;plot(MNIout2./MNID2,'r')

figure;plot(MNIL)
figure;plot(MNIout)
figure;plot(MNIout2)
figure;plot(MNIcosine_beta)
hold on;plot(MNIcosine_theta,'r')
figure;plot(MNItop)
hold on;plot(MNIbottom,'r')
figure;plot(MNIratio)

figure;plot(MNIcorrection)
figure;plot(MNIthy1)
hold on;plot(MNIcorrection,'r')

%% plot coords

[th,phi,r] = cart2sph(0.1*MNIcoords(:,1),0.1*MNIcoords(:,2),0.1*MNIcoords(:,3));
figure
subplot(5,1,1)
plot(th(1:64))
title('theta')
subplot(5,1,2)
plot(unwrap(th(1:64)))
title('unwrapped theta')
subplot(5,1,3)
plot(phi(1:64))
title('phi')
subplot(5,1,4)
plot(unwrap(phi(1:64)))
title('unwrapped phi')
subplot(5,1,5)
plot(r(1:64))
title('r')

%% check 

max(unwrap(th(1:64)))-min(unwrap(th(1:64)))
max(unwrap(phi(1:64)))-min(unwrap(phi(1:64)))

%% plot on sphere
[x,y,z] = sphere;
x = 6.*x ;
y = 6.*y ;
z = 6.*z ;
figure
s = surf(x,y,z);
%set(s,'EdgeColor','none');
set(s,'FaceAlpha',0.25);
set(s,'FaceColor',[0.5 0.5 0.5]);
hold on
locs = 0.1*MNIcoords(1:64,:);
% take labeling from plot dots direct
 scatter3(locs(:,1),locs(:,2),locs(:,3),[100],[1 0 0],'filled');
%
gridSize = 64;
trodeLabels = [1:gridSize];
for chan = 1:gridSize
    txt = num2str(trodeLabels(chan));
    t = text(locs(chan,1),locs(chan,2),locs(chan,3),txt,'FontSize',10,'HorizontalAlignment','center','VerticalAlignment','middle');
    set(t,'clipping','on');
end