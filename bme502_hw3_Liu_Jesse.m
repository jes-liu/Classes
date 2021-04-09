%% Jesse Liu 111639610
clear all; close all; clc;

%% pg.118 #4b

A = [-1 -7; 5 2];
B = [2 0 6; -1 5 -4; 3 -5 2];

A2 = A*A;
B2 = B*B;

disp('pg.118 #4b')
disp('A^2 =')
disp(A2)
disp('B^2 =')
disp(B2)

%% pg.118 #5b

a = [2 0 6; -1 5 -4; 3 -5 2];

d = det(a);

disp('pg.118 #5b')
fprintf('det of a is %.0f\n\n', d)

%% pg.138 #8

D = [4 8 4 0; 1 5 4 -3; 1 4 7 2; 1 3 0 -2];

Dx1 = [8 8 4 0; -4 5 4 -3; 10 4 7 2; -4 3 0 -2];
Dx2 = [4 8 4 0; 1 -4 4 -3; 1 10 7 2; 1 -4 0 -2];
Dx3 = [4 8 8 0; 1 5 -4 -3; 1 4 10 2; 1 3 -4 -2];
Dx4 = [4 8 4 8; 1 5 4 -4; 1 4 7 10; 1 3 0 -4];

detD = det(D);
detx1 = det(Dx1);
detx2 = det(Dx2);
detx3 = det(Dx3);
detx4 = det(Dx4);

x1 = detx1/detD;
x2 = detx2/detD;
x3 = detx3/detD;
x4 = detx4/detD;

disp('pg.138 #8')
fprintf('x1 = %.0f\nx2 = %.0f\nx3 = %.0f\nx4 = %.0f\n', x1, x2, x3, x4)

%% pg.125 #3

i = 20;
j = 20;

L = zeros(i, j);
for i=1:i
    for j=1:j
        if i >= j
            num = i + j;
        elseif i < j
            num = 0;
        end
        L(i, j) = num;
    end
end

B = zeros(i, 1);
for i=1:20
    B(i, 1) = i;
end

Y = forsub(L, B);

fprintf('\npg.125 #3\nY =\n')
disp(Y)

%% pg.154 #1

A = [1 3 5 7; 2 -1 3 5; 0 0 2 5; -2 -6 -3 1];
B = [1 2 3 4];

X = lufact(A, B);
[L, U, P] = lu(A);

fprintf('\npg.154 #1\nX =\n')
disp(X)
%% pg. 155 #4a

R = [1+2+1, 2, 1; 2, 1+2+2, -2; 1, -2, 1+2+4];
E = [23 29 0];

X = lufact(R, E);

fprintf('\npg. 155 #4a\nX =\n')
disp(X)

%% pg.125 #2

function X = forsub(A,B)

% A is an N x N lower-trianglular nonsingular matrix
% B is an N x 1 matrix
% X is the solution to the linear system AX = B
% Find dimensions of B and initialize it

n = length(B);
X = zeros(n, 1);
X(1) = B(1)/A(1,1);

for k=2:n
    X(k) = (B(k) - A(k,1:k-1)*X(1:k-1))/A(k,k);
end
end

%% functions

% Program 3.1
function X = backsub(A,B)

% A is an N x N upper-trianglular nonsingular matrix
% B is an N x 1 matrix
% X is the solution to the linear system AX = B
% Find dimensions of B and initialize it

n = length(B);
X = zeros(n, 1);
X(n) = B(n)/A(n,n);

for k=n:-1:1
    X(k) = (B(k) - A(k,k+1:n)*X(k+1:n))/A(k,k);
end
end

% Program 3.3
function X = lufact(A,B)

% A is an N x N matrix
% B is an N x 1 matrix
% X is an N x 1 matrix (AX = B)
% Initialize X, Y, the temporary storage C, and the 
% row permutation information matrix R

[~, N] = size(A);
X = zeros(N, 1);
Y = zeros(N, 1);
C = zeros(1, N);
R = 1:N;

for p=1:N-1
    % Find the pivot row for column p
    [~, j] = max(abs(A(p:N, p)));
    % Interchange row p and j
    C = A(p,:);
    A(p,:) = A(j+p-1,:);
    A(j+p-1,:) = C;
    d = R(p);
    R(p) = R(j+p-1);
    R(j+p-1) = d;
    
    if A(p,p)==0
        disp('A is singular. No unique solution')
        break
    end
    
    % Calculate multiplier and place in subdiagonal portion of A
    for k=p+1:N
        mult = A(k,p)/A(p,p);
        A(k,p) = mult;
        A(k,p+1:N) = A(k,p+1:N) - mult*A(p,p+1:N);
    end
end

% Solve for Y
Y(1) = B(R(1));

for k=2:N
    Y(k) = B(R(k)) - A(k,1:k-1)*Y(1:k-1);
end

% Solve for X
X(N) = Y(N)/A(N,N);

for k=N-1:-1:1
    X(k) = (Y(k) - A(k,k+1:N)*X(k+1:N))/A(k,k);
end
end