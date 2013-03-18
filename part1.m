%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Assignment C part 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

n= 800;  %number of elements

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




