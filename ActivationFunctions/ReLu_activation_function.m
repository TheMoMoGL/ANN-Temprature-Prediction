function [value] = ReLu_activation_function(value)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Leaky Rectified Linear Unit (Leaky ReLu) activation function
%
% Inputs: value -> Value to be transformed
%
% Outputs: value -> Transformed value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

value(value > 0) = value;
value(value < 0) = 0.01*value;

end