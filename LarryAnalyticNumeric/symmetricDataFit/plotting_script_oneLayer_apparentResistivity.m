
load('the_data.mat')
combined = 4*symmetric./symthy2;
combined(combined == 0) = nan;


cmap = colormap('hot');
cmap = flipud(cmap);

figure;
imagesc(combined)
colormap(cmap)
set(gca,'fontsize',14);
title('Apparent resistivity across electrodes')

ax = gca;
ax.Visible = 'off';
c = colorbar;
caxis([0 6])
c.Label.String = 'apparent resistivity (Ohm/m)';

figure;
h1 = histogram(combined);
h1.Normalization = 'probability';
h1.BinWidth = 0.05;
xlim([0 6])
xlabel('apparent resistivity (Ohm/m)')
set(gca,'fontsize',14);
title('histogram of apparent resistivity values across electrodes')
%%

figure;
subplot(1,2,1)
imagesc(combined)
colormap(cmap)
set(gca,'fontsize',14);
ax = gca;
ax.YTick = '';
ax.XTick = '';
ax.Title.String = 'Apparent resistivity across electrodes';

c = colorbar;
caxis([0 6])
c.Label.String = 'apparent resistivity (Ohm/m)';

subplot(1,2,2)
h1 = histogram(combined);
h1.Normalization = 'probability';
h1.BinWidth = 0.05;
xlim([0 6])
xlabel('apparent resistivity (Ohm/m)')
title('histogram of apparent resistivity values across electrodes')
set(gca,'fontsize',14);
