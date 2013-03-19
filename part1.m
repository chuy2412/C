%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Assignment C part 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

eta = 0.01;
error=1e-2;
iter=100;   %70;
n= 750;      %50;  %number of elements

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
pause(2);
I = double(zeros(n));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Training Phase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
 I = eye(2);
 dW=(I-f*y')*W;

 %Update the weight
 W=W+ eta*dW;

% Break if Algorithm diverges
 if (sum(sum(isnan(W)))>0) flag=1; break; end
   max(max(abs(dW)));

% Break if Algorithm converges-- max weight update is less than error
 if (max(max(abs(dW)))<error & i>10) break; end;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot of S1
subplot(2,2,1)
plot(S(1,:))
title('S1')
drawnow

%Plot of S2
subplot(2,2,2)
plot(S(2,:))
title('S2');
drawnow

%Plot of Y1
subplot(2,2,3)
plot(y(1,:))
title('Y1');
drawnow

%Plot of Y2
subplot(2,2,4)
plot(y(2,:))
title('Y2');
drawnow




