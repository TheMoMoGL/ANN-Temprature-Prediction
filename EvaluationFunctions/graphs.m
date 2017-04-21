function [] = graphs(outputVal, actualVal, dateAndTime)

error = outputVal - actualVal;

dt = datetime(dateAndTime,'inputFormat','uuuu-MM-dd HH:mm','TimeZone','local');

figure('units','normalized','outerposition',[0 0 1 1])
plot(dt,outputVal)
hold on
plot (dt, actualVal)
legend('Temperature prognosis', 'Measured temperature')

figure('units','normalized','outerposition',[0 0 1 1])
plot(dt, error)
legend('Error between forecasted temperature and measured temperature')

end