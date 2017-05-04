function [train, test] = k_fold(Observations, K_factor, iterate)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K-fold cross validation
%
% Inputs: 
%
% Outputs:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrObservations = length(Observations);
partitions = round(nrObservations/K_factor);


if iterate == 1
    test = Observations(iterate:partitions);
    train = Observations(iterate + partitions:end);
    
% else if 
else
    test = Observations(iterate:iterate + partitions - 1);
    train = Observations(1:iterate - 1);
    train = vertcat(train, Observations(iterate + partitions:end));


end