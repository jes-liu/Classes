% Jesse Liu 111639610 Problem Set 1a

t=(0:.25:25);
% the array of time has 3 values; the first value is the start number, the
% second value is the interval at which the numbers will progress at, and
% the third value is the end number
% the quotation is there so the matrix is transposed so that it can be 
% multiplied

M=(6.78.*(cos((pi/2)*t)).*(exp(-0.21*t)))+25.4;
% the equation is written in matlab language. There is a . in front of the
% asterisk to let the computer know to multiply the two elements together

plot(t,M,'g--');
% using plot, the x variable, t, is placed first and the y variable, M, is
% placed second with the dotted green line

hold on;
% this is to prevent the computer from erasing the first graph. Hold is
% used to have the computer save the previous graph and plot a new graph on
% top of it

T=6.78.*exp(-0.21.*t)+25.4;
% the second plot equation

plot(t,T,'g--');
% second plot

title('protein concentration(mM) vs time(s)');
xlabel('time(s)');
ylabel('protein concentration(mM)');
legend('protein concentration M','protein concentration T');
grid on;
% title, labels, and legends used quotations to indicate it was not a
% variable but just a name. Grid on was used to turn on gridlines

q=1;
for r=(1:1:100);
    if M(r)<24.8;
       Q(q)=M(r);
       q=q+1;
    end
end
% the q is the index so that the computer can count the number of trials
% that satisfy the requirements for the new array. The 'for' loop is the
% index for the M equation to tell the computer how many trials TO do. The
% if statements are the requirements for the old array to satisfy the
% conditions of the new array. The Q(q)=M(r) is used so that if the 
% conditions are met, then it will put it into the new array Q(q).
% The q=q+1 is used before the end loop to prevent counting any zeros and 
% to tell the computer that once one trial is done, go on to the next one 
% by counting up by 1

A=numel(Q);
B=numel(M);
C=A/B;
% The numel command gives us the number of elements there are in that
% array. We can take the number of elements in array Q and divide it by the
% number of elements in array M to get the ratio

fprintf('Ratio = %.3f \n',C)
% fprintf prints the ratio on the command window
