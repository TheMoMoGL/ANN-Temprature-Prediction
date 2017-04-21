function [Param] = Pre_process(Param)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detection and replacement of outliers
%
% Inputs: Param -> Parameter vector
%
% Outputs: Param -> Parameter vector with outliers replaced
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Param = [1 2 3 6 9 10 100 101];
stepVector = 1:numel(Param);

constant = 1.4826;

% Median average deviation
MADValue = constant*median(abs(Param - median(Param)));

% Find elements outside of two standard deviations
id = 2 < (abs(Param - median(Param)) / MADValue);

% Replace outliers with NaN
Param(id) = NaN;

[Param,TF] = fillmissing(Param,'linear','SamplePoints',stepVector);

%%% Interpolation (Average between previous and next values) for removed data %%%
% notNANvalues = Param(~isnan(Param));
% newStepVector = stepVector(~isnan(Param));
% NANindex = stepVector(isnan(Param));
% 
% % Check average derivative
% averageDerivative = diff(notNANvalues);
% nrDer = length(averageDerivative);
% gradient = sum(averageDerivative)/nrDer;
% 
% % Replace NaN values with values fitting to curve
% %if(any(Param == ))
% lastNonNaN = notNANvalues(end);
% t = 1:1:length(NANindex);
% Param(NANindex) = lastNonNaN + gradient*t;

end

