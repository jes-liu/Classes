clear all; close all
global t T N

% data = load('data_bacteria.txt') ; % Load the bacteria data 
% t=data(:,1);   % Select data column 1 and assign to t
% N=data(:,2);   % Select data column 2 and assign to N

N0=1000;    % intial population c, N
T=3;    % doubling time T 
t=0:15;   % Time step ever 20 min

figure;

% plot(t,N,'or','LineWidth',2);

title('Bacterial Growth')
xlabel('Time (minutes)')
ylabel('Bacteria Biomass (Number)')

hold on

plot(t,exponent_model(t,T,N0),'blue','LineWidth',2);
print('-r300','-djpeg',[ 'fig_exp','.jpeg'])

%%%% After main code
function y = exponent_model(t,T,N0)
y= N0.*(2.^(t./T))  ;
end
