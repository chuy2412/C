%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Based on:
%http://www.mathworks.com/matlabcentral/fileexchange/
%6267-neural-networks-a-comprehensive-foundation-2e-book-companion-software/
%content/haykin/ica.m
%And Suplemental notes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs:
%   X       - The observable vector of mixed signals (X = A*S)
%   W       - Weights initialized with random values
%   n       - number of samples
%   train   - number of training iterations
%   eta     - learning rate
%Outputs:
%   y       - Y matrix   (Y = W*X)
%   W       - Weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y,W]  = ICA(X,W, n, train, eta)

error=1e-2;
for i=1:train
    %Demixing X with W
    y=W*X;

    %Activation function
    f=(3/4)*y.^11+(25/4)*y.^9+(-14/3)*y.^7+(-47/4)*y.^5+(29/4)*y.^3;
    I = eye(2);
    dW=(I-f*y')*W;

    %Update the weight
    W=W+ eta*dW;

    % Break if Algorithm diverges
    if (sum(sum(isnan(W)))>0) flag=1; 
        break;
    end
    max(max(abs(dW)));

    % Break if Algorithm converges-- max weight update is less than error
    if (max(max(abs(dW)))<error & i>10) break; end;
end
