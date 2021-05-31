% Jesse liu 111639610
clear all;clc;

file=fopen('monthly_temp_SB.txt');

if file==-1
    disp('File open not successful')
end

header=fgetl(file);
[headerinfo]=strsplit(header);

while feof(file)==0
    line=textscan(file,'%s %.2f %.2f %.2f %.2f %.2f');
    month=line{1};
    avgtemp=line{2};
    avghightemp=line{3};
    avglowtemp=line{4};
    highrectemp=line{5};
    lowrectemp=line{6};
end

month=1:numel(month);
hold on
plot(month,avgtemp,'bo')
plot(month,avghightemp,'ro')
plot(month,avglowtemp,'go')
plot(month,highrectemp,'co')
plot(month,lowrectemp,'mo')
xlabel('month')
ylabel('temp')
title('Monthly temperature info at Stony Brook')
legend('avgtemp','avghightemp','avglowtemp','highrectemp','lowrectemp')
legend('Location','south')