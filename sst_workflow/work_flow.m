% %% Reformat Data
% sst_full=double(ncread('sst_data.nc','sst'))-273.15;
% sst_full(abs(sst_full)>1000)=nan;
% 
% date_used=datevec(datenum(1979,1,1):1./2:datenum(2020,12,31)+1./2);
% date_d=unique(date_used(:,1:3),'rows');
% 
% sst_daily=NaN(size(sst_full,1),size(sst_full,2),size(date_d,1));
% 
% for i=1:size(date_d,1);
%     index_here=ismember(date_used(:,1:3),date_d(i,:),'rows');
%     sst_daily(:,:,i)=nanmean(sst_full(:,:,index_here),3);
% end
% 
% for i=1979:2020;
%     index_here=ismember(date_d(:,1),i);
%     sst=sst_daily(:,:,index_here);
%     save(['sst' num2str(i)],'sst');
% end

%% 1 - Construct Data
date_used=datevec(datenum(1979,1,1):1:datenum(2020,12,31));
sst_full=NaN(180,91,size(date_used,1));

for i=1979:2020;
    index_here=ismember(date_used(:,1),i);
    load(['sst' num2str(i)]);
    sst_full(:,:,index_here)=sst;
end
save sst_full sst_full
%% 2 - Daily to Monthly and Yearly
date_used=datevec(datenum(1979,1,1):1:datenum(2020,12,31));
date_m=unique(date_used(:,1:2),'rows');
date_y=unique(date_used(:,1),'rows');

load('sst_full');

sst_month=NaN(size(sst_full,1),size(sst_full,2),size(date_m,1));
sst_year=NaN(size(sst_full,1),size(sst_full,2),size(date_y,1));

for i=1:size(date_m,1);
    index_here=ismember(date_used(:,1:2),date_m(i,:),'rows');
    sst_month(:,:,i)=nanmean(sst_full(:,:,index_here),3);
end

for i=1:size(date_y,1);
    index_here=ismember(date_used(:,1),date_y(i,:),'rows');
    sst_year(:,:,i)=nanmean(sst_full(:,:,index_here),3);
end

save sst_month sst_month
save sst_year sst_year

%% 3 - Recenter Lon
load('lonlat','lon');
load('sst_full');
load('sst_month');
load('sst_year');

lon(lon<0)=360+(lon(lon<0));
[lon_re,i]=sort(lon);

sst_re=sst_full(i,:,:);
sst_re_m=sst_month(i,:,:);
sst_re_y=sst_year(i,:,:);
save sst_re sst_re* lon_re 

%% 4 - Basic Statistics
load('sst_re','sst_re');
% Mean
sst_mean=nanmean(sst_re,3);
% Median
sst_med=nanmedian(sst_re,3);
% 5% quantile
sst_5q=quantile(sst_re,0.05,3);
sst_95q=quantile(sst_re,0.95,3);
sst_50q=quantile(sst_re,0.5,3);
% Std
sst_std=nanstd(sst_re,0,3);
clear sst_re
save sst_stats sst_*

%% Drawing - Basic Statistics
addpath('/Volumes/mydirve/cloud_annual/m_map');
load('sst_stats');
load('sst_re','lon_re');
load('lonlat');

figure('pos',[10 10 1500 650],'color','k');
t=tiledlayout(2,3,'TileSpacing','Compact','Padding','Compact');
data_name={'sst_mean','sst_med','sst_std','sst_5q','sst_50q','sst_95q'};
title_name={'a) Mean','b) Median','c) Std','d) 5% Quantile','e) 50% Quantile','f) 95% Quantile'};

for i=1:6
    nexttile;
    m_proj('miller','lon',[0 360],'lat',[-90 90]);
    if i~=3;
    m_contourf(lon_re,lat,(eval(data_name{i}))',linspace(-2,30,200),'linestyle','none');
    else
        m_contourf(lon_re,lat,(eval(data_name{i}))',linspace(0,12,200),'linestyle','none');
    end
    m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
    m_grid('fontsiz',12,'linestyle','none','color','w');
    colormap(m_colmap('jet'));
    s=colorbar('color','w');
    title(s,'^{o}C','color','w');
    if i~=3
        caxis([0 32]);
    else
        caxis([0 8]);
    end
    ttl = title(title_name{i});
    ttl.Units = 'Normalize';
    ttl.Position(1) = 0;
    ttl.HorizontalAlignment = 'left';
    ttl.Color='w';
end

print -dpng -r600 basic_stats.png

%% 5 - Seasonality (Monthly)
load('sst_re');
date_used=datevec(datenum(1979,1,1):1:datenum(2020,12,31));

sst_season=NaN(size(sst_re,1),size(sst_re,2),12);

for i=1:12;
    sst_season(:,:,i)=nanmean(sst_re(:,:,date_used(:,2)==i),3);
end
save sst_season sst_season

%% Drawing - Seasonality (Monthly)
load('sst_season');
load('sst_stats','sst_mean');
load('sst_re','lon_re');
load('lonlat');

figure('pos',[10 10 1500 1200],'color','k');
t=tiledlayout(3,4,'TileSpacing','Compact','Padding','Compact');

title_full={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

for i=1:12

ax=nexttile;
m_proj('miller','lon',[0 360],'lat',[-90 90]);
m_contourf(lon_re,lat,(sst_season(:,:,i)-sst_mean)',linspace(-12,12,300),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
m_grid('fontsiz',12,'linestyle','none','color','w');
colormap(m_colmap('diverging'));
caxis([-4 4]);
ttl = title(title_full{i});
ttl.Units = 'Normalize'; 
ttl.Position(1) = 0; 
ttl.HorizontalAlignment = 'left';  
ttl.Color='w';

if ismember(i,[12 4 8]);
    s=colorbar(ax,'color','w');
end

end
print -dpng -r600 seasonality.png
%% 6 - Anomaly
load('sst_re');
load('sst_month');

date_daily=datevec(datenum(1979,1,1):datenum(2020,12,31));
date_month=unique(date_daily(:,1:2),'rows');

unique_d=unique(date_daily(:,2:3),'rows');
unique_m=(1:12)';

sst_anom_d=NaN(size(sst_re));
sst_anom_m=NaN(size(sst_re_m));

for i=1:size(unique_d,1);
    index_here=ismember(date_daily(:,2:3),unique_d(i,:),'rows');
    sst_anom_d(:,:,index_here)=sst_re(:,:,index_here) - ...
        nanmean(sst_re(:,:,index_here),3);
end

for i=1:size(unique_m,1);
    index_here=ismember(date_month(:,2),unique_m(i,:),'rows');
    sst_anom_m(:,:,index_here)=sst_re_m(:,:,index_here) - ...
        nanmean(sst_re_m(:,:,index_here),3);
end

save sst_anom sst_anom_d sst_anom_m

%% 7 - Spatial Average
% Indian Ocean [20 - 110, -20 - 30]
% North Pacific [120 - 240, 0 - 66.5]
% South Pacific [140 - 300, -66.5 - 0]
% North Atlantic [<5 >285, 0 - 66.5]
% Equatorial Pacific [120 - 280, -20 - 20]
load('sst_anom');
load('sst_re','sst_re_y','lon_re');
load('lonlat','lat');

[lat,lon]=meshgrid(lat,lon_re);

data_name={'sst_anom_d','sst_anom_m','sst_re_y'};

output_name={'local_d','local_m','local_r'};

for i=1:length(data_name);
    eval([data_name{i} '=' data_name{i} '.*repmat(cosd(lat),1,1,size(' data_name{i} ',3));'])
    eval([output_name{i} '=NaN(size(' data_name{i} ',3),6);'])
    eval(['d3=' data_name{i} ';'])
    d2=permute(d3,[3 1 2]); 
    d2=reshape(d2,size(d2,1),size(d2,2)*size(d2,3));
    
    % Indian Ocean
    ts_here=nanmean(d2(:,lon(:)>=20 & lon(:)<=110 & lat(:)>=-20 & lat(:)<=30),2);
    eval([output_name{i} '(:,1)=ts_here;'])
    
    % North Pacific
    ts_here=nanmean(d2(:,lon(:)>=120 & lon(:)<=240 & lat(:)>=0 & lat(:)<=66.5),2);
    eval([output_name{i} '(:,2)=ts_here;'])
    
    % South Pacific
    ts_here=nanmean(d2(:,lon(:)>=140 & lon(:)<=300 & lat(:)>=-66.5 & lat(:)<=0),2);
    eval([output_name{i} '(:,3)=ts_here;'])
    
    % North Atlantic
    ts_here=nanmean(d2(:,(lon(:)<=5 | lon(:)>=110) & lat(:)>=0 & lat(:)<=66.5),2);
    eval([output_name{i} '(:,4)=ts_here;'])
    
    % Eq Pacific
    ts_here=nanmean(d2(:,lon(:)>=120 & lon(:)<=280 & lat(:)>=-20 & lat(:)<=20),2);
    eval([output_name{i} '(:,5)=ts_here;'])
    
    % Global
    ts_here=nanmean(d2(:,abs(lat(:))<66.5),2);
    eval([output_name{i} '(:,6)=ts_here;'])
end

save sst_spatial local*

%% Drawing - Spatial Average
load('sst_spatial');
date_daily=datenum(1979,1,1):datenum(2020,12,31);
date_vec=datevec(date_daily);
date_month=unique(date_vec(:,1:2),'rows');
date_month=datenum([date_month 15*ones(size(date_month,1),1)]);
date_year=unique(date_vec(:,1),'rows');
date_year=datenum([date_year 6*ones(size(date_year,1),1) ones(size(date_year,1),1)]);

figure('pos',[10 10 1200 800]);
t=tiledlayout(3,5,'TileSpacing','Compact','Padding','Compact');

nexttile(t,2,[2 3]);
m_proj('miller','lon',[0 360],'lat',[-90 90]);
[CS,CH]=m_etopo2('contourf',[-12000:200:12000],'edgecolor','none');
colormap([ m_colmap('blues',80); m_colmap('gland',80)]);
m_coast('color','k','linewidth',2);
m_grid('linestyle','none','color','k','fontsize',10);
s=colorbar('color','k');
caxis([-10000 10000]);
ttl = title('b) Topography');
ttl.Units = 'Normalize'; 
ttl.Position(1) = 0; 
ttl.HorizontalAlignment = 'left';  
ttl.Color='k';

% Indian Ocean [20 - 110, -20 - 30]
% North Pacific [120 - 240, 0 - 66.5]
% South Pacific [140 - 300, -66.5 - 0]
% North Atlantic [<5 >285, 0 - 66.5]
% Equatorial Pacific [120 - 280, -20 - 20]

tile_loc=[6 5 10 1 14 12];
title_used={'d) Indian Ocean','c) North Pacific','e) South Pacific',...
    'a) North Atlantic','g) Equatorial Pacific','f) Global'};

for i=1:6;
    
    ax1=nexttile(t,tile_loc(i));
    h1=plot(date_daily,local_d(:,i),'linewidth',1,'color','r');
    hold on
    h2=plot(date_month,local_m(:,i),'linewidth',1,'color','k');
    xlim([datenum(1979,1,1) datenum(2020,12,31)]);
    
    ax2=axes('position',ax1.Position);
    h3=plot(date_year,local_r(:,i),'linewidth',1,'color','b');
    set(ax2,'color','none');
    set(ax2,'yaxislocation','right');
    set(ax2,'xtick',[]);
    xlim([datenum(1979,1,1) datenum(2020,12,31)]);
    
    ttl = title(title_used{i});
    ttl.Units = 'Normalize';
    ttl.Position(1) = 0;
    ttl.HorizontalAlignment = 'left';
    ttl.Color='k';
    set(ax1,'ycolor','r');
    set(ax2,'ycolor','b');
    set(ax1,'xtick',datenum(1979,6,1):365.5*10:datenum(2020,6,1),'xticklabels',...
        1979:10:2020);
    
    ax1.Box='off';
    ax2.Box='off';
    
     eval(['ax' num2str(tile_loc(i)) '1=ax1;'])
     eval(['ax' num2str(tile_loc(i)) '2=ax2;'])
     
     if i==6;
         legend([h1 h2 h3],{'Daily','Monthly','Yearly'});
     end
    
end

print -dpng -r600 sst_spatial.png

ax102.Position=ax101.Position;
ax12.Position=ax11.Position;
ax122.Position=ax121.Position;
ax52.Position=ax51.Position;
ax62.Position=ax61.Position;
ax142.Position=ax141.Position;

%% 8 - Linear Trend
load('sst_anom','sst_anom_m');
sst_anom_d=sst_anom_m;
coef_sst=NaN(size(sst_anom_d,1),size(sst_anom_d,2));
cint_sst=NaN(size(sst_anom_d,1),size(sst_anom_d,2),2);
time_full=(1:size(sst_anom_d,3))';

for i=1:size(sst_anom_d,1);
    tic
    for j=1:size(sst_anom_d,2);
        ts_here=squeeze(sst_anom_d(i,j,:));
        
        if nansum(isnan(ts_here))~=length(ts_here);
            [b,bint]=regress(ts_here,[ones(length(ts_here),1) time_full]);
            coef_sst(i,j)=b(2);
            cint_sst(i,j,:)=bint(2,:);
        end
    end
    toc
end
save coef_sst coef_sst cint_sst

%% Drawing - Linear Trend
load('coef_sst');
load('sst_re','lon_re');
load('lonlat','lat');
[lat,lon]=meshgrid(lat,lon_re);
cint_sst(abs(repmat(lat,1,1,2))>80)=0;

figure('pos',[10 10 1200 800]);
m_proj('miller','lon',[0 360],'lat',[-90 90]);
m_contourf(lon,lat,coef_sst*120,linspace(-1.5,1.5,300),'linestyle','none');
hold on
m_scatter(lon((cint_sst(:,:,1).*cint_sst(:,:,2))>0),lat((cint_sst(:,:,1).*cint_sst(:,:,2))>0),5,'k','filled');
m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
m_grid('fontsize',14,'linestyle','none');
caxis([-1 1]);
colormap(m_colmap('diverging'));
s=colorbar('fontsize',16);
title(s,'^{o}C/decade','fontsize',12);
print -dpng -r600 sst_trend.png

%% 9 - Moving Trend
load('sst_spatial','local_m');
date_daily=datevec(datenum(1979,1,1):datenum(2020,12,31));
date_month=unique(date_daily(:,1:2),'rows');

mtrend=NaN(length(1979:2020),6);
mint=NaN(length(1979:2020),6,2);

for i=1981:2018;
    year_here=(i-2):(i+2);
    index_here=ismember(date_month(:,1),year_here);
    ts_here=local_m(index_here,:);
    
    for j=1:6;
        [b,bint]=regress(ts_here(:,j),[ones(length(ts_here),1) (1:length(ts_here))']);
        mtrend(i-1979+1,j)=b(2);
        mint(i-1979+1,j,:)=bint(2,:);
    end

end
save sst_moving_trend m*

%% Drawing - Moving Trend
% Indian Ocean [20 - 110, -20 - 30]
% North Pacific [120 - 240, 0 - 66.5]
% South Pacific [140 - 300, -66.5 - 0]
% North Atlantic [<5 >285, 0 - 66.5]
% Equatorial Pacific [120 - 280, -20 - 20]
figure('pos',[10 10 1200 800]);
load('sst_moving_trend.mat')
legend_used={'Indian Ocean','North Pacific','South Pacific','North Atlantic',...
    'Equatorial Pacific','Global'};
color=[0 0.4470 0.7410;...
    [0.8500 0.3250 0.0980];
    [0.9290 0.6940 0.1250];
    [0.4940 0.1840 0.5560];
    [0.4660 0.6740 0.1880];
    [0 0 0]];
for i=1:6;
    h=errorbar((1979:2020)',mtrend(:,i)*120,(mint(:,i,2)-mint(:,i,1))*120./2,...
        '-s','MarkerSize',10,'linewidth',2,'markeredgecolor',color(i,:),'markerfacecolor',color(i,:),...
        'color',color(i,:));
    hold on
    eval(['h' num2str(i) '=h'])
end
yline(0,'--');
legend([h1 h2 h3 h4 h5 h6],legend_used,'location','best','fontsize',12);
set(gca,'fontsize',16);
ylabel('^{o}C/decade');
print -dpng -r600 sst_moving_trend.png