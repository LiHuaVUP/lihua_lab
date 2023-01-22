%% pcolor
z=peaks(5);
pcolor(z);
colormap(jet);

z=peaks(5);
% 加入一行一列缺失值
z(end+1,:)=nan;
z(:,end+1)=nan;
pcolor(z);
colormap(jet);

%% line color
subplot(2,1,2)
plot(linspace(0,2*pi,100),sin(linspace(0,2*pi,100)),'color','r','linewidth',2);
hold on
plot(linspace(0,2*pi,100),cos(linspace(0,2*pi,100)),'color','b','linewidth',2);
set(gca,'linewidth',2,'fontsize',12,'fontname','consolas')

subplot(2,1,1)
x=[linspace(0,2*pi,100) nan];
y=[sin(linspace(0,2*pi,100)) nan];
c=[cos(linspace(0,2*pi,100)) nan];
patch(x,y,c,...
    'EdgeColor','interp','linewidth',4);
colormap(jet);
colorbar('location','eastoutside');
set(gca,'linewidth',2,'fontsize',12,'fontname','consolas')
box on

x=[linspace(0,2*pi,100)];
y=[sin(linspace(0,2*pi,100))];
c=[cos(linspace(0,2*pi,100))];
patch(x,y,c,...
    'EdgeColor','interp','linewidth',4);
colormap(jet);
colorbar('location','eastoutside');
set(gca,'linewidth',2,'fontsize',12,'fontname','consolas')
box on
%%
figure
ax=axes();
plot(linspace(0,2*pi,100),sin(linspace(0,2*pi,100)),'color','k','linewidth',2);
