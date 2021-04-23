%% Fig 1
clear all;clc;

for i=97:122
    alpha(i-96)=char(i)';
    fprintf('%s\n',alpha)
end

for i=1:25
    fprintf('%s\n',alpha(1:end-i))
end

%% Fig 2
clear all;clc;

for i=97:122
    beta(i-96)=char(i)';
end

for i=1:length(beta)
    fprintf('%s\n',beta(1:end+1-i))
end

%% Fig 3
clear all;clc;

for i=97:122
    delta(i-96)=char(i)';
end

for i=1:length(delta)+1
    fprintf('%s\n',delta)
    sub=delta(1);
    for i=1:length(delta)-1
        delta(i)=delta(i+1);
    end
    delta(end)=sub;
end