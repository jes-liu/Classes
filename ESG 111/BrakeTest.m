clear all;clc;

v=input('Enter the velocity: ');
calculate=input('Find db[1] or mu[2]? ');

if calculate==1
    mu=input('Enter the mu value: ');
    db=fn_BrakeDist(v,mu);
    fprintf('The braking distance is %.2f\n',db)
elseif calculate==2
    db=input('Enter the db value: ');
    mu=fn_BrakeEffic(v,db);
    fprintf('The braking efficiency is %.2f\n',mu)
end

v=100;
db=5:.01:10;
mu=fn_BrakeEffic(v,db);
plot(db,mu)
xlabel('Braking distance')
ylabel('Braking Efficiency')