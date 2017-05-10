function [normalisedData, maxValues, minValues] = MaxAndMin(data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: data -> Data to be normalised
%         
%
% Outputs: normalisedData -> Normalised data
%          maxValues -> Vector containing maximum values
%          minValues -> Vector containing minimum values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maxValues = max(data);
minValues = min(data);

normalisedData = Normalisation(data, maxValues, minValues);

end