function [] = graphs(outputVal, actualVal, iteration, progTemp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting function
%
% Inputs: outputVal -> Output values of network
%         actualVal -> Actual target values
%         dateAndTime -> Dates and times for forecasts and measured temperatures
%
% Outputs: None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Declaration of variables
global dt;
global progtemp
global time;
progEnd = length(outputVal);
progtemp = progTemp(1:(progEnd-(time-1)))';
error = outputVal - actualVal;
[m,~] = size(outputVal);
dt = 1:1:m-time+1;

% Plotting of neural network output, measured temperature, and SMHI prognosis
figure('units','normalized','outerposition',[0 0 1 1])
plot(dt, outputVal((1:end-time+1),time))
hold on
plot (dt, actualVal((1:end-time+1),time))
hold on
plot (dt, progtemp, 'g')
legend('Temperature prognosis', 'Measured temperature', 'SMHI prognosis')
title(['Hidden neurons: ', num2str(iteration)])

% Plotting of error between neural network output and measured temperature
figure('units','normalized','outerposition',[0 0 1 1])
plot(dt, error((1:end-time+1),time))
legend('Error between forecasted temperature and measured temperature')
title(['Hidden neurons: ', num2str(iteration)])

end