N=1:1:300;
M=1:1:10000;
t_dif=NaN(300,10000);

rng(123);
for i=1:length(N);
    ts_here=rand(N(i),1);
    for j=1:length(M);
        weight_here=rand(N(i),1);
        group_here=fix((weight_here./nansum(weight_here)).*M(j));
        lake_num=M(j) - nansum(group_here);
        [~,loc]=sort(mod((weight_here./nansum(weight_here)).*M(j),1),'descend');
        group_here(loc(1:lake_num))=group_here(loc(1:lake_num))+1;
        ts_stack=NaN(length(group_here),1);
        trigger=1;
        for k=1:length(group_here);
            ts_stack(trigger:(trigger+group_here(k)-1))=...
                ts_here(k);
            trigger=trigger+group_here(k);
        end
        % Method 1
        tic
        ts_mean=nanmean(ts_stack);
        t1=toc;
        
        % Method 2
        tic 
        ts_mean=nansum(ts_here.*(group_here)./M(j));
        t2=toc;
        
        t_dif(N(i),M(j))=t2-t1;
    end
end
pcolor(t_dif);
shading flat
colormap(m_colmap('diverging',256));
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1]);
xlabel('M','color','w','fontsize',14,'fontweight','bold');
ylabel('n','color','w','fontsize',14,'fontweight','bold');
set(gcf,'color','k');
caxis([-3e-5 3e-5]);
s=colorbar('fontsize',14,'color','w');
s.Label.String='s';
frame=getframe(gcf);
im=frame2im(frame);
[I,map]=rgb2ind(im,256);
imwrite(I,map,'t_dif.gif','gif', 'Loopcount',inf,'DelayTime',1.5);
close all

%% 
x=19880131;
xdot=num2str(x);

%1 
xbar=NaN(length(xdot),1);

for i=1:length(xbar);
    xbar(i)=str2num(xdot(i));
end

%2
xbar=arryafun(@str2num,xdot);

y=str2num(xdot(1:4));
m=str2num(xdot(5:6));
d=str2num(xdot(7:8));

