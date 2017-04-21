function [Parameter] = Reverse_normalisation(normParameter, maxVal, minVal)

[rowS, colS] = size(normParameter);
Parameter = zeros(rowS, colS);

c = 1:colS;
r = 1:rowS;
Parameter(r,c) = minVal + normParameter(r, c).*(maxVal - minVal);

end