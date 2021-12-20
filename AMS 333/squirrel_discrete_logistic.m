%Jesse Liu 111639610
clear all;clc;

% Used to find the graph that moves towards a steady state
N0=1:50;
r=[.1 3.99];
N(1)=.25;

% Each r value is looped through data points towards a steady state
for i=1:2
    for n=1:50
        N(n+1) = r(i).*N(n).*(1-N(n));
        x(n,i)=N(n);
    end
end

% Used to label the graphs for the steady states
figure(1)
hold on
plot(N0,x(:,1),'-o')
plot(N0,x(:,2),'-o')
title('Discrete Logistic Model')
xlabel('Time')
ylabel('Population')
yline(0,'g');
yline(1,'g');
ylim([-.1 1.1])
legend('r=0.1','r=3.99','Steady State')
legend('Location','northeastoutside')

% Used to find the graphs for the following r values
r=[2.5;2.8;3.2;3.5;3.56;3.83;3.87];
N(1)=.25;

% Each r value is looped through data points and combined into the table y
for i=1:7
    for n=1:50
        N(n+1) = r(i).*N(n).*(1-N(n));
        y(n,i)=N(n);
    end
    i=i+1;
end

% First 6 r values are plotted on the same graph
figure(2)
hold off
for i=1:6
    hold on
    plot(N0,y(:,i))
end

% Used to label multiple r value plot
xlabel('Time')
ylabel('Population')
title('Discrete Logistic Model')
legend('r=2.5','r=2.8','r=3.2','r=3.5','r=3.56','r=3.83')
legend('Location','northeastoutside')

% Used to label the r=3.87 plot
hold off
figure(3)
plot(N0,y(:,7))
xlabel('Time')
ylabel('Population')
title('Discrete Logistic Model')
legend('r=3.87')