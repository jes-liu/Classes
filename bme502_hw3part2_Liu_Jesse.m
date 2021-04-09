%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.167 #4

n = 50;
A = zeros(n, n);
B = zeros(n, 1)+5;
P = zeros(n, 1)+1;

for i=1:n
    for j=1:n
        if i==j
            A(i,j) = 12;
            if i==1
                A(i,j+1) = -2;
                A(i,j+2) = 1;
            elseif i==2
                A(i,j-1) = -2;
                A(i,j+1) = -2;
                A(i,j+2) = 1;
            elseif i==49
                A(i,j-1) = -2;
                A(i,j+1) = -2;
                A(i,j-2) = 1;
            elseif i==50
                A(i,j-1) = -2;
                A(i,j-2) = 1;
            else
                A(i,j-1) = -2;
                A(i,j+1) = -2;
                A(i,j-2) = 1;
                A(i,j+2) = 1;
            end
        end
    end
end

delta = .0001;
max1 = 5;

X = gseid(A, B, P, delta, max1);

fprintf('\npg.167 #4\nX =\n')
disp(X)

%% pg.165 #5

A = [5 -1 1; 2 8 -1; -1 1 4];
B = [10 11 3];
P = zeros(length(B), 1);

Pk5_jacobi = jacobi(A, B, P, delta, max1);
Pk5_gseid = gseid(A, B, P, delta, max1);

fprintf('\npg.165 #5\nP using Jacobian iteration converges\nP =\n')
disp(Pk5_jacobi)
fprintf('P using Gauss-Seidel iteration converges\nP =\n')
disp(Pk5_gseid)

%% pg.165 #6

A = [2 8 -1; 5 -1 1; -1 1 4];
B = [11 10 3];
P = zeros(length(B), 1);

Pk6_jacobi = jacobi(A, B, P, delta, max1);
Pk6_gseid = gseid(A, B, P, delta, max1);

fprintf('\npg.165 #6\nP using Jacobian iteration diverges\nP =\n')
disp(Pk6_jacobi)
fprintf('P using Gauss-Seidel iteration diverges\nP =\n')
disp(Pk6_gseid)


%% functions

% Program 3.4
function X=jacobi(A,B,P,delta, max1)

% A is an N x N nonsingular matrix
% B is an N x 1 matrix
% P is an N x 1 matrix; the initial guess
% delta is the tolerance for P
% max1 is the maximum number of iterations

N = length(B);

for k=1:max1
    for j=1:N
        X(j)=(B(j)-A(j,[1:j-1,j+1:N])*P([1:j-1,j+1:N]))/A(j,j);
    end
    err=abs(norm(X'-P));
    relerr=err/(norm(X)+eps);
    P=X';
    if (err<delta) || (relerr<delta)
        break
    end
end
X=X';

end

% Program 3.5
function X=gseid(A,B,P,delta, max1)

% A is an N x N nonsingular matrix
% B is an N x 1 matrix
% P is an N x 1 matrix; the initial guess
% delta is the tolerance for P
% max1 is the maximum number of iterations

N = length(B);

for k=1:max1
    for j=1:N
       if j==1
          X(1)=(B(1)-A(1,2:N)*P(2:N))/A(1,1);
       elseif j==N
	      X(N)=(B(N)-A(N,1:N-1)*(X(1:N-1))')/A(N,N);
       else
	      % X contains the kth approximations and P the (k-1)st
         X(j)=(B(j)-A(j,1:j-1)*X(1:j-1)'-A(j,j+1:N)*P(j+1:N))/A(j,j);
       end
    end
    P=X';
    err=abs(norm(B-(A*P)));
    relerr=err/(norm(B)+eps);
    if (err<delta)||(relerr<delta)
        break
    end
end
X=X';

end