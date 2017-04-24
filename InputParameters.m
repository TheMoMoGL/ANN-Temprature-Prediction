function [ newRT ] = InputParameters( RT, days, hours, start )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In: RT -> Real Temperature vector
%     days -> Nr. days before at same hour
%     hours -> Nr. hours before the given time
%     index -> What index in the RT vector you is at at the moment
% Out: newRT -> A matrix with the all the new values
%      start -> Starting index for training/validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if days == 0 && hours == 0
    newRT = RT(start);
else
    parameter = 1;
    if days~=0
        for i = start+1: -96 : start-(days*96)
            newRT(parameter) = RT(i);
            parameter = parameter +1;
        end
    else
        newRT(parameter) = RT(start);
        parameter = parameter +1;
    end
    if hours ~= 0
        for i = start-3: -4 : start-(hours*4)
            newRT(parameter) = RT(i);
            parameter = parameter +1;
        end
    end
end
end

