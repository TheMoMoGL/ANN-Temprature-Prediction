function [Parameter] = Reverse_normalisation(normParameter, maxVal, minVal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: normParameter -> Data to be reverse normalised
%         maxVal -> Vector containing maximum values
%         minVal -> Vector containing minimum values
%         
%
% Outputs: Parameter -> Reverse normalised data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Allocation of new matrix
[rowS, colS] = size(normParameter);
Parameter = zeros(rowS, colS);

% Reverse normalisation of vector
c = 1:colS;
r = 1:rowS;
Parameter(r,c) = minVal(c) + normParameter(r, c).*(maxVal(c) - minVal(c));

end