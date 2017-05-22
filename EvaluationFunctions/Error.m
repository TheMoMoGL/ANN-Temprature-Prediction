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

%MAPE = sum(abs((output - target)./ output)) * (1/n); % times 100 to get result in percent
MAPE = ((100/n) * sum(abs(target-output)./abs(target)));
Corr = corrcoef(target, output);
Corr = Corr(1,2); % 2x2 matrix with ones in the diagonal corr. coef. value in (1,2) & (2,1)

end