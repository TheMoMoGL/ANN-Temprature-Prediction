%%% Normalisation of data %%%


function [normalT] = Normalisation(T)

[rowS, colS] = size(T);
normalT = zeros(rowS, colS);

% Maximum and minimum value for each column of matrix
maxVal = max(T);
minVal = min(T);

% Normalisation of matrix
c = 1:colS;
r = 1:rowS;
normalT(r,c) = (T(r,c) - minVal(c))./(maxVal(c) - minVal(c));

end