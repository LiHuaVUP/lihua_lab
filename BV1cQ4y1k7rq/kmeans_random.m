%% Data Illustration - Random Chooese
load fisheriris
X = meas(:,3:4); % Petal Length Petal Width

figure('pos',[10 10 1000 1000]);
plot(X(:,1),X(:,2),'k.','MarkerSize',15);
hold on
rng(123)
xr=nanmax(X(:,1)).*rand(3,1);
yr=nanmax(X(:,2)).*rand(3,1);
hold on
plot(xr(1),yr(1),'rd','Markersize',15,'markerfacecolor','r','markeredgecolor','r');
hold on
plot(xr(2),yr(2),'bd','Markersize',15,'markerfacecolor','b','markeredgecolor','b');
hold on
plot(xr(3),yr(3),'gd','Markersize',15,'markerfacecolor','m','markeredgecolor','m');
set(gcf,'color','k');
legend({'Data','C1','C2','C3'},'fontsize',16,'location','southeast');
title(['Fisher''s Iris Data']);
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
xlabel('Petal Lengths (cm)','color','w','fontsize',14,'fontweight','bold');
ylabel('Petal Widths  (cm)','color','w','fontsize',14,'fontweight','bold');

frame=getframe(gcf);
im=frame2im(frame);
[I,map]=rgb2ind(im,256);
imwrite(I,map,'kmeans1.gif','gif', 'Loopcount',inf,'DelayTime',1.5);
close all

%% Data Illustration - Random Choose with Distances
load fisheriris
X = meas(:,3:4); % Petal Length Petal Width

figure('pos',[10 10 1000 1000]);
h1=plot(X(:,1),X(:,2),'k.','MarkerSize',15);
hold on
rng(123)
xr=nanmax(X(:,1)).*rand(3,1);
yr=nanmax(X(:,2)).*rand(3,1);

linestorex=NaN(150,3,100);
linestorey=NaN(150,3,100);
for i=1:150;
    starter=X(i,:);
    for j=1:3;
        ender=[xr(j) yr(j)];
        linestorex(i,j,:)=linspace(starter(1),ender(1),100);
        linestorey(i,j,:)=linspace(starter(2),ender(2),100);
        plot(linspace(starter(1),ender(1),100),...
            linspace(starter(2),ender(2),100),'color','k','linewidth',1);
        hold on
    end
end


hold on
h2=plot(xr(1),yr(1),'rd','Markersize',15,'markerfacecolor','r','markeredgecolor','r');
hold on
h3=plot(xr(2),yr(2),'bd','Markersize',15,'markerfacecolor','b','markeredgecolor','b');
hold on
h4=plot(xr(3),yr(3),'gd','Markersize',15,'markerfacecolor','m','markeredgecolor','m');
set(gcf,'color','k');
legend([h1 h2 h3 h4],{'Data','C1','C2','C3'},'fontsize',16,'location','southeast');
title(['Fisher''s Iris Data']);
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
xlabel('Petal Lengths (cm)','color','w','fontsize',14,'fontweight','bold');
ylabel('Petal Widths  (cm)','color','w','fontsize',14,'fontweight','bold');

frame=getframe(gcf);
im=frame2im(frame);
[I,map]=rgb2ind(im,256);
imwrite(I,map,'kmeans2.gif','gif', 'Loopcount',inf,'DelayTime',1.5);
close all

%% Data Illustration - Initial Group
load fisheriris
X = meas(:,3:4); % Petal Length Petal Width
rng(123)
xr=nanmax(X(:,1)).*rand(3,1);
yr=nanmax(X(:,2)).*rand(3,1);
dist_full=NaN(150,3);

for i=1:3;
    dist_full(:,i)=(X(:,1) - xr(i)).^2+(X(:,2) - yr(i)).^2;
end

dist_cell=mat2cell(dist_full,ones(150,1),3);
label_used=cellfun(@(x)find(x==nanmin(x)),dist_cell);

figure('pos',[10 10 1000 1000]);
plot(X(label_used==1,1),X(label_used==1,2),'r.','Markersize',15);
hold on
plot(X(label_used==2,1),X(label_used==2,2),'b.','Markersize',15);
hold on
plot(X(label_used==3,1),X(label_used==3,2),'m.','Markersize',15);
hold on
plot(xr(1),yr(1),'rd','Markersize',15,'markerfacecolor','r','markeredgecolor','r');
hold on
plot(xr(2),yr(2),'bd','Markersize',15,'markerfacecolor','b','markeredgecolor','b');
hold on
plot(xr(3),yr(3),'gd','Markersize',15,'markerfacecolor','m','markeredgecolor','m');
set(gcf,'color','k');
legend({'1','2','3','C1','C2','C3'},'fontsize',16,'location','southeast');
title(['Fisher''s Iris Data']);
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
xlabel('Petal Lengths (cm)','color','w','fontsize',14,'fontweight','bold');
ylabel('Petal Widths  (cm)','color','w','fontsize',14,'fontweight','bold');

frame=getframe(gcf);
im=frame2im(frame);
[I,map]=rgb2ind(im,256);
imwrite(I,map,'kmeans3.gif','gif', 'Loopcount',inf,'DelayTime',1.5);
close all

%% Data Illustration - Further Group
load fisheriris
X = meas(:,3:4); % Petal Length Petal Width
rng(123)
xr=nanmax(X(:,1)).*rand(3,1);
yr=nanmax(X(:,2)).*rand(3,1);
dist_full=NaN(150,3);

for i=1:3;
    dist_full(:,i)=(X(:,1) - xr(i)).^2+(X(:,2) - yr(i)).^2;
end

dist_cell=mat2cell(dist_full,ones(150,1),3);
label_used=cellfun(@(x)find(x==nanmin(x)),dist_cell);

figure('pos',[10 10 1000 1000]);
plot(X(label_used==1,1),X(label_used==1,2),'r.','Markersize',15);
hold on
plot(X(label_used==2,1),X(label_used==2,2),'b.','Markersize',15);
hold on
plot(X(label_used==3,1),X(label_used==3,2),'m.','Markersize',15);
hold on
plot(nanmean(X(label_used==1,1)),nanmean(X(label_used==1,2)),'rd','Markersize',15,'markerfacecolor','r','markeredgecolor','r');
hold on
plot(nanmean(X(label_used==2,1)),nanmean(X(label_used==2,2)),'bd','Markersize',15,'markerfacecolor','b','markeredgecolor','b');
hold on
plot(nanmean(X(label_used==3,1)),nanmean(X(label_used==3,2)),'gd','Markersize',15,'markerfacecolor','m','markeredgecolor','m');
set(gcf,'color','k');
legend({'1','2','3','C1','C2','C3'},'fontsize',16,'location','southeast');
title(['Fisher''s Iris Data']);
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
xlabel('Petal Lengths (cm)','color','w','fontsize',14,'fontweight','bold');
ylabel('Petal Widths  (cm)','color','w','fontsize',14,'fontweight','bold');

frame=getframe(gcf);
im=frame2im(frame);
[I,map]=rgb2ind(im,256);
imwrite(I,map,'kmeans4.gif','gif', 'Loopcount',inf,'DelayTime',1.5);
close all


%% Gif 123
load fisheriris
X = meas(:,3:4); % Petal Length Petal Width
rng(123)
xr=nanmax(X(:,1)).*rand(3,1);
yr=nanmax(X(:,2)).*rand(3,1);

dist_full=NaN(150,3);

for i=1:3;
    dist_full(:,i)=(X(:,1) - xr(i)).^2+(X(:,2) - yr(i)).^2;
end

dist_cell=mat2cell(dist_full,ones(150,1),3);
label_used=cellfun(@(x)find(x==nanmin(x)),dist_cell);

for i=1:3;
    xr_re(i,1)=nanmean(X(label_used==i,1));
    yr_re(i,1)=nanmean(X(label_used==i,2));
end

trigger=1;

while ~(ismember(xr_re',xr','rows') && ismember(yr_re',yr','rows'))
    figure('pos',[10 10 1000 1000]);
    plot(X(label_used==1,1),X(label_used==1,2),'r.','Markersize',15);
    hold on
    plot(X(label_used==2,1),X(label_used==2,2),'b.','Markersize',15);
    hold on
    plot(X(label_used==3,1),X(label_used==3,2),'m.','Markersize',15);
    hold on
    plot(xr(1),yr(1),'rd','Markersize',15,'markerfacecolor','r','markeredgecolor','r');
    hold on
    plot(xr(2),yr(2),'bd','Markersize',15,'markerfacecolor','b','markeredgecolor','b');
    hold on
    plot(xr(3),yr(3),'gd','Markersize',15,'markerfacecolor','m','markeredgecolor','m');
    legend({'1','2','3','C1','C2','C3'},'fontsize',16,'location','southeast');
    text(2,2,['Iteration ' num2str(trigger)],'fontsize',16,'fontweight','bold');
    xlabel('Petal Lengths (cm)','color','w','fontsize',14,'fontweight','bold');
    ylabel('Petal Widths  (cm)','color','w','fontsize',14,'fontweight','bold');
    set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
    
    set(gcf,'color','k');
    
    frame=getframe(gcf);
    im=frame2im(frame);  
    [I,map]=rgb2ind(im,256);          
    if trigger==1
        imwrite(I,map,'rng123.gif','gif', 'Loopcount',inf,'DelayTime',1);
    else
        imwrite(I,map,'rng123.gif','gif','WriteMode','append','DelayTime',1);
    end
    close all
    
    
    xr=xr_re;yr=yr_re;
    dist_full=NaN(150,3);
    
    for i=1:3;
        dist_full(:,i)=(X(:,1) - xr(i)).^2+(X(:,2) - yr(i)).^2;
    end
    
    dist_cell=mat2cell(dist_full,ones(150,1),3);
    label_used=cellfun(@(x)find(x==nanmin(x)),dist_cell);
    
    for i=1:3;
        xr_re(i,1)=nanmean(X(label_used==i,1));
        yr_re(i,1)=nanmean(X(label_used==i,2));
    end
  
    trigger=trigger+1;
    
end

%% Gif 345
load fisheriris
X = meas(:,3:4); % Petal Length Petal Width
rng(123)
xr=nanmax(X(:,1)).*rand(3,1);
yr=nanmax(X(:,2)).*rand(3,1);

dist_full=NaN(150,3);

for i=1:3;
    dist_full(:,i)=(X(:,1) - xr(i)).^2+(X(:,2) - yr(i)).^2;
end

dist_cell=mat2cell(dist_full,ones(150,1),3);
label_used=cellfun(@(x)find(x==nanmin(x)),dist_cell);

for i=1:3;
    xr_re(i,1)=nanmean(X(label_used==i,1));
    yr_re(i,1)=nanmean(X(label_used==i,2));
end

trigger=1;

while ~(ismember(xr_re',xr','rows') && ismember(yr_re',yr','rows'))
    figure('pos',[10 10 1000 1000]);
    plot(X(label_used==1,1),X(label_used==1,2),'r.','Markersize',15);
    hold on
    plot(X(label_used==2,1),X(label_used==2,2),'b.','Markersize',15);
    hold on
    plot(X(label_used==3,1),X(label_used==3,2),'m.','Markersize',15);
    hold on
    plot(xr(1),yr(1),'rd','Markersize',15,'markerfacecolor','r','markeredgecolor','r');
    hold on
    plot(xr(2),yr(2),'bd','Markersize',15,'markerfacecolor','b','markeredgecolor','b');
    hold on
    plot(xr(3),yr(3),'gd','Markersize',15,'markerfacecolor','m','markeredgecolor','m');
    legend({'1','2','3','C1','C2','C3'},'fontsize',16,'location','southeast');
    text(2,2,['Iteration ' num2str(trigger)],'fontsize',16,'fontweight','bold');
    xlabel('Petal Lengths (cm)','color','w','fontsize',14,'fontweight','bold');
    ylabel('Petal Widths  (cm)','color','w','fontsize',14,'fontweight','bold');
    set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
    
    set(gcf,'color','k');
    
    frame=getframe(gcf);
    im=frame2im(frame);  
    [I,map]=rgb2ind(im,256);          
    if trigger==1
        imwrite(I,map,'rng123.gif','gif', 'Loopcount',inf,'DelayTime',1);
    else
        imwrite(I,map,'rng123.gif','gif','WriteMode','append','DelayTime',1);
    end
    close all
    
    
    xr=xr_re;yr=yr_re;
    dist_full=NaN(150,3);
    
    for i=1:3;
        dist_full(:,i)=(X(:,1) - xr(i)).^2+(X(:,2) - yr(i)).^2;
    end
    
    dist_cell=mat2cell(dist_full,ones(150,1),3);
    label_used=cellfun(@(x)find(x==nanmin(x)),dist_cell);
    
    for i=1:3;
        xr_re(i,1)=nanmean(X(label_used==i,1));
        yr_re(i,1)=nanmean(X(label_used==i,2));
    end
  
    trigger=trigger+1;
    
end

%% 
stepall=8;
for i=1:stepall
    picname=['rng',num2str(i),'.png'];
    Img=imread(picname);
    imshow(Img,[]);
     %set(gcf,'outerposition',get(0,'screensize'));
    frame=getframe(gcf);
    im=frame2im(frame);  
    [I,map]=rgb2ind(im,20);          
    if i==1
        imwrite(I,map,'rng.gif','gif', 'Loopcount',inf,'DelayTime',1.5);
    elseif i==stepall
        imwrite(I,map,'rng.gif','gif','WriteMode','append','DelayTime',1.5);
    else
        imwrite(I,map,'rng.gif','gif','WriteMode','append','DelayTime',1.5);
    end
    close all
end



