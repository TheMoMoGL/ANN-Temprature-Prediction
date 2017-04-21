function [ Updated_weight ] = Weight_Updator( n ,inputs ,Delta_Error ,Weight )

Delta_Weight= inputs* Delta_Error* n;

Updated_weight = Weight + Delta_Weight;


end

