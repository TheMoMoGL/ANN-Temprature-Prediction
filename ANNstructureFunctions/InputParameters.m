function [ newRT ] = InputParameters( RT, days, hours, start )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In: RT -> Real Temperature vector
%     days -> Nr. days before at same hour
%     hours -> Nr. hours before the given time
%     index -> What index in the RT vector you is at at the moment
% Out: newRT -> A matrix with the all the new values
%      start -> Starting index for training/validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If no extra inputs are desired the RT is set as the  newRT
if days == 0 && hours == 0
    newRT = RT(start);
else
    parameter = 1;
    if days~=0
        % Adds extra parameters for the same hour the days before starting
        % from the first day
        for i = start+1: -96 : start-(days*96)
            newRT(parameter) = RT(i);
            parameter = parameter +1;
        end
    else
        newRT(parameter) = RT(start);
        parameter = parameter +1;
    end
    if hours ~= 0
        % Adds extra parameters for the same hour the days before starting
        % from the hour before the actual hour to avoid duplicate
        for i = start-3: -4 : start-(hours*4)
            newRT(parameter) = RT(i);
            parameter = parameter +1;
        end
    end
end
end

