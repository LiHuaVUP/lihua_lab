% load('trmm_re');
% ts=nanmean(reshape(trmm_re,61*17,6209));
% save ts_trmm ts
%% 1. mean climatology
load('ts')
date_used=datevec(datenum(1982,1,1):datenum(2019,12,31));
u_md=unique(date_used(:,2:3),'rows');
ts_clim=NaN(size(u_md,1),1);
for i=1:size(u_md,1)
    idx_here=date_used(:,2)==u_md(i,1) & ...
        date_used(:,3)==u_md(i,2);
    ts_clim(i)=nanmean(ts(idx_here));
end

plot(1:366,ts_clim,'linewidth',2)
set(gca,'linewidth',2);
ylabel('W/m^{2}');
xlim([1 366]);
set(gca,'xtick',15.25:30.5:366,'xticklabels',{'J','F','M','A','M','J','J','A','S','O','N','D'});

%% 2. harmonic climatology - one harmonic
load('ts');
Y = ts(:);
t = 1:length(ts);
x0 = ones(1,length(Y));
x1 = cos(2 * pi * t / 365.25);
x2 = sin(2 * pi * t / 365.25);
% x3 = cos(4 * pi * t / 365.25);
% x4 = sin(4 * pi * t / 365.25);
% x5 = cos(6 * pi * t / 365.25);
% x6 = sin(6 * pi * t / 365.25);

%X = [x0(:) x1(:) x2(:) x3(:) x4(:) x5(:) x6(:)];
X = [x0(:) x1(:) x2(:)];
coeffs = X\(Y(:));
ts_hclim=X*coeffs;

plot(1:366,ts_clim,'linewidth',2)
hold on
plot(1:366,ts_hclim(1:366),'linewidth',2);
set(gca,'linewidth',2);
ylabel('W/m^{2}');
xlim([1 366]);
set(gca,'xtick',15.25:30.5:366,'xticklabels',{'J','F','M','A','M','J','J','A','S','O','N','D'});
legend({'Mean','1st Harmonic'});

%% 2. harmonic climatology - one harmonic - trmm
load('ts_trmm')
date_used=datevec(datenum(1998,1,1):datenum(2014,12,31));
u_md=unique(date_used(:,2:3),'rows');
ts_clim=NaN(size(u_md,1),1);
for i=1:size(u_md,1)
    idx_here=date_used(:,2)==u_md(i,1) & ...
        date_used(:,3)==u_md(i,2);
    ts_clim(i)=nanmean(ts(idx_here));
end


load('ts_trmm');
Y = ts(:);
t = 1:length(ts);
x0 = ones(1,length(Y));
x1 = cos(2 * pi * t / 365.25);
x2 = sin(2 * pi * t / 365.25);
% x3 = cos(4 * pi * t / 365.25);
% x4 = sin(4 * pi * t / 365.25);
% x5 = cos(6 * pi * t / 365.25);
% x6 = sin(6 * pi * t / 365.25);

%X = [x0(:) x1(:) x2(:) x3(:) x4(:) x5(:) x6(:)];
X = [x0(:) x1(:) x2(:)];
coeffs = X\(Y(:));
ts_hclim=X*coeffs;

plot(1:366,ts_clim,'linewidth',2)
hold on
plot(1:366,ts_hclim(1:366),'linewidth',2);
set(gca,'linewidth',2);
%ylabel('W/m^{2}');
xlim([1 366]);
set(gca,'xtick',15.25:30.5:366,'xticklabels',{'J','F','M','A','M','J','J','A','S','O','N','D'});
legend({'Mean','1st Harmonic'});

%% 2. harmonic climatology - one harmonic - trmm
load('ts_trmm')
date_used=datevec(datenum(1998,1,1):datenum(2014,12,31));
u_md=unique(date_used(:,2:3),'rows');
ts_clim=NaN(size(u_md,1),1);
for i=1:size(u_md,1)
    idx_here=date_used(:,2)==u_md(i,1) & ...
        date_used(:,3)==u_md(i,2);
    ts_clim(i)=nanmean(ts(idx_here));
end


load('ts_trmm');
Y = ts(:);
t = 1:length(ts);
x0 = ones(1,length(Y));
x1 = cos(2 * pi * t / 365.25);
x2 = sin(2 * pi * t / 365.25);
% x3 = cos(4 * pi * t / 365.25);
% x4 = sin(4 * pi * t / 365.25);
% x5 = cos(6 * pi * t / 365.25);
% x6 = sin(6 * pi * t / 365.25);

%X = [x0(:) x1(:) x2(:) x3(:) x4(:) x5(:) x6(:)];
X = [x0(:) x1(:) x2(:)];
coeffs = X\(Y(:));
ts_hclim=X*coeffs;

plot(1:366,ts_clim,'linewidth',2)
hold on
plot(1:366,ts_hclim(1:366),'linewidth',2);
set(gca,'linewidth',2);
%ylabel('W/m^{2}');
xlim([1 366]);
set(gca,'xtick',15.25:30.5:366,'xticklabels',{'J','F','M','A','M','J','J','A','S','O','N','D'});
legend({'Mean','1st Harmonic'});

% three harmonic
load('ts_trmm');
Y = ts(:);
t = 1:length(ts);
x0 = ones(1,length(Y));
x1 = cos(2 * pi * t / 365.25);
x2 = sin(2 * pi * t / 365.25);
x3 = cos(4 * pi * t / 365.25);
x4 = sin(4 * pi * t / 365.25);
x5 = cos(6 * pi * t / 365.25);
x6 = sin(6 * pi * t / 365.25);

X = [x0(:) x1(:) x2(:) x3(:) x4(:) x5(:) x6(:)];
coeffs = X\(Y(:));
ts_thclim=X*coeffs;
figure
plot(1:366,ts_clim,'linewidth',2)
hold on
plot(1:366,ts_hclim(1:366),'linewidth',5);
hold on
plot(1:366,ts_thclim(1:366),'linewidth',5);
set(gca,'linewidth',2);
%ylabel('W/m^{2}');
xlim([1 366]);
set(gca,'xtick',15.25:30.5:366,'xticklabels',{'J','F','M','A','M','J','J','A','S','O','N','D'});
legend({'Mean','1st Harmonic','3rd Harmonic'});

%% 3. harmonic climatology - three harmonic
load('ts');
Y = ts(:);
t = 1:length(ts);
x0 = ones(1,length(Y));
x1 = cos(2 * pi * t / 365.25);
x2 = sin(2 * pi * t / 365.25);
x3 = cos(4 * pi * t / 365.25);
x4 = sin(4 * pi * t / 365.25);
x5 = cos(6 * pi * t / 365.25);
x6 = sin(6 * pi * t / 365.25);

X = [x0(:) x1(:) x2(:) x3(:) x4(:) x5(:) x6(:)];
coeffs = X\(Y(:));
ts_thclim=X*coeffs;

%% 4. plotting

