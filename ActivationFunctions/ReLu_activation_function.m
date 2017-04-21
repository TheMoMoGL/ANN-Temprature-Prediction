function [x] = ReLu_activation_function(x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detection and replacement of outliers
%
% Inputs: x -> Parameter value
%
% Outputs: x -> Parameter value, modified
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x(x > 0) = x;
x(x < 0) = 0.01*x;

end