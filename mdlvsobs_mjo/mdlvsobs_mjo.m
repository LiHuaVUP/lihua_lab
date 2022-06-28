%% filter - trmm
load('trmm_re');
data_re=trmm_re;
for m=1:size(data_re,1);
    for n=1:size(data_re,2);
        data_re(m,n,:)=filt1('bp',squeeze(data_re(m,n,:)),'fc',[1/100 1/20]);
    end
end
save trmm_filter data_re

%% lag regress
lon_re=30:2.5:180;
lat_re=-20:2.5:20;

load('trmm_filter');
data_used=data_re.*repmat(cosd(lat_re),61,1,3652);

% data_ref
data_ref=data_used(lon_re>=85 & lon_re<=95,lat_re<=5 & lat_re>=-5,:);
data_ref=nanmean(reshape(data_ref,size(data_ref,1)*size(data_ref,2),size(data_ref,3)));

% data body
data_anom=squeeze(nanmean(data_used(:,lat_re>=-10 & lat_re<=10,:),2));

cor_used=NaN(61,61,2);

for i=-30:30
    for j=1:size(data_anom,1)
        index_data=(1:3652)+i;
        index_ref=1:3652;
        
        index_ref(index_data<=0 | index_data>3652)=[];
        index_data(index_data<=0 | index_data>3652)=[];
        
        ref_here=data_ref(index_ref);
        data_here=data_anom(j,index_data);
        
        [b,bint]=regress(data_here(:),[ref_here(:)]);
        cor_used(i+31,j,1)=b(1);
        cor_used(i+31,j,2)=double(bint(1,1).*bint(1,2)>0);
    end
end
save cor_trmm_trmm cor_used
%% MC index
load('imname');
iname{8}='TRMM';
mname{8}='TRMM';
mci=NaN(8,1);
lon_re=30:2.5:180;
for i=1:8;
    data_name=['cor_' iname{i} '_' mname{i}];
    load(data_name);
    cor_here=cor_used((0:25)+31,lon_re>=100 & lon_re<=150,1);
    mci(i)=nansum(cor_here(cor_here>0));
end
save mci mci

%% drawing correlation plot
load('imname');
iname{8}='TRMM';
mname{8}='TRMM';
lon_re=30:2.5:180;
lon_used=lon_re;
figure('pos',[10 10 1500 1500]);

for i=1:8
    data_name=['cor_' iname{i} '_' mname{i}];
    load(data_name);
    title_here=[iname{i} '-' mname{i}];
    subplot(4,2,i);
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
    
    
    set(gca,'fontsize',12,'fontname','consolas');
    
end

%% drawing - MC
load('mci');
load('imname');
mci(9)=nanmean(mci(1:7));
mci=mci./mci(8);

% mdl bar
mdl=bar(1:7,mci(1:7));
hold on
% obs bar
obs=bar(8,mci(8));
obs(1).FaceColor=[0 0 0];
hold on
% mean bar
m=bar(9,mci(9));
m(1).EdgeColor = [0    0.4470    0.7410];
m(1).FaceColor = [1 1 1];
m(1).LineWidth =1;
hold on
er = errorbar(9,mci(9),nanstd(mci(1:7)),nanstd(mci(1:7)));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
er.LineWidth = 1;

data_name=mname;
data_name{8}='TRMM';
data_name{9}='Mean';

set(gca,'xtick',[1:9],'xticklabels',data_name,'fontname','consolas');
xtickangle(45);
set(gca,'fontname','consolas','fontsize',12);

%% PCC NRMSE
load('imname');
pcc=NaN(7,1);
nrmse=NaN(7,1);
lon_re=30:2.5:180;
load('cor_trmm_trmm');
cor_ref=cor_used(:,:,1);
for i=1:7;
    data_name=['cor_' iname{i} '_' mname{i}];
    load(data_name);
    cor_used=cor_used(:,:,1);
    pcc(i)=corr(cor_used(:),cor_ref(:));
    nrmse(i)=sqrt(nanmean((cor_used(:)-cor_ref(:)).^2))./nanstd(cor_ref(:));
end

%% drawing PCC NRMSE
color_used=[[0 0.4470 0.7410];...
    [0.8500 0.3250 0.0980];...
    [0.9290 0.6940 0.1250];...
    [0.4940 0.1840 0.5560];...
    [0.4660 0.6740 0.1880];...
    [0.3010 0.7450 0.9330];...
    [0.6350 0.0780 0.1840]];
gscatter(pcc,nrmse,categorical(1:7),color_used,'.',50,'filled');
set(gca,'fontname','consolas','fontsize',12);
legend(mname);
grid on