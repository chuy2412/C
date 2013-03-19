%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Self-Organizing Map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Source:
%http://home.wlu.edu/~levys/software/som/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [A,W]  = som(X, n, tmax, eta)
% SOM Kohonen's two-dimensional Self-Organizing Map
%     A  = SOM(X, N, TMAX) returns an N-by-N matrix A of output nodes 
%     learned as an unsupervised map from input vectors X, using Kohonen's 
%     Self-Oganizing Map algorithm.
%Inputs:
%     X    - input vector
%     n    - dimension of A is nxn
%     tmax - is the number of time steps to to run.   
%     eta  - learning rate
%
%Outputs:
%      A - Matrix containing indices of X.
%      W - Weights

% learning parameters
eta_F        = eta/5;          %eta: final

sigma_I     =  3.0e0;       % attraction between points : initial
sigma_F     =  1.0e-1;      %                           : final


% set up NxN grid
%[u(:,1), u(:,2)] = ind2sub([n n], 1:n^2);
[u(:,1), u(:,2)] = ind2sub([n n], 1:n);

% create random initial weights
%W = rand(n^2, size(X,2));
W = rand(n, size(X,2));

% run SOM learning for specified number of steps
for t = 1:tmax
    % randomly choose an input vector x
    if size(X, 1) > 1
        i = 1+fix(rand*size(X,1));
    else
        i = 1+fix(rand*length(X));
    end
    
    if size(X, 1) > 1
        x_pick = X(i,:);
    else
        x_pick = X(i);
    end

    % determine the winning output node i closest to x
    xs = repmat(x_pick, size(W, 1), 1);
     %Calculate the euclidian distance
    d = sqrt(sum(abs(xs-W).^2, 2));
    s = sum(d, 2);
    [ignore, winner] = min(s);
    %y = W(i,:);
    
    
    % scale learning paramters by elapsed time                        
    tfrac = t / tmax;
    
    %Scale values
    mu = eta + tfrac * (eta_F - eta);
    sigma = sigma_I + tfrac * (sigma_F - sigma_I);

    % udpate the weights, tracking mean weight change
    for k = 1:size(W, 1)
        aleph = exp(-sum((u(winner,:)-u(k,:)).^2) / (2*sigma^2));
        dw = mu * aleph * (x_pick - W(k,:));
        W(k,:) = W(k,:) + dw; 
    end
end

% return grid of input indices
A = zeros(n,n);
for i = 1:size(u,1)
    j = u(i,1);
    k = u(i,2);
    
    xs = repmat(W(i,:), size(X, 1), 1);
    d = sqrt(sum(abs(xs-X).^2, 2));
    s = sum(d, 2);
    A(j,k) = min(s);
end

