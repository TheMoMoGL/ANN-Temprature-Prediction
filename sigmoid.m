%%% Sigmoid activation function %%%
%%% Takes input and outputs value between 0 and 1 %%%


function [sigma] = sigmoid(x)

sigma = 1./(1+exp(-x));

disp('test')

end