function [] = Error( output, target )


    RMSE = sqrt( sum( ( target(:) - output(:) ).^2 ) ./ numel(output) );
    MAPE = abs(sum(( target - output ) ./ target) * (100 ./ numel(output)));
    Corr = corrcoef( target, output );
    sprintf('RMSE -> %.4f\nMAPE -> %.4f\nCC -> %.4f\n', RMSE, MAPE, Corr(1,2))
    
end