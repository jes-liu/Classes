%Jesse Liu 111639610
clear all;clc;
% #1
a1=rand([5 4]);
a1_index=numel(a1);
for i=(1:a1_index)
    if a1(i)>=.2
        a1(i)=1;
    elseif a1(i)5<.2;
        a1(i)=0;
    end
    i=i+1;
    disp(a1);
end

% #2
x=[3 2 6 8]';
y=[4 1 3 5]';
y=y+x;
x=x.^y;
y=y./x;
z=x.*y;
w=sum(z);

% #3
t=1:.2:2;
log(2+t+t.^2);
(exp(t)).*(1+cos(3.*t));
cos(t).^2 + sin(t).^2;

% #4
side1=3;
side2=4;
angle=pi/2;
[hypotenuse,cosine_rule]=ams333_hw1_4(side1,side2,angle);

% #5
func=.01:.0001:.1;
f=sin(1./func);
figure();
plot(func,f);

% #6
date=1790:2000;
num=2020;
p(num)=197273000./(1+exp(-.0313.*(num-1913.25)))
P(date)=197273000./(1+exp(-.0313.*(date-1913.25)));
figure();
plot(date,P(date));
fprintf('The population predicted in year 2020 is %.0f.\n',p(2020))

% #7
v=[];
app=1;
for n=2:30
[loutput]=ams333_hw1_7(n);
v(app)=loutput;
app=app+1;

end
v;
n=2:30;
figure();
plot(n,v)

% #8
a1 = -1;
b1 = 1;
a2 = -1;
b2 = 1;
n = 2000;

[x1pts,x2pts] = unif_over_rect(a1,b1,a2,b2,n);

success=[];
for index=1:2000
    diagonal(index)=sqrt(x1pts(index).^2+x2pts(index).^2);
    if diagonal(index)>=1
        success(index)=diagonal(index);
        index=index+1;
    end
end

frac_in_circ=nnz(success)/numel(x1pts)

% #9
fn(1)=1;
fn(2)=1;
for j=3:10
    fn(j)=fn(j-1)+fn(j-2);
end
    
for j=3:50
    fn(j)=fn(j-1)+fn(j-2);
    ratio=fn(j)./fn(j-1);
end
golden_mean=(1+sqrt(5))./2;
fprintf('My results show that the ratio of %.3f approaches the value of the',ratio)
fprintf(' golden mean of %.3f.\n',golden_mean)

% #10
index_a=1;
for x1=0
    while x1>=0&x1<=10
    %the loop will continue infinitely if you delete '&x1<=10'
    x1=x1+2;
    xa(index_a)=x1
    index_a=index_a+1;
    end
end

index_b=1;
for x2=12
    while x2<=12&x2>=-4;
    %the loop will continue infinitely if you delete '&x2>=-4'
    x2=x2-2;
    xb(index_b)=x2
    index_b=index_b+1;
    end
end

index_c=1;
for x3=1
    while x3<=1&x3>=.2
    %the loop will continue infinitely if you delete '&x3>=.2'
    x3=1/(index_c+1);
    xc(index_c+1)=x3
    xc(1)=1;
    index_c=index_c+1;
    end
end

index_d=1;
for x4=0
    while x4<=.8
    %the loop will continue infinitely if you 'x4<=.8' to 'x4<=1'
    x4=(index_d-1)/(index_d);
    xd(index_d)=x4
    index_d=index_d+1;
    end
end

% #11
h=1:100;
g=((-1).^(h+1))./(2.*h-1);
sum(g)