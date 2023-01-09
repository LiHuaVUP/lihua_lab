%% Data Generation
% iindex=1:1000;
% sst_i=sst_anom(iindex);
% sst_m=NaN(20,1000);
% c_full=NaN(20,1);
% for i=5:5:100;
%     index_here=iindex+i;
%     sst_here=sst_anom(index_here);
%     sst_m(i./5,:)=sst_here;
%     [c,p]=corr(sst_here(:),sst_i(:));
%     c_full(i./5)=c(1,1);
% end

%% COR and RMSE
load('sst_im');  
cor_full=NaN(20,1);
rmse_full=NaN(20,1);
for i=1:20;
    cor_full(i)=corr(sst_i(:),(sst_m(i,:))');
    rmse_full(i)=sqrt(nanmean((sst_i-sst_m(i,:)).^2));
end

figure('pos',[10 10 800 600]);

ax1=axes();
plot(ax1,5:5:100,cor_full,'color',[0.8500 0.3250 0.0980],'linewidth',2);
hold on
plot(ax1,0:5:100,0.5*ones(1,21),'r--','linewidth',1);
set(ax1,'xcolor','r','ycolor','r','fontsize',16);
xlabel(ax1,'Forecast lead time (Days)','fontsize',16);
ylabel(ax1,'COR','fontsize',16);
set(ax1,'linewidth',2)

ax2=axes();
plot(ax2,5:5:100,rmse_full,'color',[0 0.4470 0.7410],'linewidth',2);
set(ax2,'color','none');
set(ax2,'yaxislocation','right');
set(ax2,'xaxislocation','top');
set(ax2,'xcolor','b','ycolor','b','fontsize',16);
ylabel(ax2,'RMSE','fontsize',16);
set(ax2,'linewidth',2)
grid on
ax2.GridColor=[0 0 0];
ax2.GridAlpha=0.15;

ax1.Box='off';
ax2.Box='off';

