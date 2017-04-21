function [ summation ] = Net( x, y )

% summation = 0;
% 
% for i = 1:length(x)
%     summation = summation + (x(i) * y(i));
% end

prod = y.*x;
summation = sum(prod);

end