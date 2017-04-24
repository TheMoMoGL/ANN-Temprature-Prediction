function [] = graphs(outputVal, actualVal, dateAndTime)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting function
%
% Inputs: outputVal -> Output values of network
%         actualVal -> Actual target values
%         dateAndTime -> Dates and times for forecasts and measured temperatures
%
% Outputs: Noone
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dateAndTimeAlt = dateAndTime(1 : 4 : end);

error = outputVal - actualVal;

dt = datetime(dateAndTimeAlt,'inputFormat','uuuu-MM-dd HH:mm','TimeZone','local');

figure('units','normalized','outerposition',[0 0 1 1])
plot(dt,outputVal)
hold on
plot (dt, actualVal)
legend('Temperature prognosis', 'Measured temperature')

figure('units','normalized','outerposition',[0 0 1 1])
plot(dt, error)
legend('Error between forecasted temperature and measured temperature')

end