function stommel_plot(BETA)
% Copyright @LiHua https://space.bilibili.com/297360465
D=200;R=0.02;BETA=BETA;b=6249000;a=1e7;

LAMBDA=a;

x=linspace(0.5,LAMBDA,400);
y=linspace(0.5,b,200);
[x,y]=meshgrid(x,y);


ALPHA=(D./R).*BETA;

A=-ALPHA./2+sqrt((ALPHA./2).^2+(pi./b).^2);

B=-ALPHA./2-sqrt((ALPHA./2).^2+(pi./b).^2);

P=(1-exp(B.*LAMBDA))./(exp(A.*LAMBDA)-exp(B.*LAMBDA));

Q=1-P;

PHI=1000*((b./pi).^2).*sin(pi.*y./b).*(P.*exp(A.*x)+Q.*exp(B.*x)-1);

contour(PHI,'color','k','linewidth',2);
set(gca,'xtick',[],'ytick',[]);
title(['BETA = ' num2str(BETA)],'fontsize',14','fontweight','bold');