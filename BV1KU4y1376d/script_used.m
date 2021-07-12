%% 太平洋 vs 北冰洋
load('sst');
load('colorbyr');
sst(abs(sst)>100)=nan; % 去掉缺失值
sst_mean=nanmean(sst,3);
figure('pos',[10 10 1000 400]);
subplot(1,2,1);
m_proj('stereographic','lat',0,'long',200,'radius',90);
m_contourf(lon,lat,sst_mean',linspace(0,40,300),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7]);
m_grid('xtick',[],'ytick',[]);
colormap(colorbyr);
caxis([0 30]);

subplot(1,2,2);
m_proj('stereographic','lat',90,'long',30,'radius',40);
m_contourf(lon,lat,sst_mean',linspace(0,40,300),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7]);
m_grid('xtick',[],'ytick',[]);
colormap(colorbyr);
caxis([0 30]);

hp4=get(subplot(1,2,2),'Position');
s=colorbar('Position', [hp4(1)+hp4(3)+0.01  hp4(2)-0.015  0.015  0.95],'fontsize',16,...
    'color','w');
s.Label.String='^{o}C';
s.Label.Color='W';
print -depsc -r600 dif_pacific_arctic.eps
clear

%% 平均气候态
load('sst');
load('colorbyr');
sst(abs(sst)>100)=nan; % 去掉缺失值
sst_mean=nanmean(sst,3);
figure('pos',[10 10 1000 400]);
m_proj('miller','lon',[0 360],'lat',[-60 60]);
m_contourf(lon,lat,sst_mean',linspace(0,40,300),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7]);
m_grid('xtick',[],'ytick',[]);
colormap(colorbyr);
caxis([0 30]);
s=colorbar('fontsize',14,'color','w');
s.Label.String='^{o}C';
s.Label.Color='W';
print -depsc -r600 mean_climatology.eps
clear

%% 季节气候态
load('sst');
load('colorbyr');
sst(abs(sst)>100)=nan; % 去掉缺失值
y=repmat((1982:2020)',12,1);
y=sort(y);% 年
m=repmat((1:12)',39,1);% 月

sst_season=NaN(360,180,12);
for i=1:12;
    index_here= m==i;
    sst_season(:,:,i)=nanmean(sst(:,:,index_here),3);
end

figure('pos',[10 10 1000 400]);
m_proj('miller','lon',[0 360],'lat',[-60 60]);
m_contourf(lon,lat,(sst_season(:,:,1))',linspace(0,40,300),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7]);
m_grid('xtick',[],'ytick',[]);
colormap(colorbyr);
caxis([0 30]);
s=colorbar('fontsize',14,'color','w');
s.Label.String='^{o}C';
s.Label.Color='W';
print -depsc -r600 jan_climatology.eps
clear

%% 差异值
load('sst');
load('colorbwr');
sst(abs(sst)>100)=nan; % 去掉缺失值
y=repmat((1982:2020)',12,1);
y=sort(y);% 年
m=repmat((1:12)',39,1);% 月

sst_anom=NaN(360,180,size(sst,3));
for i=1:12;
    index_here= m==i;
    sst_anom(:,:,index_here)=sst(:,:,index_here)-nanmean(sst(:,:,index_here),3);
end

enso_index=readtable('enso_index.xlsx','ReadRowNames',false,'readvariablenames',false);
enso_index=enso_index{:,:};
enso_index=enso_index(ismember(enso_index(:,1),1982:2020),2:13);
enso_index=enso_index';
enso_index=enso_index(:);

sst_ensop=nanmean(sst_anom(:,:,enso_index>0.5),3);

figure('pos',[10 10 1000 400]);
m_proj('miller','lon',[0 360],'lat',[-60 60]);
m_contourf(lon,lat,(sst_ensop)',linspace(-2,2,300),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7]);
m_grid('xtick',[],'ytick',[]);
colormap(colorbwr);
caxis([-2 2]);
s=colorbar('fontsize',14,'color','w');
s.Label.String='^{o}C';
s.Label.Color='W';