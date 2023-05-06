%% TRMM anomaly
load('trmm_re');
lon_re=30:2.5:180;
lat_re=-20:2.5:20;

date_used=datevec(datenum(1998,1,1):datenum(2014,12,31));
u_md=unique(date_used(:,2:3),'rows');
trmm_anom=NaN(size(trmm_re));

for i=1:size(u_md,1);
    index_here=date_used(:,2)==u_md(i,1) & ...
        date_used(:,3)==u_md(i,2);
    trmm_anom(:,:,index_here)=trmm_re(:,:,index_here)-...
        nanmean(trmm_re(:,:,index_here),3);
end
save trmm_anom trmm_anom

%% TRMM filter
load('trmm_anom');
lon_re=30:2.5:180;
lat_re=-20:2.5:20;
for i=1:size(trmm_anom,1);
    tic
    for j=1:size(trmm_anom,2);
        ts_here=squeeze(trmm_anom(i,j,:));
        ts_here(isnan(ts_here))=interp1(find(~isnan(ts_here)),...
            ts_here(~isnan(ts_here)),find(isnan(ts_here)),'linear','extrap');
        trmm_anom(i,j,:)=filt1('bp',ts_here,'fc',[1/100 1/20]);
    end
    toc
end
save trmm_re_filter trmm_anom

%% Event detection
load('trmm_re_filter');
lon_re=30:2.5:180;
lat_re=-20:2.5:20;
[lat_full,lon_full]=meshgrid(lat_re,lon_re);
trmm_box=trmm_anom.*cosd(lat_full);
trmm_box=trmm_box(lon_re<=95 & lon_re>=75,lat_re<=10 & lat_re>=-10,:);
trmm_box=nanmean(reshape(trmm_box,size(trmm_box,1)*size(trmm_box,2),6209));

event_label=bwlabel(trmm_box>=nanstd(trmm_box));
events=NaN(nanmax(event_label),5);
for i=1:nanmax(event_label);
    idx=find(event_label==i);
    events(i,1)=i;
    events(i,2)=idx(1);
    events(i,3)=idx(end);
    events(i,4)=idx(end)-idx(1)+1;
    events(i,5)=idx(trmm_box(idx)==nanmax(trmm_box(idx)));
end
save events_trmm events

%% Diagram generation
load('trmm_re_filter');
load('events_trmm');
events(events(:,4)<5,:)=[];
events(events(:,5)<=20 | events(:,5)>6189,:)=[];

lon_re=30:2.5:180;
trmm_anom=squeeze(nanmean(trmm_anom(lon_re>=60,:,:),2));

diagrams=NaN(41,49,size(events,1));

for i=1:size(events,1);
    diagrams(:,:,i)=(trmm_anom(:,(events(i,5)-10):(events(i,5)+20)))';
end
save diagrams diagrams

%% kmeans
load('diagrams');
data_k=(reshape(diagrams(11:end,:,:),31*49,99))';
% [data_k,mu,sd]=zscore(data_k); Kmeans performs worse 
% k=kmeans(data_k,4); so I use SOM

som_used=som_make(data_k,'msize',[4 1]);
k=som_bmus(som_used,data_k);

for i=1:4;
    map_here=nanmean(diagrams(:,:,k==i),3);
    ttest_here=NaN(size(map_here));
    for x=1:size(map_here,1);
        for y=1:size(map_here,2);
            ttest_here(x,y)=ttest(squeeze(diagrams(x,y,k==i)));
        end
    end
    figure
    map_here(ttest_here<1)=NaN;
    pcolor(map_here)
    cmocean('balance');
    colorbar
    caxis([-0.15 0.15]);
end





