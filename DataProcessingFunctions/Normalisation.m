function [normalT] = Normalisation(Parameter, maxVal, minVal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: Parameter -> Data to be normalised
%         maxVal -> Vector containing maximum values
%         minVal -> Vector containing minimum values
%         
%
% Outputs: normalT -> Normalised data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defines the scaling interval
IntervalMin = -1;
IntervalMax = 1;

% Allocation of new vector
[rowS, colS] = size(Parameter);
normalT = zeros(rowS, colS);

% Normalisation of matrix
% c = 1:1:colS;
% r = 1:1:rowS;
% normalT(r,c) = IntervalMin + (IntervalMax-IntervalMin)*(Parameter(r,c)-minVal(c))/(maxVal(c)-minVal(c));

for r = 1:rowS
    for c = 1:colS
        normalT(r,c) = IntervalMin + (IntervalMax-IntervalMin)*(Parameter(r,c)-minVal(c))/(maxVal(c)-minVal(c));
    end
end

end