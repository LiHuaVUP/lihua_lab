load('precip_ts');

windows=3;
precip_ts=smoothdata(precip_ts,1,'movmean',windows);

y_m=datevec(datenum(1979,1,1):datenum(2022,12,31));
y_m=unique(y_m(:,1:2),'rows');

spi=NaN(size(precip_ts));

for i=1:12;
    index=y_m(:,2)==i;
    p_here=precip_ts(index);
    p_copy=p_here;
    p_copy(p_copy==0)=[];
    pa=gamfit(p_copy);
    q=length(p_copy)./length(p_here);
    gam_cdf=1-q+q*gamcdf(p_here,pa(1),pa(2));
    spi(index)=norminv(gam_cdf);
end

spi=(spi-nanmean(spi))./nanstd(spi);

spi_3=NaN(528,3);
windows_used=[3 6 12];

for w=1:3
    windows=windows_used(w);
    precip_ts=smoothdata(precip_ts,1,'movmean',windows);
    
    y_m=datevec(datenum(1979,1,1):datenum(2022,12,31));
    y_m=unique(y_m(:,1:2),'rows');
    
    for i=1:12;
        index=y_m(:,2)==i;
        p_here=precip_ts(index);
        p_copy=p_here;
        p_copy(p_copy==0)=[];
        pa=gamfit(p_copy);
        q=length(p_copy)./length(p_here);
        gam_cdf=1-q+q*gamcdf(p_here,pa(1),pa(2));
        spi_3(index,w)=norminv(gam_cdf);
    end
end

spi_3=(spi_3-nanmean(spi_3))./nanstd(spi_3);

subplot(3,1,1);
plot(1:528,spi_3(:,1),'color',[0 0.4470 0.7410],'linewidth',2);
set(gca,'xtick',6:12*5:528,'xticklabels',1979:5:2022,'fontname','consolas','fontsize',12);
set(gca,'linewidth',2);
title('3-month SPI','fontname','consolas','fontsize',16);
xlim([1 528]);ylim([-4 4]);

subplot(3,1,2);
plot(1:528,spi_3(:,2),'color',[0.8500 0.3250 0.0980],'linewidth',2);
set(gca,'xtick',6:12*5:528,'xticklabels',1979:5:2022,'fontname','consolas','fontsize',12);
set(gca,'linewidth',2);
title('6-month SPI','fontname','consolas','fontsize',16);
xlim([1 528]);ylim([-4 4]);

subplot(3,1,3);
plot(1:528,spi_3(:,3),'color',[0.9290 0.6940 0.1250],'linewidth',2);
set(gca,'xtick',6:12*5:528,'xticklabels',1979:5:2022,'fontname','consolas','fontsize',12);
set(gca,'linewidth',2);
title('12-month SPI','fontname','consolas','fontsize',16);
xlim([1 528]);ylim([-4 4]);