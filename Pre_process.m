%%% Detection and removal of outliers %%%


function [output] = Pre_process()

Param = [1 2 6 10 9 3 100 101];

sortedParam = sort(Param);

constant = 1.4826;

MADValue = constant*median(abs(sortedParam - median(sortedParam)));

% Find elements outside of two standard deviations
id = 2 < (abs(sortedParam - median(sortedParam)) / MADValue);
%id = 2 < (abs(sortedParam - median(sortedParam)) / mad(sortedParam));
ind1 = find(id == 1); % Index of outliers

% Remove outliers
sortedParam(ind1) = NaN;

[ind2] = find(~isnan(sortedParam));

% Interpolation (Average between previous and next values) for removed data
notNAN = sortedParam(~isnan(sortedParam) == 1);

sample = randsample(notNAN, 2);


end

