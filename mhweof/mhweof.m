%% Geomap
m_etopo2('contourf',[-9000:500:9000],'edgecolor','none');
m_grid('linewidth',2,'fontname','consolas');
colormap([ m_colmap('blues',80); m_colmap('gland',80)]);
caxis([-8000 8000]);

%% Loading data
date_used=datevec(datenum(1993,1,1):datenum(2016,12,31));
mhw_ts=NaN(32,32,size(date_used,1));
for i=1993:2016
    load(['mhw' num2str(i)])
    idx_here=date_used(:,1)==i;
    mhw_ts(:,:,idx_here)=mhw_here;
end

%% Preparing EOF data
% Generating date matrix
date_used=datevec(datenum(1993,1,1):datenum(2016,12,31));

% Annual MHW days
mhwdays=NaN(32,32,2016-1993+1);
for i=1993:2016
    idx_here=date_used(:,1)==i;
    d_here=sum(~isnan(mhw_ts(:,:,idx_here)),3,'omitnan');
    d_here(land_index)=nan;
    mhwdays(:,:,i-1993+1)=d_here;
end
%% EOF analysis
% EOF - manual
load('lon_lat');
[lat2,~]=meshgrid(lat_used,lon_used);
% weighted by spatial grid
data=mhwdays.*sqrt(cosd(repmat(lat2,1,1,24)));
% reshape from 3d to 2d
data=(reshape(data,size(mhw_ts,1)*size(mhw_ts,2),24))';
% get rid of land data
data=data(:,~land_index);
% remove linear trend
F=detrend(data,1);
% remove mean
F=detrend(F,0);
% calculating cov matrix
C=F'*F;
% performing EOF analysis
[EOFs,D]=eig(C);
PCs=EOFs'*F';

D=diag(D);
D=D./nansum(D);
% EOFs is the spatial EOF patterns, PCs is the corresponding principal
% component time series, and D is the corresponding explained variance.

% find the first EOF pattern
[Ds,i]=sort(D,'descend');
EOF1=EOFs(:,i(1));
PC1=PCs(i(1),:);
Ds(1:2)
% Here we can see the first EOF pattern explains 56.38% of total variance,
% while the second EOF pattern only explains 8.69%. Therefore, we only
% focus on the first EOF pattern here.

% reshape EOF1 from 2d to 3d
sEOF1=NaN(size(mhw_ts,1)*size(mhw_ts,2),1);
sEOF1(~land_index)=EOF1;
sEOF1=reshape(sEOF1,size(mhw_ts,1),size(mhw_ts,2));

sEOF1=sEOF1.*nanstd(PC1);
PC1=PC1./nanstd(PC1);

%% EOF visualization
figure
subplot(2,1,1);
m_proj('miller','lon',[nanmin(lon_used) nanmax(lon_used)],'lat',[nanmin(lat_used) nanmax(lat_used)]);
m_pcolor(lon_used,lat_used,sEOF1');
shading interp
m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
m_grid('linewidth',2,'fontname','consolas');
colormap(m_colmap('jet'));
caxis([0 40]);
s=colorbar('fontname','consolas','fontsize',12);
title(s,'days/year','fontname','consolas');
set(gca,'fontsize',12)
title('EOF1: 56.31%','fontsize',16,'fontname','consolas');

subplot(2,1,2);
plot(1:24,PC1,'r','linewidth',2);
set(gca,'xtick',1:24,'xticklabels',1993:2016,'fontname','consolas','fontsize',12);
xlabel('Year','fontname','consolas');
ylabel('PC1','fontname','consolas');
xlim([1 24]);
set(gca,'fontsize',12,'linewidth',2)
xtickangle(90);
title('PC1: 56.31%','fontsize',16,'fontname','consolas');