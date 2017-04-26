function [ Updated_weight ] = Weight_Updator( n ,inputs ,Delta_Error ,Weight )

Delta_Weight= inputs* Delta_Error* n; % Calculate the Delta weight

Updated_weight = Weight + Delta_Weight; % adding to corresponding weight%


end

