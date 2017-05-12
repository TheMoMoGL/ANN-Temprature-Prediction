function [RMSE, MAPE, Corr] = Error( output, target )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: output -> Output data, have to match target size
%         target -> Target data, have to match target size
% Outputs: RMSE -> Root mean square error
%          MAPE -> Mean average percentage error
%          Corr -> Correlation coefficent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RMSE = sqrt( sum( ( target(:) - output(:) ).^2 ) ./ numel(output) ); % Normalized sum of squared errors
%RMSE = sqrt(mean((target(:) - output(:)).^2)); % Actual root mean square error function
MAPE = abs(sum(( target - output ) ./ target) * (100 ./ numel(output)));
Corr = corrcoef( target, output );
MAPE = MAPE(1,1);
Corr = Corr(1,2);
end