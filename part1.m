%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Assignment C part 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

eta = 0.1;
n= 800;  %number of elements

%Initialize the weights with random values
W = 0.1*rand(n);

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
plot(S(1,:))
%axis([-15 15 0 250])    %[xmin xmax ymin ymax]
title('Histogram of S1')
drawnow

%Plot Histogram of S2
subplot(3,1,2)
plot(S(2,:))
%axis([-15 15 0 250])    %[xmin xmax ymin ymax]
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


% Y_transpose = X' * W';
% Y = Y_tranpose';
% fy = Y^3;
% 
% %Missing value for I
% deltaW = eta * (I - fy*Y_transpose)* W;
% W = W + deltaW;



