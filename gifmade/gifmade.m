load('sst_p');
date_used=datevec(datenum(2010,1,1):datenum(2010,12,31));
sst_gif=NaN(180,91,12);

for i=1:12;
    index_here=date_used(:,2)==i;
    sst_gif(:,:,i)=nanmean(sst(:,:,index_here),3);
end

sst_gif=sst_gif-nanmean(sst,3);

%% Gif - Png
m_proj('miller','lon',[-180 180],'lat',[-66 66]);
m_name={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

for i=1:12;
    figure
    m_contourf(lon,lat,(sst_gif(:,:,i))',linspace(-18,18,200),'linestyle','none');
    m_coast('patch',[0.7 0.7 0.7]);
    m_grid('fontsize',12,'fontname','consolas','linewidth',2,'linestyle','none');
    colormap(m_colmap('divergence'))
    caxis([-6 6]);
    title_here=['2010-' m_name{i}];
    title(title_here,'fontsize',16,'fontname','consolas');
    s=colorbar('fontname','consolas','fontsize',12);
    s.Label.String='^{o}C';
    print('-dpng','-r600',['sst2010-' num2str(i)]);
    close all
end

for i=1:12;
    im=imread(['sst2010-' num2str(i) '.png']);
    [I,map]=rgb2ind(im,256);
    if i==1
        imwrite(double(I),map,'sst2010.gif','gif', 'Loopcount',inf,'DelayTime',1);
    else
        imwrite(double(I),map,'sst2010.gif','gif','WriteMode','append','DelayTime',1);
    end
    close
end

%% Gif - Instant
m_proj('miller','lon',[-180 180],'lat',[-66 66]);
m_name={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

for i=1:12;
    figure
    m_contourf(lon,lat,(sst_gif(:,:,i))',linspace(-18,18,200),'linestyle','none');
    m_coast('patch',[0.7 0.7 0.7]);
    m_grid('fontsize',12,'fontname','consolas','linewidth',2,'linestyle','none');
    colormap(m_colmap('divergence'))
    caxis([-6 6]);
    title_here=['2010-' m_name{i}];
    title(title_here,'fontsize',16,'fontname','consolas');
    s=colorbar('fontname','consolas','fontsize',12);
    s.Label.String='^{o}C';
    set(gcf,'color','w');
    frame=getframe(gcf);
    im=frame2im(frame);
    [I,map]=rgb2ind(im,256);
    if i==1
        imwrite(I,map,'sst2010_r.gif','gif', 'Loopcount',inf,'DelayTime',1);
    else
        imwrite(I,map,'sst2010_r.gif','gif','WriteMode','append','DelayTime',1);
    end
    close
end

