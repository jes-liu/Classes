%Jesse Liu 111639610

x_0=input('Enter the principle amount:');
r=input('Enter the interest rate in decimal:');
n=input('Enter the term of year:');
k=input('Enter how many times compounded per year:');

amount=fn_interest(1000,5,.06,[4,365,1])
[Interest,X]=fn_interest(x_0,r,n,k);

bar(amount)
title('Earned interest for 5 years term with 6% interest rate')
xlabel('Compound Interval, 1: Quarterly, 2: Daily, 3: Annually')
ylabel('Interest, $')
ylim([0 400])

fprintf('The principle amount of $%d in %d years with interest rate of \n',x_0,n)
fprintf('%.2f%% becomes $%.2f when interest is comopounded %d times a year. \n',r,X,k)
fprintf('Your earning amount is $%.2f.\n',Interest)
