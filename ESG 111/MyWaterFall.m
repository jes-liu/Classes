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

z=[avgtemp avghightemp avglowtemp highrectemp lowrectemp]';
Waterfall=waterfall(z);
Waterfall.FaceAlpha=0.5;
Waterfall.LineWidth=2;
xlabel('month')
xticks(1:12)
xticklabels(month)
ylabel('temp data')
yticks(1:5)
yticklabels({'avgtemp','avghightemp','avglowtemp','highrectemp','lowrectemp'})
zlabel('Temp/F')
title('SB monthly temp data')