function [sortedParam] = Pre_process(Param)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detection and replacement of outliers
%
% Inputs: Param -> Parameter vector
%
% Outputs: sortedParam -> Parameter vector with outliers replaced
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Param = [1 2 6 10 9 3 100 101];

sortedParam = sort(Param);

constant = 1.4826;

MADValue = constant*median(abs(sortedParam - median(sortedParam)));

% Find elements outside of two standard deviations
id = 2 < (abs(sortedParam - median(sortedParam)) / MADValue);

% Replace outliers with NaN
sortedParam(id) = NaN;

%&& Interpolation (Average between previous and next values) for removed data %%%
notNANvalues = sortedParam(~isnan(sortedParam) == 1);
NANindex = find(isnan(sortedParam));

% Check average derivative
averageDerivative = diff(notNANvalues);
nrDer = length(averageDerivative);
gradient = sum(averageDerivative)/nrDer;

% Replace NaN values with values fitting to curve
lastNonNaN = notNANvalues(end);
t = 1:1:length(NANindex);
sortedParam(NANindex) = lastNonNaN + gradient*t;

end

