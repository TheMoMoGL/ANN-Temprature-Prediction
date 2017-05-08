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
lastIterate = partitions*(K_factor-1);


if iterate == 1
    test = Observations(iterate:partitions);
    train = Observations(iterate + partitions:end);
    
elseif iterate == lastIterate
    test = Observations(lastIterate+1:nrObservations);
    train = Observations(1:lastIterate);
    
else
    test = Observations(iterate+1:iterate + partitions);
    train = Observations(1:iterate);
    train = vertcat(train, Observations(iterate + partitions + 1:end));
    
end

end