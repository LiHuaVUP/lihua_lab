% %% Reformat Data
% lon(lon<0)=360+(lon(lon<0));
% [lon_re,i]=sort(lon);
% 
% sst_re_m=sst_anom_m(i,:,:);
% 
% ssta=sst_anom_m(lon_re<=300 & lon_re>=120,lat<=30 & lat>=-30,:);
% lona=lon_re(lon_re<=300 & lon_re>=120);
% lata=lat(lat<=30 & lat>=-30);

%% EOF - Direct Calculation
load('ssta');
[lats,lons]=meshgrid(lata,lona);
ssta=ssta.*repmat(sqrt(cosd(lats)),1,1,504);

ssta=(reshape(ssta,91*31,504))';
nanindex=isnan(nanmean(ssta));
ssta=ssta(:,~nanindex);

F=detrend(ssta,0);
C=F'*F;

[EOFs,D]=eig(C);
PCs=EOFs'*F';

D=diag(D);
D=D./nansum(D);

EOF1=EOFs(:,D==nanmax(D));
PC1=PCs(D==nanmax(D),:);

sEOF1=NaN(91*31,1);
sEOF1(~nanindex)=EOF1;
sEOF1=reshape(sEOF1,91,31);

sEOF1=sEOF1.*nanstd(PC1);
PC1=PC1./nanstd(PC1);

figure
subplot(2,1,1);
m_proj('miller','lon',[nanmin(lona) nanmax(lona)],'lat',[nanmin(lata) nanmax(lata)]);
m_contourf(lona,lata,sEOF1',linspace(-1.4,1.4,200),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
m_grid('linewidth',2,'fontname','consolas');
colormap(m_colmap('diverging'));
caxis([-1.4 1.4]);
s=colorbar('fontname','consolas','fontsize',12);
title(s,'^{o}C','fontname','consolas');
set(gca,'fontsize',12)
title('EOF1: 34.92%','fontsize',16,'fontname','consolas');

subplot(2,1,2);
plot(1:504,PC1,'r','linewidth',2);
set(gca,'xtick',[6:60:504],'xticklabels',1980:5:2021,'fontname','consolas','fontsize',12);
xlabel('Year','fontname','consolas');
ylabel('PC1','fontname','consolas');
xlim([1 504]);
set(gca,'fontsize',12,'linewidth',2)
title('PC1: 34.92%','fontsize',16,'fontname','consolas');

%% EOF - CDT
load('ssta');
[lats,lons]=meshgrid(lata,lona);
ssta=ssta.*repmat(sqrt(cosd(lats)),1,1,504);
[eof_maps,pc,expvar]=eof(ssta);
eof1=eof_maps(:,:,1);
pc1=(pc(1,:))';
eof1=eof1.*nanstd(pc1);
pc1=pc1./nanstd(pc1);

figure
subplot(2,1,1);
m_proj('miller','lon',[nanmin(lona) nanmax(lona)],'lat',[nanmin(lata) nanmax(lata)]);
m_contourf(lona,lata,eof1',linspace(-1.4,1.4,200),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
m_grid('linewidth',2,'fontname','consolas');
colormap(m_colmap('diverging'));
caxis([-1.4 1.4]);
s=colorbar('fontname','consolas','fontsize',12);
title(s,'^{o}C','fontname','consolas');
set(gca,'fontsize',12)
title('EOF1: 34.92%','fontsize',16,'fontname','consolas');

subplot(2,1,2);
plot(1:504,pc1,'r','linewidth',2);
set(gca,'xtick',[6:60:504],'xticklabels',1980:5:2021,'fontname','consolas','fontsize',12);
xlabel('Year','fontname','consolas');
ylabel('PC1','fontname','consolas');
xlim([1 504]);
set(gca,'fontsize',12,'linewidth',2)
title('PC1: 34.92%','fontsize',16,'fontname','consolas');

%% EOF - PCA
load('ssta');
[lats,lons]=meshgrid(lata,lona);
ssta=ssta.*repmat(sqrt(cosd(lats)),1,1,504);

ssta=(reshape(ssta,91*31,504))';
nanindex=isnan(nanmean(ssta));
ssta=ssta(:,~nanindex);

F=detrend(ssta,0);
[coef,score,latent]=pca(F);
latent=latent./nansum(latent);

scoef1=NaN(91*31,1);
scoef1(~nanindex)=coef(:,1);
scoef1=reshape(scoef1,91,31);

score1=score(:,1);
scoef1=scoef1.*nanstd(score1);
score1=score1./nanstd(score1);

figure
subplot(2,1,1);
m_proj('miller','lon',[nanmin(lona) nanmax(lona)],'lat',[nanmin(lata) nanmax(lata)]);
m_contourf(lona,lata,scoef1',linspace(-1.4,1.4,200),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
m_grid('linewidth',2,'fontname','consolas');
colormap(m_colmap('diverging'));
caxis([-1.4 1.4]);
s=colorbar('fontname','consolas','fontsize',12);
title(s,'^{o}C','fontname','consolas');
set(gca,'fontsize',12)
title('EOF1: 34.92%','fontsize',16,'fontname','consolas');

subplot(2,1,2);
plot(1:504,score1,'r','linewidth',2);
set(gca,'xtick',[6:60:504],'xticklabels',1980:5:2021,'fontname','consolas','fontsize',12);
xlabel('Year','fontname','consolas');
ylabel('PC1','fontname','consolas');
xlim([1 504]);
set(gca,'fontsize',12,'linewidth',2)
title('PC1: 34.92%','fontsize',16,'fontname','consolas');
