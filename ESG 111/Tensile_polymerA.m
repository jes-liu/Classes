clear all;close all;clc;

% file=fopen('Tensile_polymerA.txt');
% 
% if file==-1
%     disp('File open unsuccessful')
% end
% 
% header=fgetl(file);
% [headerinfo]=strsplit(header);
% 
% while feof(file)==0
%     line=textscan(file,'%f %f');
%     time=line{1};
%     strength=line{2};
% 
%   close=fclose(file);
% 
%   if close == 0
%       disp('File close successful')
%   else
%       disp('File close not successful')
%   end
% end

time=[0 10 15 20 25 40 50 55 60 75]';
strength=[0 5 20 18 40 33 54 70 60 78]';

plot(time,strength,'o')
xlabel('Time(min)')
ylabel('Strength(Pa)')
title('Tensile strength of plastic over time')

lin_fit=fit(time,strength,'poly1');
exp_fit=fit(time,strength,'exp1');

hold on
plot(lin_fit,'k')
plot(exp_fit,'r')
legend('Data','Line fit','Exp fit','location','best')
lin_eq=sprintf('E=%.3ftime+%.3f\n',lin_fit.p1,lin_fit.p2);
exp_eq=sprintf('E=%.3fexp(%.3ftime)\n',exp_fit.a,exp_fit.b);
text(20,50,lin_eq)
text(50,35,exp_eq)
hold off

lin_error_time=abs(time-lin_fit(time));
lin_error_strength=abs(strength-lin_fit(strength));
mean_lin_error_time=mean(lin_error_time);
mean_lin_error_strength=mean(lin_error_strength);
std_lin_error_time=std(lin_error_time);
std_lin_error_strength=std(lin_error_strength);

exp_error_time=abs(time-exp_fit(time));
exp_error_strength=abs(strength-exp_fit(strength));
mean_exp_error_time=mean(exp_error_time);
mean_exp_error_strength=mean(exp_error_strength);
std_exp_error_time=std(exp_error_time);
std_exp_error_strength=std(exp_error_strength);

fprintf('Error between data & fitting result\n')
fprintf('line fitting (time): mean error = %.2f min, std error = %.2f min\n',mean_lin_error_time,std_lin_error_time)
fprintf('line fitting (strength): mean error = %.2f Pa, std error = %.2f Pa\n',mean_lin_error_strength,std_lin_error_strength)
fprintf('exp fitting (time): mean error = %.2f min, std error = %.2f min\n',mean_exp_error_time,std_exp_error_time)
fprintf('exp fitting (strength): mean error = %.2f Pa, std error = %.2f Pa\n',mean_exp_error_strength,std_exp_error_strength)

st=input('Is the unknown variable strength[1] or time[2]? ');
if st==1
    Strength=input('Enter the strength: ');
elseif st==2
    Time=input('Enter the time: ');
else
    disp('Unknown Variable')
end

fit_type=input('Choose fit type: linear fit[1] or exponential fit[2]? ');
if fit_type==1 & st==1
    lin_fit_time=lin_fit(Strength);
    fprintf('The linear fit time for this strength is %.3f\n',lin_fit_time)
elseif fit_type==1 & st==2
    lin_fit_strength=lin_fit(Time);
    fprintf('The linear fit strength for this time is %.3f\n',lin_fit_strength)
elseif fit_type==2 & st==1
    exp_fit_time=exp_fit(Strength);
    fprintf('The exponential fit time for this strength is %.3f\n',exp_fit_time)
elseif fit_type==2 & st==2
    exp_fit_strength=exp_fit(Time);
    fprintf('The exponential fit strength for this time is %.3f\n',exp_fit_strength)
else
    disp('Unknown Error')
end