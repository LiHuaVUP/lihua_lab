%% regrid
lon_re=30:2.5:180;
lat_re=-20:2.5:20;

[lat_re,lon_re]=meshgrid(lat_re,lon_re);

load('imname');
for i=1:length(iname);
    tic
    data_name=[iname{i} '_' mname{i}];
    load(data_name);
    [lat,lon]=meshgrid(lat,lon);
    data_re=NaN(size(lon_re,1),size(lon_re,2),size(data_full,3));
    for j=1:size(data_full,3);
        data_here=data_full(:,:,j);
        F=scatteredInterpolant(lon(:),lat(:),data_here(:),'linear','nearest');
        data_re(:,:,j)=reshape(F(lon_re(:),lat_re(:)),size(lon_re,1),size(lon_re,2));
    end
    save(['re_' iname{i} '_' mname{i}],'data_re');
    toc
end

%% filter1
load('imname');
for i=1:length(iname);
    tic
    data_name=['re_' iname{i} '_' mname{i}];
    load(data_name);
    for m=1:size(data_re,1);
        for n=1:size(data_re,2);
            data_re(m,n,:)=filt1('bp',squeeze(data_re(m,n,:)),'fc',[1/100 1/20]);
        end
    end
    toc
    save(['filter_re_' iname{i} '_' mname{i}],'data_re');
end

%% corr
load('imname');
lon_re=30:2.5:180;
lat_re=-20:2.5:20;

for d=1:length(iname);
    tic
    data_name=['filter_re_' iname{d} '_' mname{d}];
    load(data_name);
    data_used=data_re.*repmat(cosd(lat_re),61,1,3650);
    
    % data_ref
    data_ref=data_used(lon_re>=85 & lon_re<=95,lat_re<=5 & lat_re>=-5,:);
    data_ref=nanmean(reshape(data_ref,size(data_ref,1)*size(data_ref,2),size(data_ref,3)));
    
    % data body
    data_anom=squeeze(nanmean(data_used(:,lat_re>=-10 & lat_re<=10,:),2));
    
    cor_used=NaN(61,61,2);
    
    for i=-30:30
        for j=1:size(data_anom,1)
            index_data=(1:3650)+i;
            index_ref=1:3650;
            
            index_ref(index_data<=0 | index_data>3650)=[];
            index_data(index_data<=0 | index_data>3650)=[];
            
            ref_here=data_ref(index_ref);
            data_here=data_anom(j,index_data);
            
            [b,bint]=regress(data_here(:),[ref_here(:)]);
            cor_used(i+31,j,1)=b(1);
            cor_used(i+31,j,2)=double(bint(1,1).*bint(1,2)>0);
        end
    end
    save(['cor_' iname{d} '_' mname{d}],'cor_used');
    toc
    
end

%% drawing correlation plot
load('imname');
lon_re=30:2.5:180;
lon_used=lon_re;
figure('pos',[10 10 1500 1500]);

for i=1:7
    data_name=['cor_' iname{i} '_' mname{i}];
    load(data_name);
    title_here=[iname{i} '-' mname{i}];
    if i~=7
    subplot(4,2,i);
    else
        subplot(4,2,i+0.5);
    end
    contourf(lon_re,-30:30,cor_used(:,:,1),linspace(-1,1,200),'linestyle','none');
    [x,y]=meshgrid(lon_used(:),(-30:30)');
    hold on
    scatter(x(cor_used(:,:,2)>=0.5),y(cor_used(:,:,2)>=0.5),0.5,'k','filled');
    hold on
    %scatter(track_full,trigger_full-31,10,[0.7 0.7 0.7],'filled');
    colormap(m_colmap('diverging'));
    xlim([30 180]);
    ylim([-30 30]);
    caxis([-1 1]);
    
    ttl = title(title_here);
    ttl.Units = 'Normalize';
    ttl.Position(1) = 0;
    ttl.HorizontalAlignment = 'left';
    ttl.Color='k';
    
    
    xlabel('lon');
    ylabel('lag');
    
    
    set(gca,'fontsize',8,'fontname','consolas');
    
end



