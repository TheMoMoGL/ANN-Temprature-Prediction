function [transformValue] = tanh_activation(value)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tanh activation function
%
% Inputs: value -> Value to be transformed
%
% Outputs: transformValue -> Transformed value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%transformValue = tanh(value);

transformValue = (exp(value) - exp(-value))/(exp(value) + exp(-value));

end

