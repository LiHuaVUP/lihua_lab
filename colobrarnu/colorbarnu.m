%% plot sst j ja s
load('sst_j_ja_s_hm');
figure('pos',[10 10 600 1500]);

x_1=linspace(258,270,100);
y_1=12*ones(1,100);

x_2=linspace(258,270,100);
y_2=18*ones(1,100);

x_3=258*ones(1,100);
y_3=linspace(12,18,100);

x_4=270*ones(1,100);
y_4=linspace(12,18,100);
data_name={'_j','_ja','_s'};
title_name={'Jun','Jul and Aug','Sep'};


% June
for i=1:3
    subplot(3,1,i);
    data_here=eval(['sst' data_name{i}]);
    m_contourf(lon_sst,lat_sst,(data_here)',linspace(nanmin((data_here(:))),nanmax((data_here(:))),100),'linestyle','none');
    m_coast('patch',[0.8 0.8 0.8]);
    m_grid('fontname','consolas');
    colormap(m_colmap('jet'));
    caxis([(15) (30.5)]);
    hold on
    m_line(x_1,y_1,'linewidth',2,'color','k');
    hold on
    m_line(x_2,y_2,'linewidth',2,'color','k');
    hold on
    m_line(x_3,y_4,'linewidth',2,'color','k');
    hold on
    m_line(x_4,y_4,'linewidth',2,'color','k');
    ttl = title(title_name{i},'fontname','consolas');
    ttl.Units = 'Normalize';
    ttl.Position(1) = 0;
    ttl.HorizontalAlignment = 'left';
    ttl.Color='k';
end

hp4=get(subplot(3,1,3),'Position');   
s=colorbar('location','southoutside','fontsize',12,'Position', [hp4(1)-0.03  hp4(2)-0.08  0.8  0.025]);

%% plot sst j ja s - limit
load('sst_j_ja_s_hm');
figure('pos',[10 10 600 1500]);

x_1=linspace(258,270,100);
y_1=12*ones(1,100);

x_2=linspace(258,270,100);
y_2=18*ones(1,100);

x_3=258*ones(1,100);
y_3=linspace(12,18,100);

x_4=270*ones(1,100);
y_4=linspace(12,18,100);
data_name={'_j','_ja','_s'};
title_name={'Jun','Jul and Aug','Sep'};


% June
for i=1:3
    subplot(3,1,i);
    data_here=eval(['sst' data_name{i}]);
    m_contourf(lon_sst,lat_sst,(data_here)',linspace(nanmin((data_here(:))),nanmax((data_here(:))),100),'linestyle','none');
    m_coast('patch',[0.8 0.8 0.8]);
    m_grid('fontname','consolas');
    colormap(m_colmap('jet'));
    caxis([(28) (30.5)]);
    hold on
    m_line(x_1,y_1,'linewidth',2,'color','k');
    hold on
    m_line(x_2,y_2,'linewidth',2,'color','k');
    hold on
    m_line(x_3,y_4,'linewidth',2,'color','k');
    hold on
    m_line(x_4,y_4,'linewidth',2,'color','k');
    ttl = title(title_name{i},'fontname','consolas');
    ttl.Units = 'Normalize';
    ttl.Position(1) = 0;
    ttl.HorizontalAlignment = 'left';
    ttl.Color='k';
end

hp4=get(subplot(3,1,3),'Position');   
s=colorbar('location','southoutside','fontsize',12,...
    'ticks',28:0.5:30.5,'ticklabels',{'<28','28.5','29','29.5','30','30.5'},'Position',[hp4(1)-0.03  hp4(2)-0.08  0.8  0.025]);

%% plot sst j ja s - exp
addpath('/Volumes/mydirve/cloud_annual/tight_subplot');
addpath('/Volumes/mydirve/cloud_annual/m_map');
load('sst_j_ja_s_hm');
figure('pos',[10 10 600 1500]);

x_1=linspace(258,270,100);
y_1=12*ones(1,100);

x_2=linspace(258,270,100);
y_2=18*ones(1,100);

x_3=258*ones(1,100);
y_3=linspace(12,18,100);

x_4=270*ones(1,100);
y_4=linspace(12,18,100);
data_name={'_j','_ja','_s'};
title_name={'Jun','Jul and Aug','Sep'};

for i=1:3
    subplot(3,1,i);
    data_here=eval(['2.^(sst' data_name{i} ')']);
    m_contourf(lon_sst,lat_sst,(data_here)',linspace(nanmin((data_here(:))),nanmax((data_here(:))),100),'linestyle','none');
    m_coast('patch',[0.8 0.8 0.8]);
    m_grid('fontname','consolas');
    colormap(m_colmap('jet'));
    caxis(2.^([(15) (30.5)]));
    hold on
    m_line(x_1,y_1,'linewidth',2,'color','k');
    hold on
    m_line(x_2,y_2,'linewidth',2,'color','k');
    hold on
    m_line(x_3,y_4,'linewidth',2,'color','k');
    hold on
    m_line(x_4,y_4,'linewidth',2,'color','k');
    ttl = title(title_name{i},'fontname','consolas');
    ttl.Units = 'Normalize';
    ttl.Position(1) = 0;
    ttl.HorizontalAlignment = 'left';
    ttl.Color='k';
end

hp4=get(subplot(3,1,3),'Position');   
s=colorbar('location','southoutside','fontsize',12,...
    'ticks',2.^([15 28 29 30 30.5]),'ticklabels',[15 28 29 30 30.5],'Position', [hp4(1)-0.03  hp4(2)-0.08  0.8  0.025]);
print -dpng sst_exp.png


%% 
color_used=m_colmap('diverging',256);
x_used=linspace(15,30.5,256);
y_used=x_used;
patch([x_used(:)],[y_used(:)],zeros(size(y_used(:))),[y_used(:)],'edgecolor', 'interp','linewidth',5);
xlim([15 30.5]);
ylim([15 30.5]);
colormap(m_colmap('jet'));
set(gca,'ytick',[]);
print -dpng line_color.png

%% 
color_used=m_colmap('diverging',256);
x_used=linspace(15,30.5,256);
y_used=2.^(x_used);
patch([x_used nan],[y_used nan],[zeros(size(y_used)) nan],[y_used nan],'edgecolor', 'interp','linewidth',5);
xlim([15 30.5]);
colormap(m_colmap('jet'));
set(gca,'ytick',[]);

print -dpng exp_color.png
