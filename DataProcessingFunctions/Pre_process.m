function [newParam] = Pre_process(Param)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detection and replacement of outliers
%
% Inputs: Param -> Parameter vector
%
% Outputs: newParam -> Parameter vector with outliers replaced
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Step vector 
stepVector = 1:numel(Param);

% Consistency constant
%constant = 1.4826;

% Median absolute deviation
MADValue = median(abs(Param - median(Param)));

% Find elements outside of two standard deviations
id = 2 < (abs(Param - median(Param)) / MADValue);

% Replace outliers with NaN
Param(id) = NaN;

% Interpolation of NaN entries
% [newParam, ~] = fillmissing(Param,'linear','SamplePoints',stepVector);
% [newParam, ~] = fillmissing(Param,'linear','EndValues','nearest');
[newParam, ~] = fillmissing(Param,'spline','SamplePoints',stepVector);

end

