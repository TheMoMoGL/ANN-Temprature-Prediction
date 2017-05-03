function [train, test] = k_fold(Observations, K_factor, iterate)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K-fold cross validation
%
% Inputs: 
%
% Outputs:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%nrObservations = length(Observations);

%for iterate = 1:K_factor
    test = Observations(iterate:iterate + K_factor - 1);
    train = setdiff(Observations, test);

end