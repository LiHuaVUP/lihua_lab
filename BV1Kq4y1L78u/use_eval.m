name_used={'A','B','C','D','E'};
role=[1:5];

% Wrong Example 1

for i=1:5;
    name_used{i} = role(i);
end

% Wrong Example 2

for i=1:5;
    eval(name_used{i})=role(i);
end

% Correct Example

for i=1:5;
    eval([name_used{i} '=role(i);'])
end

% Generate Wind Data

rng(123);
wind_used={'u','v','w'};
scale_used={'20','20100','100'};
for i=1:length(wind_used);
    for j=1:length(scale_used);
        eval([wind_used{i} scale_used{j} '=rand(200,1);'])
    end
end

% Manually calculate mean

u100_mean=nanmean(u100);
u20_mean=nanmean(u20);
u20100_mean=nanmean(u20100);
v100_mean=nanmean(v100);
v20_mean=nanmean(v20);
v20100_mean=nanmean(v20100);
w100_mean=nanmean(w100);
w20_mean=nanmean(w20);
w20100_mean=nanmean(w20100);

% eval - loop calculate mean

wind_used={'u','v','w'};
scale_used={'20','20100','100'};
for i=1:length(wind_used);
    for j=1:length(scale_used);
        eval([wind_used{i} scale_used{j} '_mean=nanmean(' ...
            wind_used{i} scale_used{j} ');'])
    end
end



