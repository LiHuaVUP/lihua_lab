Fs=8192;
xm=linspace(0,2*pi,Fs);
ym=sin(xm);
xs=linspace(0,1*pi,Fs);
ys=sin(xs);
xl=linspace(0,3*pi,Fs);
yl=sin(xl);
% I once had a girl
y1=gen_wave(5,1.5);
y2=gen_wave(6,1/3);
y3=gen_wave(5,1/3);
y4=gen_wave(4,1/6);
y5=gen_wave(3,1/6+1);

y=[y1 y2 y3 y4 y5];
%figure('pos',[10 10 1500 1500]);
plot(1:length(y),y);
hold on
title('I once had a girl','fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player)
x_here=length(y);


% or should I say
y3=gen_wave(2,2/5);
y4=gen_wave(4,1/5);
y5=gen_wave(3,2/5);
y6=gen_wave(1,1);

y=[y3 y4 y5 y6];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title('or should I say','fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% she once had me
y1=gen_wave(7+14,1/3);
y2=gen_wave(4,1/3);
y3=gen_wave(6+14,1/3);
y4=gen_wave(5+14,1);

y=[y1 y2 y3 y4];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title('she once had me','fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% she showed me her room
y1=gen_wave(5,1.5);
y2=gen_wave(6,1/3);
y3=gen_wave(5,1/3);
y4=gen_wave(4,1/3);
y5=gen_wave(3,1.5);

y=[y1 y2 y3 y4 y5];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title('she showed me her room','fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% isn't good 
y1=gen_wave(2,1/3);
y2=gen_wave(4,1/3);
y3=gen_wave(3,1/3);
y4=gen_wave(1,1);

y=[y1 y2 y3 y4];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title('isn''t good','fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% Norwegian Wood
y1=gen_wave(7+14,1/3);
y2=gen_wave(4,1/3);
y3=gen_wave(6+14,1/3);
y4=gen_wave(5+14,1);

y=[y1 y2 y3 y4];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title('Norwegian Wood','fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% she asked me to stay and she told me to sit anywhere
y1=gen_wave(6+14,1/2);
y2=gen_wave(3,1/3);
y3=gen_wave(3,1/3);
y4=gen_wave(3,1/3);
y5=gen_wave(3,1/3);
y6=gen_wave(2,1/3);
y7=gen_wave(2,1/3);
y8=gen_wave(2,1/3);
y9=gen_wave(1,1/3);
y10=gen_wave(1,1/3);
y11=gen_wave(1,1/5);
y12=gen_wave(2,2/5);
y13=gen_wave(1,1/5);
y14=gen_wave(2,1/5+1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'she asked me to stay and','she told me to sit anywhere'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% so I looked around and I noticed there wasn't a chair
y1=gen_wave(5+14,1/2);
y2=gen_wave(3,1/3);
y3=gen_wave(3,1/3);
y4=gen_wave(3,1/3);
y5=gen_wave(3,2/5);
y6=gen_wave(2,1/5);
y7=gen_wave(2,2/5);
y8=gen_wave(2,1/3);
y9=gen_wave(1,1/3);
y10=gen_wave(1,1/3);
y11=gen_wave(1,1/5);
y12=gen_wave(2,2/5);
y13=gen_wave(1,1/5);
y14=gen_wave(2,1/5+1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'so I looked around and','I noticed there wasn''t a chair'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% I sat on the rug, biding my time, drinking her wine
y1=gen_wave(5,1.5);
y2=gen_wave(6,1/3);
y3=gen_wave(5,1/3);
y4=gen_wave(4,1/3);
y5=gen_wave(3,1);
y6=gen_wave(2,1/3);
y7=gen_wave(4,1/3);
y8=gen_wave(3,1/3);
y9=gen_wave(1,1);
y10=gen_wave(7+14,1/3);
y11=gen_wave(4,1/3);
y12=gen_wave(6+14,1/3);
y13=gen_wave(5+14,1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'I sat on the rug','biding my time, drinking her wine'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% We talked until two, and then she said, it's time for bed
y1=gen_wave(5,1.5);
y2=gen_wave(6,1/3);
y3=gen_wave(5,1/3);
y4=gen_wave(4,1/3);
y5=gen_wave(3,1);
y6=gen_wave(2,1/3);
y7=gen_wave(4,1/3);
y8=gen_wave(3,1/3);
y9=gen_wave(1,1);
y10=gen_wave(7+14,1/3);
y11=gen_wave(4,1/3);
y12=gen_wave(6+14,1/6);
y13=gen_wave(5+14,1/6+1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'we talked until two','and then she said, it''s time for bed'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% she told me she worked in the morning and started to laugh
y1=gen_wave(6+14,1/2);
y2=gen_wave(3,1/3);
y3=gen_wave(3,1/3);
y4=gen_wave(3,1/3);
y5=gen_wave(3,1/3);
y6=gen_wave(2,1/3);
y7=gen_wave(2,1/3);
y8=gen_wave(2,1/3);
y9=gen_wave(1,1/3);
y10=gen_wave(1,1/3);
y11=gen_wave(1,1/5);
y12=gen_wave(2,2/5*1.5);
y13=gen_wave(1,1/5);
y14=gen_wave(2,1/5+1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'she told me she worked in the morning','and started to laugh'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% I told her I didnt and crawled out to sleep in the bath
y1=gen_wave(5+14,1/2);
y2=gen_wave(3,1/3);
y3=gen_wave(3,1/3);
y4=gen_wave(3,1/3);
y5=gen_wave(3,2/5);
y6=gen_wave(2,1/5);
y7=gen_wave(2,2/5);
y8=gen_wave(2,1/3);
y9=gen_wave(1,1/3);
y10=gen_wave(1,1/3);
y11=gen_wave(1,1/5);
y12=gen_wave(2,2/5);
y13=gen_wave(1,1/5);
y14=gen_wave(2,1/5+1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'I told her I didnt and','crawled out to sleep in the bath'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% and when I awoke, I was alone, this bird had flown
y1=gen_wave(5,1.5);
y2=gen_wave(6,1/3);
y3=gen_wave(5,1/3);
y4=gen_wave(4,1/3);
y5=gen_wave(3,1);
y6=gen_wave(2,1/3);
y7=gen_wave(4,1/3);
y8=gen_wave(3,1/3);
y9=gen_wave(1,1);
y10=gen_wave(7+14,1/3);
y11=gen_wave(4,1/3);
y12=gen_wave(6+14,1/3);
y13=gen_wave(5+14,1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'and when I awoke, I was alone','this bird had flown'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);

% so I lit a fire, isn't good, Norwegian Wood
y1=gen_wave(5,1.5);
y2=gen_wave(6,1/3);
y3=gen_wave(5,1/3);
y4=gen_wave(4,1/3);
y5=gen_wave(3,1);
y6=gen_wave(2,1/3);
y7=gen_wave(4,1/3);
y8=gen_wave(3,1/3);
y9=gen_wave(1,1);
y10=gen_wave(7+14,1/3);
y11=gen_wave(4,1/3);
y12=gen_wave(6+14,1/6);
y13=gen_wave(5+14,1/6+1.5);

y=[y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13];
plot(x_here+(1:length(y)),y);
hold on
xlim([x_here-500 x_here+length(y)]);
title({'so I lit a fire, isn''t good','Norwegian Wood'},'fontsize',20,'fontweight','bold');
player = audioplayer(y,Fs);
playblocking(player);
x_here=x_here+length(y);



% Fs=8192;
% sound(y,Fs);