function [RMSE, MAPE, Corr] = Error( output, target )


    RMSE = sqrt( sum( ( target(:) - output(:) ).^2 ) ./ numel(output) );
    %RMSE = sqrt(mean((target(:) - output(:)).^2));
    MAPE = abs(sum(( target - output ) ./ target) * (100 ./ numel(output)));
    Corr = corrcoef( target, output );
    MAPE = MAPE(1,1);
    Corr = Corr(1,2);
%     sprintf('RMSE -> %.4f\nMAPE -> %.4f\nCC -> %.4f\n', RMSE, MAPE, Corr(1,2))
    
end