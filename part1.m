%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Assignment C part 1
%CSE885
%Jesus Rivera
%Description:
%   This program Randomly creates 2 signals (S)
%   with n samples (by default n=750).
%   Source 1 has 0 mean and variance of 1
%   Source 2 has 0 mean and variance of 4
%   Then, it mixes the sources with a mixing matrix (A)
%   to create the observable vector (X).
%   Finally, it computes Y using ICA and SOM methods to demix (X)
%   and plot the results with each method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear        %clear previous values

eta = 0.6;   %Learning rate
n= 750;      %number of elements
train = 160; %Number of training steps

%Initialize the weights with random values
W = 0.01*rand(2,2);

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
pause(0.1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute Self-Organizing Maps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A,W_SOM] = som(X,n, train, eta);

W_SOM = W_SOM(1,:);
Y_SOM = W*X;

%Compute the amplitude
Amplitude1_SOM = max(S(1,:)) / max(max(Y_SOM(1,:))); 
Amplitude2_SOM = max(S(2,:)) / max(max(Y_SOM(2,:)));

Y_SOM(1,:) = Y_SOM(1,:) *Amplitude1_SOM;
Y_SOM(2,:) = Y_SOM(2,:) *Amplitude2_SOM;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute Independent Component Analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Y_ICA,W_ICA]  = ICA(X,W, n, train, eta);

%Compute the amplitude
Amplitude1_ICA = max(S(1,:)) / max(max(Y_ICA(1,:))); 
Amplitude2_ICA = max(S(2,:)) / max(max(Y_ICA(2,:)));

Y_ICA(1,:) = Y_ICA(1,:) *Amplitude1_ICA;
Y_ICA(2,:) = Y_ICA(2,:) *Amplitude2_ICA;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Plots the results
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i =1:n;
subplot(2,1,1)
plot(i,Y_ICA(1,:),'.-',i,Y_SOM(1,:),'*-',i,S(1,:),'--')
hleg1 = legend('Y_I_C_A_1','Y_S_O_M_1','S_1');
%title('S1 and Y_SOM1')
drawnow

%Plot of S2
subplot(2,1,2)
plot(i,Y_ICA(2,:),'*-',i,Y_SOM(2,:),'.-',i,S(2,:),'--')
hleg1 = legend('Y_I_C_A_2','Y_S_O_M_2','S_2');
%title('S2 and Y_SOM2');
drawnow




