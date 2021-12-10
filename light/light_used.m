%% Single Ball - No Light
close all
figure();
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
set(gcf,'color','none');
print -dpng -r600 ball_nolight.png

%% Single Ball - Light
close all
f=figure();
set(gcf,'color','k');
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
l=light;
print -dpng -r600 ball_light.png
%% Balls - Position
close all
f=figure();
set(f,'color','k');
subplot(2,2,1);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','k');
l=light;
l.Position=[1 0 0];
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('X','fontsize',16,'fontweight','bold','color','w');

subplot(2,2,2);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','k');
l=light;
l.Position=[0 1 0];
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Y','fontsize',16,'fontweight','bold','color','w');

subplot(2,2,3);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','k');
l=light;
l.Position=[0 0 1];
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Z','fontsize',16,'fontweight','bold','color','w');

subplot(2,2,4);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','k');
l=light;
l.Position=[1 0 1];
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('X-Z','fontsize',16,'fontweight','bold','color','w');
print -dpng -r600 balls_position.png
%% Balls - Color
close all
subplot(2,2,1);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
l=light;
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('White','fontsize',16,'fontweight','bold');

subplot(2,2,2);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
l=light;
l.Color=[0, 1, 0];
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Green','fontsize',16,'fontweight','bold');

subplot(2,2,3);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
l=light;
l.Color=[0, 0, 1];
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Blue','fontsize',16,'fontweight','bold');

subplot(2,2,4);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
l=light;
l.Color=[128, 0, 128]./255;
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Purple','fontsize',16,'fontweight','bold');
print -dpng -r600 balls_color.png
%% Balls - Style
close all
subplot(1,2,1);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
l=light;
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Infinite','fontsize',16,'fontweight','bold');

subplot(1,2,2);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
l=light;
l.Style='local';
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Local','fontsize',16,'fontweight','bold');
print -dpng -r600 balls_style.png
%% Balls - Light Style - Low Res
subplot(1,2,1);
[x,y,z]=sphere(10);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
light;
lighting('flat');
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Flat','fontsize',16,'fontweight','bold');

subplot(1,2,2);
[x,y,z]=sphere(10);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
light
lighting('gouraud');
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Gouraud','fontsize',16,'fontweight','bold');
print -dpng -r600 balls_lighting.png
%% Balls - Material
close all
subplot(2,2,1);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
light;
material shiny
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Shiny','fontsize',16,'fontweight','bold');

subplot(2,2,2);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
light
material dull
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Dull','fontsize',16,'fontweight','bold');

subplot(2,2,3.5);
[x,y,z]=sphere(100);
s=surf(x,y,z);
shading flat
set(s,'facecolor','r');
axis equal
axis off
box off
set(gca,'color','none');
light
material metal
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
title('Metal','fontsize',16,'fontweight','bold');
print -dpng -r600 balls_material.png

%% Model Topo
close all
load('lonlat_used.mat')

topo=[1000-1000*pdf('Normal',linspace(-10,10,1000),0,1)];
t_used=[linspace(-30,30,1000)];
lon_used=linspace(30,300,1000);
[lon_used,t_used]=meshgrid(lon_used',t_used');
topo=repmat(topo',1,1000);

ax1=subplot(1,2,1);
s=surf(ax1,lon_used,t_used,-topo);
shading flat
set(s,'Facecolor',[171 104 87]./255);
xlim([30 299.5]);
ylim([-30 30]);
zlim([-1050 -200]);
title('不打光','fontsize',16);
set(ax1,'color','none');

ax2=subplot(1,2,2);
s=surf(ax2,lon_used,t_used,-topo);
shading flat
set(s,'Facecolor',[171 104 87]./255);
light
xlim([30 299.5]);
ylim([-30 30]);
zlim([-1050 -200]);
set(ax2,'color','none');
title('打光','fontsize',16);
print -dpng -r600 topo_model.png

%% Real Topo
close all
load('topo_data');
t=smoothdata(topo_data,1,'gaussian',21);
t=smoothdata(t,2,'gaussian',21);
ax1=subplot(1,2,1);
mesh(ax1,lon_topo,lat_topo,t)
colormap([ m_colmap('blues',80); m_colmap('gland',80)]);
set(ax1,'color','none');
zlim([-5000 5000]);
title('不打光','fontsize',16);

ax2=subplot(1,2,2);
mesh(ax2,lon_topo,lat_topo,t)
colormap([ m_colmap('blues',80); m_colmap('gland',80)]);
set(ax2,'color','none');
light
zlim([-5000 5000]);
title('打光','fontsize',16);
print -dpng -r600 topo_real.png

