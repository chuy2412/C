%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Assignment C part 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

eta = 0.1;
error=1e-2;
iter=1;
n= 10;  %number of elements

%Initialize the weights with random values
W = 0.1*rand(n,2);

%Mixing matrix
A = ([1 -1; 1 2]);

%Variance for the sources
Svar1 =1;
Svar2 =4;

%Generate the sources
S = double(zeros(2,n));
S(1,:) = normrnd(0,Svar1,n,1);
S(2,:) = normrnd(0,Svar2,n,1);

%Observation vector X = Source * mixer matrix
X = A*S;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Histogram of S1
subplot(3,1,1)
hist(S(1,:))
axis([-15 15 0 250])    %[xmin xmax ymin ymax]
title('Histogram of S1')
drawnow

%Plot Histogram of S2
subplot(3,1,2)
hist(S(2,:))
axis([-15 15 0 250])    %[xmin xmax ymin ymax]
title('Histogram of S2');
drawnow

%Plot X1,X2
subplot(3,1,3)
plot(X(1,:),X(2,:),'x');
title('Two-dimensional distribution of the signals X1 and X2');
xlabel('X1');
ylabel('X2');
drawnow

I = double(zeros(n));

%%%%%%%%%%%%%%%%%%%%%%%
%Training
%P(x) = 1 / (sqrt(2*pi*variance)) * exp (- ((x - miu)^2)/(2*variance^2));

% %Py(Y) = Px(X) / det(W);
% Py_Y = Px(X) / det(W);
%While Py(y) <= [||]i_to_n Py_i(Py_i)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Source:
%http://www.mathworks.com/matlabcentral/fileexchange/
%6267-neural-networks-a-comprehensive-foundation-2e-book-companion-software/
%content/haykin/ica.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:iter

 %Demixing X with W
 y=W*X;

 %Activation function
 f=(3/4)*y.^11+(25/4)*y.^9+(-14/3)*y.^7+(-47/4)*y.^5+(29/4)*y.^3;

 dW=(eye(n)-f*y')*W;

 %Update the weight
 W=W+ eta*dW;

% Break if Algorithm diverges
 if (sum(sum(isnan(W)))>0) flag=1; break; end
   max(max(abs(dW)));

% Break if Algorithm converges-- max weight update is less than error
 if (max(max(abs(dW)))<error & i>10) break; end;

end


