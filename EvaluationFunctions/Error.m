function [RMSE, MAPE, Corr] = Error( output, target )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: output -> Output data, have to match target size
%         target -> Target data, have to match target size
% Outputs: RMSE -> Root mean square error
%          MAPE -> Mean average percentage error
%          Corr -> Correlation coefficent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = numel(target);

RMSE = sqrt(mean((target(:) - output(:)).^2)); % Actual root mean square error function
MAPE = abs(sum(target - output)./ target) * (1/n);
Corr = corrcoef(target, output);

end