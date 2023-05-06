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
trmm_box=nansum(reshape(trmm_box,size(trmm_box,1)*size(trmm_box,2),6209))...
    ./nansum(cosd(lat_full(:)));

% trmm_box=trmm_anom.*cosd(lat_full);
% trmm_box=trmm_box(lon_re<=95 & lon_re>=75,lat_re<=10 & lat_re>=-10,:);
% trmm_box=nanmean(reshape(trmm_box,size(trmm_box,1)*size(trmm_box,2),6209));

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
events(events(:,5)<=25 | events(:,5)>=(6209-25),:)=[];

lon_re=30:2.5:180;
lat_re=-20:2.5:20;
[lat_full,lon_full]=meshgrid(lat_re,lon_re);

trmm_anom=squeeze(nansum(trmm_anom(lon_re>=60,:,:).*cosd(lat_full(lon_re>=60,:)),2));
trmm_anom=trmm_anom./nansum(cosd(lat_full(lon_re>=60,:)),2);

diagrams=NaN(51,49,size(events,1));

for i=1:size(events,1);
    diagrams(:,:,i)=(trmm_anom(:,(events(i,5)-25):(events(i,5)+25)))';
end
save diagrams diagrams 

%% kmeans
load('diagrams');
data_k=(reshape(diagrams((-10:20)+25+1,:,:),31*49,99))';
% [data_k,mu,sd]=zscore(data_k); Kmeans performs worse 
% k=kmeans(data_k,4); so I use SOM

som_used=som_make(zscore(data_k),'msize',[2 2]);
k=som_bmus(som_used,zscore(data_k));

for i=1:4;
    k_prop(i)=nansum(k==i);
end

diagrams_k=NaN(size(diagrams,1),size(diagrams,2),4);
ttest_k=NaN(size(diagrams,1),size(diagrams,2),4);

for i=1:4;
    diagrams_k(:,:,i)=nanmean(diagrams(:,:,k==i),3);
    for x=1:size(diagrams_k,1);
        for y=1:size(diagrams_k,2);
            ttest_k(x,y,i)=ttest(squeeze(diagrams(x,y,k==i)));
        end
    end
end
save diagrams_k diagrams_k ttest_k

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
    shading flat
    cmocean('balance');
    colorbar
    caxis([-0.15 0.15]);
end

%% speed estimation
load('diagrams_k');
lon=60:2.5:180;
lag=-25:25;

name_used={'Stand','Jump?','Slow','Fast'};

for i=1:4;
    subplot(2,2,i);
    map_here=diagrams_k(:,:,i);
    t_here=ttest_k(:,:,i);
    
    contourf(lon,lag,map_here,linspace(-0.18,0.18,20),'linestyle','none');
    colormap(cmocean('balance',20));
    caxis([-0.18 0.18]);
    hold on
    
    if ismember(i,[3 4]);
    event=bwlabel(map_here>0 & t_here>0);
    label_used=event(26,map_here(26,:)==nanmax(map_here(26,:)));
    
    event(event~=label_used(1))=0;
    event(event==label_used(1))=1;
    contour(lon,-25:25,event,[0 1],'color',[0.8500 0.3250 0.0980],'linewidth',3,'linestyle',':');
    hold on
    [x,y]=meshgrid(lon(:),lag(:));
    hold on
    [bw,sew_b,msew] = lscov([ones(length(y(event==1)),1) y(event==1)],x(event==1),map_here(event==1));
    %[bw,sew_b,msew] = lscov([ones(length(y(event==1)),1) y(event==1)],x(event==1));
    speed_full(i)=bw(2)*110000./(24*3600);
    end
    [x,y]=meshgrid(lon(:),lag(:));
    scatter(x(t_here>=0.5),y(t_here>=0.5),10,'k','filled');
    xlabel('Lon');
    ylabel('Lag');
    set(gca,'linewidth',2,'fontsize',16,'fontname','consolas');
    ttl = title(name_used{i},'fontsize',20,'fontname','consolas');
    ttl.Units = 'Normalize';
    ttl.Position(1) = 0;
    ttl.HorizontalAlignment = 'left';
    ttl.Color='k';
    
end
hp4=get(subplot(2,2,4),'Position');
s=colorbar('ticks',-0.25:0.05:0.25,'Position', [hp4(1)+hp4(3)+0.02  hp4(2)-0.02  0.01  0.95],'fontsize',16);





