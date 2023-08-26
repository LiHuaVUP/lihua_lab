%% daily to monthly
date_used=datevec(datenum(1982,1,1):datenum(2016,12,31));
u_ym=unique(date_used(:,1:2),'rows');
ssttas=NaN(32,32,size(u_ym,1));
for i=1:size(u_ym,1)
    idx_here=date_used(:,1)==u_ym(i,1) & ...
        date_used(:,2)==u_ym(i,2);
    ssttas(:,:,i)=nanmean(sst_anom(:,:,idx_here),3);
end
lontas=lon_used;lattas=lat_used;
save ssttas ssttas lontas lattas

%% EOF 
load('ssta');
[lats,lons]=meshgrid(lata,lona);
ssta=ssta.*repmat(sqrt(cosd(lats)),1,1,504);
[eof_maps,pc,expvar]=eof(ssta);
for i=1:3
    if i~=2
        eofs(:,:,i)=eof_maps(:,:,i);
        pcs(:,i)=(pc(i,:))';
    else
        eofs(:,:,i)=-eof_maps(:,:,i);
        pcs(:,i)=-(pc(i,:))';
    end
    eofs(:,:,i)=eofs(:,:,i).*nanstd(pcs(:,i));
    pcs(:,i)=pcs(:,i)./nanstd(pcs(:,i));
end

figure('pos',[143   336   912   469]);
for i=1:3
subplot(3,2,1+(i-1)*2);
m_proj('miller','lon',[nanmin(lona) nanmax(lona)],'lat',[nanmin(lata) nanmax(lata)]);
m_contourf(lona,lata,(eofs(:,:,i))',linspace(-1.4,1.4,200),'linestyle','none');
m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
m_grid('linewidth',2,'fontname','consolas');
colormap(m_colmap('diverging'));
caxis([-1.4 1.4]);
s=colorbar('fontname','consolas','fontsize',12);
title(s,'^{o}C','fontname','consolas');
set(gca,'fontsize',12)
title(['EOF' num2str(i) ': ' num2str(expvar(i),4) '%'],'fontsize',16,'fontname','consolas');

subplot(3,2,2+(i-1)*2);
plot(1:504,pcs(:,i),'r','linewidth',2);
set(gca,'xtick',[6:60:504],'xticklabels',1980:5:2021,'fontname','consolas','fontsize',12);
xlabel('Year','fontname','consolas');
ylabel('PC','fontname','consolas');
xlim([1 504]);
set(gca,'fontsize',12,'linewidth',2)
title(['PC' num2str(i) ': ' num2str(expvar(i),4) '%'],'fontsize',16,'fontname','consolas');
end

%% regress
load('ssttas');
pcs=pcs(((1982-1980)*12+1):(2016-1980+1)*12,:);
coef_full=NaN(32,32,3,2);
for i=1:3
    pc_here=pcs(:,i);
    for x=1:size(ssttas,1)
        for y=1:size(ssttas,2)
            ts_here=squeeze(ssttas(x,y,:));
            if nansum(isnan(ts_here))==0
                [b,bint]=regress(ts_here,[ones(length(pc_here),1) pc_here]);
                coef_full(x,y,1,i)=b(2);
                coef_full(x,y,2,i)=double(bint(2,1)*bint(2,2)>0);
            end
        end
    end
end

%% drawing 
[lats,lons]=meshgrid(lattas,lontas);
land_idx=isnan(nanmean(ssttas,3));
figure('pos',[173   535   943   268]);
for i=1:3
    if i==3
        idx=3.5;
    else
        idx=i;
    end
    subplot(2,2,idx)
    m_proj('miller','lon',[nanmin(lontas) nanmax(lontas)],'lat',[nanmin(lattas) nanmax(lattas)]);
    coef_here=coef_full(:,:,1,i);
    p_here=coef_full(:,:,2,i);
    coef_here(land_idx)=nan;
    p_here(land_idx)=nan;
    m_pcolor(lontas,lattas,coef_here');
    shading interp
    hold on
    m_scatter(lons(p_here==1),lats(p_here==1),1,'k');
    m_coast('patch',[0.7 0.7 0.7],'linewidth',2);
    m_grid('linewidth',2,'fontname','consolas','linestyle','none');
    colormap(m_colmap('diverging'));
    caxis([-0.5 0.5]);
    s=colorbar('fontname','consolas','fontsize',12);
    title(s,'^{o}C','fontname','consolas');
    title(['EOF' num2str(i) ': ' num2str(expvar(i),4) '%'],'fontsize',16,'fontname','consolas');
end