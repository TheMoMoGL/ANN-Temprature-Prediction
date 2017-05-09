function [train, test] = k_fold(Observations, K_factor, iterate, partitions)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K-fold cross validation
%
% Inputs:
%
% Outputs:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrObservations = length(Observations);
% partitions = round(nrObservations/K_factor);
lastIterate = partitions*(K_factor-1) + 1;

if iterate == 1
    test = Observations(iterate:partitions);
    train = Observations(iterate + partitions:end);
    
elseif iterate == lastIterate
    test = Observations(lastIterate:nrObservations);
    train = Observations(1:lastIterate - 1);
    
else
    test = Observations(iterate:iterate + partitions - 1);
    train = Observations(1:iterate - 1);
    train = vertcat(train, Observations(iterate + partitions:end));
    
end

end