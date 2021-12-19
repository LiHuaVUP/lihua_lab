%% Example 1
figure('pos',[10 10 1000 800]);
ax=axes();
pcolor(ax,peaks(20));
set(gcf,'color','none');
print -dpng -r600 example1.png

%% Example 2
figure('pos',[10 10 1000 800]);
ax=axes();
print -dpng -r600 example2.png

%% Example 3
figure('pos',[10 10 1000 800]);
ax=axes();
plot(1:10,1:10,'linewidth',2);
hold on
plot(1:10,fliplr(1:10),'linewidth',2);
set(ax,'fontsize',16);
print -dpng -r600 example3.png

%% Example 4
figure('pos',[10 10 1000 800]);
ax=axes();
plot(ax,1:10,1:10,'linewidth',2);
set(ax,'fontsize',16);
print -dpng -r600 example4.png

%% Example 5
x1=1:10;
y1=1:10;
x2=1:100;
y2=(1:100)+10*rand(1,100);

figure('pos',[10 10 1000 800]);
ax1=axes();
plot(ax1,x1,y1,'linewidth',2,'color','b');
set(ax1,'xcolor','b','ycolor','b','fontsize',16);
xlabel(ax1,'X1');
ylabel(ax1,'Y1');

ax2=axes();
plot(ax2,x2,y2,'linewidth',2,'color','r');
set(ax2,'color','none');
set(ax2,'yaxislocation','right');
set(ax2,'xaxislocation','top');
set(ax2,'xcolor','r','ycolor','r','fontsize',16);
xlabel(ax2,'X2');
ylabel(ax2,'Y2');

ax1.Box='off';
ax2.Box='off';
print -dpng -r600 example5.png

%% Example 5 - Step Wise
% 1
x1=1:10;
y1=1:10;
x2=1:100;
y2=(1:100)+10*rand(1,100);

figure('pos',[10 10 1000 800]);
ax1=axes();
plot(ax1,x1,y1,'linewidth',2,'color','b');
set(ax1,'xcolor','b','ycolor','b','fontsize',16);
xlabel(ax1,'X1');
ylabel(ax1,'Y1');
print -dpng -r600 example51.png

% 2
x1=1:10;
y1=1:10;
x2=1:100;
y2=(1:100)+10*rand(1,100);

figure('pos',[10 10 1000 800]);
ax1=axes();
plot(ax1,x1,y1,'linewidth',2,'color','b');
set(ax1,'xcolor','b','ycolor','b','fontsize',16);
xlabel(ax1,'X1');
ylabel(ax1,'Y1');

ax2=axes();
plot(ax2,x2,y2,'linewidth',2,'color','r');
print -dpng -r600 example52.png

% 3
x1=1:10;
y1=1:10;
x2=1:100;
y2=(1:100)+10*rand(1,100);

figure('pos',[10 10 1000 800]);
ax1=axes();
plot(ax1,x1,y1,'linewidth',2,'color','b');
set(ax1,'xcolor','b','ycolor','b','fontsize',16);
xlabel(ax1,'X1');
ylabel(ax1,'Y1');

ax2=axes();
plot(ax2,x2,y2,'linewidth',2,'color','r');
set(ax2,'color','none');
print -dpng -r600 example53.png

% 4
x1=1:10;
y1=1:10;
x2=1:100;
y2=(1:100)+10*rand(1,100);

figure('pos',[10 10 1000 800]);
ax1=axes();
plot(ax1,x1,y1,'linewidth',2,'color','b');
set(ax1,'xcolor','b','ycolor','b','fontsize',16);
xlabel(ax1,'X1');
ylabel(ax1,'Y1');

ax2=axes();
plot(ax2,x2,y2,'linewidth',2,'color','r');
set(ax2,'color','none');
set(ax2,'yaxislocation','right');
set(ax2,'xaxislocation','top');
set(ax2,'xcolor','r','ycolor','r','fontsize',16);
print -dpng -r600 example54.png

% 5
x1=1:10;
y1=1:10;
x2=1:100;
y2=(1:100)+10*rand(1,100);

figure('pos',[10 10 1000 800]);
ax1=axes();
plot(ax1,x1,y1,'linewidth',2,'color','b');
set(ax1,'xcolor','b','ycolor','b','fontsize',16);
xlabel(ax1,'X1');
ylabel(ax1,'Y1');

ax2=axes();
plot(ax2,x2,y2,'linewidth',2,'color','r');
set(ax2,'color','none');
set(ax2,'yaxislocation','right');
set(ax2,'xaxislocation','top');
set(ax2,'xcolor','r','ycolor','r','fontsize',16);
xlabel(ax2,'X2');
ylabel(ax2,'Y2');
ax1.Box='off';
ax2.Box='off';
print -dpng -r600 example55.png

%% Example 6
topo=[1000-1000*pdf('Normal',linspace(-10,10,1000),0,1)];
lat_used=[linspace(0,30,1000)];
lon_used=linspace(30,60,1000);
[lon_used,lat_used]=meshgrid(lon_used',lat_used');
topo=repmat(topo',1,1000);

figure('pos',[10 10 1000 800]);
ax1=axes('color','none');
s=surf(ax1,lon_used,lat_used,-topo);
shading flat
set(s,'Facecolor',[171 104 87]./255);
l=light;
l.Style='local';
l.Position=[50 5 -500];
xlim([30 60]);
ylim([0 30]);
zlim([-1050 -200]);
set(ax1,'color','none');


data_here=200*ones(1000,1000);
ax2=axes('color','none');
a=surf(ax2,lon_used,lat_used,-data_here,peaks(1000),'facealpha',0.95);
shading flat
caxis([-6 6]);
xlim([30 60]);
ylim([0 30]);
zlim([-1050 -200]);
set(ax2,'ztick',[-1000:100:-200],'zticklabel',-[-1000:100:-200]);
grid off

set(ax2,'fontsize',12);
xlabel(ax2,'Lon','fontsize',12);
ylabel(ax2,'Days','fontsize',12);

colormap(ax2,m_colmap('diverging'));
box off
axis off
[caz,cal]=view(ax1,[-37.5 60]);;
[caz,cal]=view(ax2,[-37.5 60]);;

%% Example 6 Step Wise
% 1
topo=[1000-1000*pdf('Normal',linspace(-10,10,1000),0,1)];
lat_used=[linspace(0,30,1000)];
lon_used=linspace(30,60,1000);
[lon_used,lat_used]=meshgrid(lon_used',lat_used');
topo=repmat(topo',1,1000);

figure('pos',[10 10 1000 800]);
ax1=axes('color','none');
s=surf(ax1,lon_used,lat_used,-topo);
shading flat
print -dpng -r600 example61.png

% 2
topo=[1000-1000*pdf('Normal',linspace(-10,10,1000),0,1)];
lat_used=[linspace(0,30,1000)];
lon_used=linspace(30,60,1000);
[lon_used,lat_used]=meshgrid(lon_used',lat_used');
topo=repmat(topo',1,1000);

figure('pos',[10 10 1000 800]);
ax1=axes('color','none');
s=surf(ax1,lon_used,lat_used,-topo);
shading flat
set(s,'Facecolor',[171 104 87]./255);
l=light;
l.Style='local';
l.Position=[50 5 -500];
xlim([30 60]);
ylim([0 30]);
zlim([-1050 -200]);
set(ax1,'color','none');
print -dpng -r600 example62.png

% 3
topo=[1000-1000*pdf('Normal',linspace(-10,10,1000),0,1)];
lat_used=[linspace(0,30,1000)];
lon_used=linspace(30,60,1000);
[lon_used,lat_used]=meshgrid(lon_used',lat_used');
topo=repmat(topo',1,1000);

figure('pos',[10 10 1000 800]);
ax1=axes('color','none');
s=surf(ax1,lon_used,lat_used,-topo);
shading flat
set(s,'Facecolor',[171 104 87]./255);
l=light;
l.Style='local';
l.Position=[50 5 -500];
xlim([30 60]);
ylim([0 30]);
zlim([-1050 -200]);
set(ax1,'color','none');
data_here=200*ones(1000,1000);

ax2=axes('color','none');
a=surf(ax2,lon_used,lat_used,-data_here,peaks(1000),'facealpha',0.95);
shading flat
caxis([-6 6]);
xlim([30 60]);
ylim([0 30]);
zlim([-1050 -200]);
set(ax2,'ztick',[-1000:100:-200],'zticklabel',-[-1000:100:-200]);
grid off
set(ax2,'fontsize',12);
xlabel(ax2,'Lon','fontsize',12);
ylabel(ax2,'Days','fontsize',12);
colormap(ax2,m_colmap('diverging'));
box off
axis off
print -dpng -r600 example63.png

% 4
topo=[1000-1000*pdf('Normal',linspace(-10,10,1000),0,1)];
lat_used=[linspace(0,30,1000)];
lon_used=linspace(30,60,1000);
[lon_used,lat_used]=meshgrid(lon_used',lat_used');
topo=repmat(topo',1,1000);

figure('pos',[10 10 1000 800]);
ax1=axes('color','none');
s=surf(ax1,lon_used,lat_used,-topo);
shading flat
set(s,'Facecolor',[171 104 87]./255);
l=light;
l.Style='local';
l.Position=[50 5 -500];
xlim([30 60]);
ylim([0 30]);
zlim([-1050 -200]);
set(ax1,'color','none');
data_here=200*ones(1000,1000);

ax2=axes('color','none');
a=surf(ax2,lon_used,lat_used,-data_here,peaks(1000),'facealpha',0.95);
shading flat
caxis([-6 6]);
xlim([30 60]);
ylim([0 30]);
zlim([-1050 -200]);
set(ax2,'ztick',[-1000:100:-200],'zticklabel',-[-1000:100:-200]);
grid off
set(ax2,'fontsize',12);
xlabel(ax2,'Lon','fontsize',12);
ylabel(ax2,'Days','fontsize',12);
colormap(ax2,m_colmap('diverging'));
box off
axis off
[caz,cal]=view(ax1,[-37.5 60]);;
[caz,cal]=view(ax2,[-37.5 60]);;
print -dpng -r600 example64.png