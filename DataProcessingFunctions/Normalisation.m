%%% Normalisation of data %%%


function [normalT, maxVal, minVal] = Normalisation(Parameter)

[rowS, colS] = size(Parameter);
normalT = zeros(rowS, colS);

% Maximum and minimum value for each column of matrix
maxVal = max(Parameter);
minVal = min(Parameter);

% Normalisation of matrix
c = 1:colS;
r = 1:rowS;
normalT(r,c) = (Parameter(r,c) - minVal(c))./(maxVal(c) - minVal(c));

end