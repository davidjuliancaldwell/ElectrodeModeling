R=6;

load('subj1_bis_trodes.mat')
jp=22;
jm=30;
for j=1:64;
rb(j)=0.1*norm(AllTrodes(j,:)-AllTrodes(jp,:));
ra(j)=0.1*norm(AllTrodes(j,:)-AllTrodes(jm,:));
CTthy1(j)=((100./rb(j))-(100./ra(j)));
end;

for j=1:64;
L(j)=0.1*norm(AllTrodes(j,:));
end;



for j=1:64;s(j,:)=AllTrodes(j,:);end
b(1,:)=AllTrodes(jp,:);
a(1,:)=AllTrodes(jm,:);

for j=1:64;out(j)=dot(s(j,:),a(1,:));end


for j=1:64;D(j)=norm(s(j,:))*norm(a(1,:));end
figure;plot(out./D)
cosine_beta=out./D;

for j=1:64;out2(j)=dot(s(j,:),b(1,:));end


for j=1:64;D2(j)=norm(s(j,:))*norm(b(1,:));end
figure;plot(out2./D2)
cosine_theta=out2./D2;


for j=1:64;top(j)=ra(j)+R*(1-cosine_beta(j));end

for j=1:64;bottom(j)=rb(j)+R*(1-cosine_theta(j));end

ratio=top./bottom;
ratio(22)=NaN;
ratio(30)=NaN;

correction=(1/(2*R))*log(ratio);


figure;plot(ra)
hold on;plot(rb,'r')
figure;plot(L)
figure;plot(out)
figure;plot(out2)
figure;plot(cosine_beta)
hold on;plot(cosine_theta,'r')
figure;plot(top)
hold on;plot(bottom,'r')
figure;plot(ratio)

figure;plot(correction)
figure;plot(CTthy1)
hold on;plot(correction,'r')
%%

[th,phi,r] = cart2sph(0.1*AllTrodes(:,1),0.1*AllTrodes(:,2),0.1*AllTrodes(:,3));
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
x = 6.*x  + 0.5;
y = 6.*y + 4;
z = 6.*z + 6;
figure
s = surf(x,y,z);
%set(s,'EdgeColor','none');
set(s,'FaceAlpha',0.25);
set(s,'FaceColor',[0.5 0.5 0.5]);
hold on
locs = 0.1*AllTrodes(1:64,:);
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