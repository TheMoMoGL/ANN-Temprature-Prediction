function [value] = ReLu_activation_function(value)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Leaky Rectified Linear Unit (Leaky ReLu) activation function
%
% Inputs: value -> Value to be transformed
%
% Outputs: value -> Transformed value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

value = max(0.1*value, value);

end