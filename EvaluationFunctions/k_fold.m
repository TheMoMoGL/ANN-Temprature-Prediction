function [train, validate] = k_fold(Observations, K_factor, iterate, partitions)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K-fold cross validation
%
% Inputs: Observations -> Total set of weather data
%         K_factor -> K-factor that decides how many time data will be split
%         iterate -> Decides which set is to be selected as test set
%         partitions -> Size of one data partition
%
% Outputs: train -> Training data set
%          validate -> Evaluation data set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrObservations = length(Observations); % Total amount of observations
lastIterate = partitions*(K_factor-1) + 1; % Last index to start iterating from

% Validation set is first in data set
if iterate == 1
    validate = Observations(iterate:partitions);
    train = Observations(iterate + partitions:end);
    
    % Validation set is last in data set
elseif iterate == lastIterate
    validate = Observations(lastIterate:nrObservations);
    train = Observations(1:lastIterate - 1);
    
    % Validation set is in the middle of the data set
else
    validate = Observations(iterate:iterate + partitions - 1);
    train = Observations(1:iterate - 1);
    train = vertcat(train, Observations(iterate + partitions:end));
    
end

end