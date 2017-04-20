function [good, bad] = ValidationANN( validationData, inputWeights, hiddenWeights ) 
validationData = Normalisation(validationData);
for i=1:4:length(validationData)-96
    for j=i:4:i+92
        [input tmpTarget(j)] = HourlyInputTarget( validationData,j+4, i );
        [ a, b, output(i,j)] = calcOutput( input, inputWeights, hiddenWeights ); 
    end
    target(i) = tmpTarget(24);
end
%Error( output(:,1), target )
good = 0;
bad = 0;
for i=1:length(target)
    if abs(output(i, 24) - target(i)) < 0.2209
        good = good+1;
    else
        bad = bad+1;
        
    end
end
end