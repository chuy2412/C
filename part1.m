%C part 1
clear

n= 800;

A = ([1 -1; 1 2]);

%Variance for the sources
Svar1 =1;
Svar2 =4;

%Variance for X signals
Xvar1 = sqrt(17);
Xvar2 = sqrt(65);

%Generate the sources
S1 = normrnd(0,Svar1,n,1);
S2 = normrnd(0,Svar2,n,1);

%Generate the X signals
X1 = normrnd(0,Xvar1,n,1);
X2 = normrnd(0,Xvar2,n,1);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Histogram of S1
subplot(3,1,1)
hist(S1)
axis([-15 15 0 250])    %[xmin xmax ymin ymax]
title('Histogram of S1')
drawnow

%Plot Histogram of S2
subplot(3,1,2)
hist(S2)
axis([-15 15 0 250])    %[xmin xmax ymin ymax]
title('Histogram of S2');
drawnow

%Plot X1,X2
subplot(3,1,3)
plot(X1,X2,'x');
title('Two-dimensional distribution of the signals X1 and X2');
drawnow




