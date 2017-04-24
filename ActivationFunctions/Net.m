function [summation] = Net(weights, inputs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net calculation of weights and inputs from previous layer
%
% Inputs: weights -> Weights between the layers
%         inputs -> Inputs from the previous layer
%
% Outputs: summation -> Product of every element in the vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prod = inputs.*weights;
summation = sum(prod);

end