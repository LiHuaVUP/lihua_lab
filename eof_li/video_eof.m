%% EOF Manual
% Calculation of Covariance Matrix
F=detrend(F,0);C=F'*F;

% Eig Analysis
[EOFs,D]=eig(C);
PCs=EOFs'*F';

see=(EOFs*PCs)';

% Explained Variance
D(D<=0)=0;
lambda=diag(D)./nansum(diag(D));

%% Read and Format Data
load('precip_clim');
load('loc_unique');
precip_msd=NaN(987,366);

for i=1:size(loc_unique,1);
    loc_here=loc_unique(i,:);
    precip_msd(i,:)=squeeze(precip_clim(loc_here(1),loc_here(2),:));
end

%% EOF analysis (需要Climate Data Toolbox）
load('lon_lat_ncep');
[eofs,pcs,expvar]=eof(reshape(precip_msd.*...
    sqrt(cosd(lat_ncep(loc_unique(:,2)))),987,1,366));
eof1=eofs(:,:,1).*std(pcs(1,:));
pc1=pcs(1,:)./std(pcs(1,:));
%% Drawing
eof1p=NaN(120,60);

for i=1:size(loc_unique,1);
    loc_here=loc_unique(i,:);
    eof_here=eof1(i);
    eof1p(loc_here(1),loc_here(2))=eof_here;
end

% 不加负号
load('lon_lat_ncep.mat')
figure('pos',[10 10 800 1500]);
m_proj('miller','lon',[180+60 180+120],'lat',[0 30]);
tiledlayout(2,1,'Tilespacing','compact');

nexttile
m_contourf(lon_ncep,lat_ncep,eof1p',-6:0.01:0.1,'linestyle','none');
m_coast();
m_grid('fontsize',16);
colormap(m_colmap('jet',11));
caxis([-6 0]);
title('EOF1 (77.2%)','fontsize',16);
s=colorbar('fontsize',16);
s.Label.String='mm/day';

nexttile
anomaly(1:366,pc1,'linewidth',2);
set(gca,'xtick',[datenum(2016,1,15):30:datenum(2016,12,31)]-datenum(2016,1,1)+1,'xticklabels',{'J','F',...
    'M','A','M','J','J','A','S','O','N','D'},'fontsize',16);
set(gca,'fontsize',16);
title('PC1','fontsize',16);

% 加负号
figure('pos',[10 10 800 1500]);
tiledlayout(2,1,'Tilespacing','compact');

nexttile
m_contourf(lon_ncep,lat_ncep,-eof1p',-0.1:0.01:6,'linestyle','none');
m_coast();
m_grid('fontsize',16);
colormap(m_colmap('jet',11));
caxis([0 6]);
title('EOF1 (77.2%)','fontsize',16);
s=colorbar('fontsize',16);
s.Label.String='mm/day';

nexttile
anomaly(1:366,-pc1,'linewidth',2);
set(gca,'xtick',[datenum(2016,1,15):30:datenum(2016,12,31)]-datenum(2016,1,1)+1,'xticklabels',{'J','F',...
    'M','A','M','J','J','A','S','O','N','D'},'fontsize',16);
set(gca,'fontsize',16);
title('PC1','fontsize',16);
