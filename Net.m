function [ sum ] = Net( x, y )
sum = 0;
for i=1:length(x)
    sum = sum + (x(i) * y(i));
end
end

