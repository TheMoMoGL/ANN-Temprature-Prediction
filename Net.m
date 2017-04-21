function [ summation1 ] = Net( x, y )

summation1 = 0;

for i = 1:length(x)
    summation1 = summation1 + (x(i) * y(i));
end

% prod = x.*y;
% summation2 = sum(prod);

end