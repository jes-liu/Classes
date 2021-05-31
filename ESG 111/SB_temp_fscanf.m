% Jesse liu 111639610
clear all;clc;

file=fopen('monthly_temp_SB.txt');

if file==-1
    disp('File open not successful')
end

header=fgetl(file);
[headerinfo]=strsplit(header);

data=fscanf(file,'%c%c%c %f %f %f %f %f\n',[8 12]);
month=char(data([1:3],:)');
avgtemp=data(4,:);
avghightemp=data(5,:);
avglowtemp=data(6,:);
highrectemp=data(7,:);
lowrectemp=data(8,:);

month=1:numel(month)./3;
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