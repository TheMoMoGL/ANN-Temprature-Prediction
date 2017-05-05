function [] = graphs(outputVal, actualVal, dateAndTime, iteration, progTemp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting function
%
% Inputs: outputVal -> Output values of network
%         actualVal -> Actual target values
%         dateAndTime -> Dates and times for forecasts and measured temperatures
%
% Outputs: None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% dateAndTimeHourly = dateAndTime(1 : 4 : end);
% start = length(dateAndTimeHourly) - length(outputVal) + 1;
% dateAndTimeHourly = dateAndTimeHourly(start:end);
progEnd = length(outputVal);

progtemp = progTemp(1:4:end);
progtemp = progtemp(1:progEnd);
error = outputVal - actualVal;
[m,~] = size(outputVal);
dt = 1:1:m;
% dt = datetime(dateAndTimeHourly,'inputFormat','uuuu-MM-dd HH:mm','TimeZone','local');
% realTemp = loadVariable(Ptemp_validation);

figure('units','normalized','outerposition',[0 0 1 1])
plot(dt, outputVal)
hold on
plot (dt, actualVal)
hold on
plot (dt, progtemp, 'g')
legend('Temperature prognosis', 'Measured temperature', 'SMHI prognosis')
title(['Hidden neurons: ', num2str(iteration)])


% figure('units','normalized','outerposition',[0 0 1 1])
% plot(dt, error)
% legend('Error between forecasted temperature and measured temperature')
% title(['Hidden neurons: ', num2str(iteration)])

end