%% Example 1 - ENSO+ and ENSO-
% Read Data
enso=readtable('enso_index.xlsx','ReadVariableNames',true);
enso=enso{:,:};
enso_year=enso(:,1);
enso=enso(:,2:end);
enso=enso';
enso=enso(:);

% ENSO+

tf=bwlabel(enso>=0.5);
event_collect=NaN(nanmax(unique(tf)),2);
for i=1:nanmax(unique(tf))
    event_collect(i,1)=i;
    event_collect(i,2)=nansum(tf==i);
end

tf(ismember(tf,event_collect(event_collect(:,2)<5,1)))=0;
event_collect(event_collect(:,2)<5,:)=[];

% ENSO-

tf_l=bwlabel(enso<=-0.5);
event_collect_l=NaN(nanmax(unique(tf_l)),2);
for i=1:nanmax(unique(tf_l))
    event_collect_l(i,1)=i;
    event_collect_l(i,2)=nansum(tf_l==i);
end

tf_l(ismember(tf_l,event_collect_l(event_collect_l(:,2)<5,1)))=0;
event_collect_l(event_collect_l(:,2)<5,:)=[];

x=datevec(datenum(enso_year(1),1,1):datenum(enso_year(end),12,31));
x=unique(x(:,1:2),'rows');
x=[x 15*ones(size(x,1),1)];
x=datenum(x);
plot(x,enso,'linewidth',1,'color','k')
datetick

for i=1:size(event_collect,1);
    hold on
    x1=x(tf==event_collect(i,1));
    y1=enso(tf==event_collect(i,1));
    
    x2=x1(end:-1:1);
    y2=zeros(size(x2));
    h1=patch([x1;x2],[y1;y2],[1 0.3 0.3],'FaceAlpha',.5,'edgecolor','none');
end

for i=1:size(event_collect_l,1);
    hold on
    x1=x(tf_l==event_collect_l(i,1));
    y1=enso(tf_l==event_collect_l(i,1));
    
    x2=x1(end:-1:1);
    y2=zeros(size(x2));
    h2=patch([x1;x2],[y1;y2],[0.3 0.3 1],'FaceAlpha',.5,'edgecolor','none');
end
legend([h1 h2],{'ENSO+','ENSO-'});
set(gca,'fontname','consolas','fontsize',14);
xlim([datenum(enso_year(1),1,1) datenum(enso_year(end),12,31)]);

%% Example 2 - Normal/Strong/Extreme ENSO 
% Read Data
enso=readtable('enso_index.xlsx','ReadVariableNames',true);
enso=enso{:,:};
enso_year=enso(:,1);
enso=enso(:,2:end);
enso=enso';
enso=enso(:);

std_used=nanstd(enso);

logic_index=[0.5;1;2;-0.5;-1;-2];
events=cell(2,6);

for l=1:length(logic_index)
    if logic_index(l)>0
        tf=bwlabel(enso>=logic_index(l));
    else
        tf=bwlabel(enso<=logic_index(l));
    end
    
    event_collect=NaN(nanmax(unique(tf)),2);
    for i=1:nanmax(unique(tf))
        event_collect(i,1)=i;
        event_collect(i,2)=nansum(tf==i);
    end
    events{1,l}=tf;
    events{2,l}=event_collect;
end
color_used=[[1 0.7 0.7];[1 0.3 0.3];[1 0 0];[0.7 0.7 1];[0.3 0.3 1];[0 0 1]];

x=datevec(datenum(enso_year(1),1,1):datenum(enso_year(end),12,31));
x=unique(x(:,1:2),'rows');
x=[x 15*ones(size(x,1),1)];
x=datenum(x);
plot(x,enso,'linewidth',1,'color','k')
datetick

for l=1:6;
    tf=events{1,l};
    event_collect=events{2,l};
    for i=1:size(event_collect,1);
        hold on
        x1=x(tf==event_collect(i,1));
        y1=enso(tf==event_collect(i,1));
        
        x2=x1(end:-1:1);
        y2=zeros(size(x2));
        h=patch([x1;x2],[y1;y2],color_used(l,:),'FaceAlpha',.5,'edgecolor','none');
        eval(['h' num2str(l) '=h'])
    end
    
end

legend([h1 h2 h3 h4 h5 h6],{'>0.5\sigma','>1\sigma','>2\sigma','<-0.5\sigma','<-1\sigma','<-2\sigma'},'numcolumns',2);
set(gca,'fontname','consolas','fontsize',14);
xlim([datenum(enso_year(1),1,1) datenum(enso_year(end),12,31)]);

%% bwlabel example
ex=[1 1 0 1 1 1 0 0 1];
ex
bwlabel(ex==1)

