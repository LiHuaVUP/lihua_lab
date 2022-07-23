load('sst');
sst(abs(sst)>100)=nan;
load('lonlat');
[lat,lon]=meshgrid(lat,lon);
sst2=nanmean(reshape(sst,360*180,1827).* cosd(lat(:)));
load('t');
date_used=datevec(datenum(1870,1,1)+t);
date_used=date_used(:,1:2);

sst_anom=NaN(1827,1);

for i=1:12;
    index_here=date_used(:,2)==i;
    sst_anom(index_here)=sst2(index_here)-nanmean(sst2(index_here));
end

trend_metric=NaN(length(1950:2010),length(1960:2020),2);

for i=1950:2010;
    for j=i+10:2020;
        sst_trend=sst_anom(date_used(:,1)<=j & date_used(:,1)>=i);
        [b,bint]=regress(sst_trend(:),[ones(length(sst_trend),1) (1:length(sst_trend))']);
        trend_metric(i-1950+1,j-1960+1,1)=b(2);
        trend_metric(i-1950+1,j-1960+1,2)=double(bint(2,1).*bint(2,2)>0);
    end
end

pcolor((trend_metric(:,:,1))'*120);
shading flat
set(gca,'xtick',1:61,'xticklabels',1950:2010);
set(gca,'ytick',1:61,'yticklabels',1960:2020);
xtickangle(90);
set(gca,'fontname','consolas','fontsize',8);
colormap(cmocean('balance'));
s=colorbar('fontname','consolas');
set(gca,'ydir','reverse');


