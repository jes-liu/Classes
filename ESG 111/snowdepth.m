% Jesse Liu 111639610
clear all;close all;clc;

file=fopen('snowd.txt');

if file==-1
    disp('File open not successful')
end

header=fgetl(file);
[headerinfo]=strsplit(header);

while feof(file)==0
    line=textscan(file,'%s %.2f %.2f %.2f %.2f %.2f');
    week=line{1};
    depth=line{2};
end

week=1:length(week);
figure(1)
hold on
plot(week,depth,'o')
xlabel('Week')
ylabel('Snow Depth')
title('Snow Depth per week')

timespan=linspace(1,length(week),200);
p2=polyfit(week,depth.',2);
p3=polyfit(week,depth.',3);
val2=polyval(p2,timespan);
val3=polyval(p3,timespan);
plot(timespan,val2)
plot(timespan,val3)
equation2=sprintf('%.2fx^2 + %.2fx + %.2f',p2(1),p2(2),p2(3));
equation3=sprintf('%.2fx^3 + %.2fx^2 + %.2fx + %.2f',p3(1),p3(2),p3(3),p3(4));
text(1.5,.5,equation2)
text(5.5,60,equation3)
legend('snow depth data','polynomial degree 2','polynomial degree 3','location','best')

r2=[p2(1) p2(2) p2(3)];
r3=[p3(1) p3(2) p3(3) p3(4)];
root2=roots(r2);
root3=roots(r3);
snow2=sprintf('2nd degree polynomial: \n%.4f\n%.4f\n',root2);
snow3=sprintf('3rd degree polynomial: \n%.4f\n%.4f\n%.4f\n',root3);
text(.5,90,snow2,'fontsize',7)
text(.5,72,snow3,'fontsize',7)
hold off
