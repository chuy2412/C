%C part 1
clear

n= 2500;

A = ([1 -1; 1 2]);

% sigma = [1 16];

var1 =1;
var2 =4;

A(1,:);
A(2,:);

 n1 = normrnd(0,var1,n,1);
 n2 = normrnd(0,var2,n,1);
% % 
%  hist(n1)
%  pause
%  hist(n2)
%  pause
% 
X1 = double(zeros(n));
X2 = double(zeros(n));

for i=1:n
%      X1(i) = A(1,1) *(n1(i)) + A(1,2)*(n1(i));
%      X2(i) = A(2,1) *(n2(i)) + A(2,2)*(n2(i));

   X1(i) = n1(i)*2;
   X2(i) = n2(i)*2;
end

 plot(X1,X2,'x');

