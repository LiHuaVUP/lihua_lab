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