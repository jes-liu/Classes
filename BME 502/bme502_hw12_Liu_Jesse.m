%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.556 #1

a=1;
b=1;
c=1;
f=@(x) sin(pi*x);
g=@(x) 0;
h=.1;
k=.1;
n=((a-0)/h)+1;
m=((b-0)/k)+1;

U = finedif(f,g,a,b,c,n,m);

fprintf('pg.556 #1\nSolution =\n')
disp(U)

figure()
surf(U)
title('pg.556 #1 Surf Plot')
figure()
contour(U)
title('pg.556 #1 Contour Plot')

%% pg.567 #3

c1=@(t) t^2;
c2=@(t) exp(t);
a=1;
b=1;
n=((a-0)/h)+1;
m=((b-0)/k)+1;
c=1;
f1=@(x) sin(pi*x) + sin(2*pi*x);
f2=@(x) 3 - abs(3*x-1) - abs(3*x-2);

U1=crnich(f1,c1,c2,a,b,c,n,m);
U2=crnich(f2,c1,c2,a,b,c,n,m);

fprintf('pg.567 #3b\nSolution_problem1 =\n')
disp(U1)
fprintf('Solution_problem2 =\n')
disp(U2)

figure()
surf(U1)
title('pg.567 #3c Problem 1 Surf Plot')
figure()
contour(U1)
title('pg.567 #3c Problem 1 Contour Plot')

figure()
surf(U2)
title('pg.567 #3c Problem 2 Surf Plot')
figure()
contour(U2)
title('pg.567 #3c Problem 2 Contour Plot')

%% pg.582 #1

f1=@(x) x.^4;
f2=@(x) x.^4 - 13.5.*x.^2 + 5.0625;
f3=@(y) y.^4;
f4=@(y) y.^4 - 13.5.*y.^2 + 5.0625;
a=1.5;
b=1.5;
h=.5;
tol=.0001;
max1=5;

U=dirich(f1,f2,f3,f4,a,b,h,tol,max1);
fprintf('pg.582 #1a\nSolution =\n')
disp(U)

figure()
surf(U)
title('pg.582 #1b Surf Plot')

fprintf(['pg.582 #1b\nCompared to the exact solution u(x,y)=x^4−6(x^2)(y^2)+y^4,'...
    '\nthe approximation in part(a) is very close and the small error is'...
    '\nalmost negligible\n'])

%% Program 10.1
function U = finedif(f,g,a,b,c,n,m)

%Input - f=u(x,0) as a string ’f’
%- g=ut(x,0) as a string ’g’
%- a and b right endpoints of [0,a] and [0,b]
%- c the constant in the wave equation
%- n and m number of grid points over [0,a] and [0,b]
%Output - U solution matrix; analogous to Table 10.1
%Initialize parameters and U

h=a/(n-1);
k=b/(m-1);
r=c*k/h;
r2=r^2;
r22=r^2/2;
s1=1-r^2;
s2=2-2*r^2;
U=zeros(n,m);

%Compute first and second rows
for i=2:n-1
    U(i,1)=feval(f,h*(i-1));
    U(i,2)=s1*feval(f,h*(i-1))+k*feval(g,h*(i-1))+r22*(feval(f,h*i)+feval(f,h*(i-2)));
end

%Compute remaining rows of U
for j=3:m
    for i=2:(n-1)
        U(i,j) = s2*U(i,j-1)+r2*(U(i-1,j-1)+U(i+1,j-1))-U(i,j-2);
    end
end

U=U';
end

%% pg.567 #3a - Modified Program 10.2
function U=forwdif(f,c1,c2,a,b,c,n,m)

%Input - f=u(x,0) as a string ’f’
%- c1=u(0,t) and c2=u(a,t)
%- a and b right endpoints of [0,a] and [0,b]
%- c the constant in the heat equation
%- n and m number of grid points over [0,a] and [0,b]
%Output - U solution matrix; analogous to Table 10.4

%Initialize parameters and U
h=a/(n-1);
k=b/(m-1);
r=c^2*k/h^2;
s=1-2*r;
U=zeros(n,m);

%Boundary conditions
U(1,1:m)=feval(c1,k);
U(n,1:m)=feval(c2,k);

%Generate first row
U(2:n-1,1)=feval(f,h:h:(n-2)*h)';

%Generate remaining rows of U
for j=2:m
    for i=2:n-1
        U(i,j)=s*U(i,j-1)+r*(U(i-1,j-1)+U(i+1,j-1));
    end
end

U=U';
end

%% pg.567 #3a - Supplmental Function trisys
function X=trisys (A,D,C,B)

%Input    - A is the sub diagonal of the coefficient matrix
%            - D is the main diagonal of the coefficient matrix
%            - C is the super diagonal of the coefficient matrix
%            - B is the constant vector of the linear system
%Output - X is the solution vector

%  NUMERICAL METHODS: Matlab Programs
% (c) 2004 by John H. Mathews and Kurtis D. Fink
%  Complementary Software to accompany the textbook:
%  NUMERICAL METHODS: Using Matlab, Fourth Edition
%  ISBN: 0-13-065248-2
%  Prentice-Hall Pub. Inc.
%  One Lake Street
%  Upper Saddle River, NJ 07458

N=length(B);
for k=2:N
   mult=A(k-1)/D(k-1);
   D(k)=D(k)-mult*C(k-1);
   B(k)=B(k)-mult*B(k-1);
end

X(N)=B(N)/D(N);

for k= N-1:-1:1
   X(k)=(B(k)-C(k)*X(k+1))/D(k);
end

end

%% pg.567 #3a - Modified Program 10.3
function U=crnich(f,c1,c2,a,b,c,n,m)

%Input - f=u(x,0) as a string ’f’
%- c1=u(0,t) and c2=u(a,t)
%- a and b right endpoints of [0,a] and [0,b]
%- c the constant in the heat equation
%- n and m number of grid points over [0,a] and [0,b]
%Output - U solution matrix; analogous to Table 10.5
%Initialize parameters and U

h=a/(n-1);
k=b/(m-1);
r=c^2*k/h^2;
s1=2+2/r;
s2=2/r-2;
U=zeros(n,m);

%Boundary conditions
U(1,1:m)=feval(c1,k);
U(n,1:m)=feval(c2,k);

%Generate first row
U(2:n-1,1)=feval(f,h:h:(n-2)*h)';

%Form the diagonal and off-diagonal elements of A and
%the constant vector B and solve tridiagonal system AX=B
Vd(1,1:n)=s1*ones(1,n);
Vd(1)=1;
Vd(n)=1;
Va=-ones(1,n-1);
Va(n-1)=0;
Vc=-ones(1,n-1);
Vc(1)=0;
Vb(1)=feval(c1,k);
Vb(n)=feval(c2,k);

for j=2:m
    for i=2:n-1
        Vb(i)=U(i-1,j-1)+U(i+1,j-1)+s2*U(i,j-1);
    end
    X=trisys(Va,Vd,Vc,Vb);
    U(1:n,j)=X';
end

U=U';
end

%% Program 10.4
function U=dirich(f1,f2,f3,f4,a,b,h,tol,max1)

%Input - f1,f2,f3,f4 are boundary functions input as strings
%- a and b right endpoints of [0,a] and [0,b]
%- h step size
%- tol is the tolerance
%Output - U solution matrix; analogous to Table 10.6
%Initialize parameters and U

n=fix(a/h)+1;
m=fix(b/h)+1;
ave=(a*(feval(f1,0)+feval(f2,0))+b*(feval(f3,0)+feval(f4,0)))/(2*a+2*b);
U=ave*ones(n,m);

%Boundary conditions
U(1:n,1)=feval(f1,0:h:(n-1)*h);
U(1:n,m)=feval(f2,0:h:(n-1)*h);
U(1,1:m)=feval(f3,0:h:(m-1)*h)';
U(n,1:m)=feval(f4,0:h:(m-1)*h)';
U(1,1)=(U(1,2)+U(2,1))/2;
U(1,m)=(U(1,m-1)+U(2,m))/2;
U(n,1)=(U(n-1,1)+U(n,2))/2;
U(n,m)=(U(n-1,m)+U(n,m-1))/2;

%SOR parameter
w=4/(2+sqrt(4-(cos(pi/(n-1))+cos(pi/(m-1)))^2));

%Refine approximations and sweep operator throughout
%the grid
err=1;
cnt=0;

while((err>tol)&&(cnt<=max1))
    err=0;
    for j=2:m-1
        for i=2:n-1
            relx=w*(U(i,j+1)+U(i,j-1)+U(i+1,j)+U(i-1,j)-4*U(i,j))/4;
            U(i,j)=U(i,j)+relx;
            if (err<=abs(relx))
                err=abs(relx);
            end
        end
    end
    cnt=cnt+1;
end

U=flipud(U');
end