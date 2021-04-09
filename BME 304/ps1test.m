t=(0:.25:25);
M=(6.78.*(cos((pi/2).*t)).*(exp(-0.21.*t)))+25.4;
T=6.78.*exp(-0.21.*t)+25.4;



plot(t,M,'g--');
hold on
plot(t,T,'g--')
title('protein concentration(mM) vs time(s)')
xlabel('time(s)')
ylabel('protein concentration(mM)')
legend('protein concentration M','protein concentration T')
grid on
hold off




q=1;
for r=(0:0.25:25)
    if M(q)<24.8
       S(q)=M(q)
    end
    q=q+1
end

A=numel(S);
B=numel(M);
C=A/B
       
















