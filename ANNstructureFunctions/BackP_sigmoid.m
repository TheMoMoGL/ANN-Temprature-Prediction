function [ Updated_Weights_Input_Hidden,Updated_Weights_Hidden_Output ] = BackP_sigmoid(Output_of_the_System,Target,Weights_Hidden_Output,Weigthts_Hidden_inputs,Hidden_Nodes,Input_Nodes,Learning_Rate)

%%%%%%%%%%%%% Calculation of the Delta Error for Output
Delta_Error_Output = Output_of_the_System*(1-Output_of_the_System)*(Target-Output_of_the_System);

Weigthts_Hidden_inputs = Weigthts_Hidden_inputs';

%%%%%%%%%%%%%%% Weights updating for Weights between hidden and output
for i = 1:length(Weights_Hidden_Output)
    Delta_Weights_Ouput(i) = Learning_Rate*Delta_Error_Output*Hidden_Nodes(i);
end
Updated_Weights_Hidden_Output = Weights_Hidden_Output + Delta_Weights_Ouput;

%%%%%%%%%%%%%%% Calculation of the Delta Error for Hidden nodes

for i = 2:length(Hidden_Nodes)
    Delta_Error_Hidden_Nodes(i-1) = Hidden_Nodes(i)*(1 - Hidden_Nodes(i))*Updated_Weights_Hidden_Output(i)*Delta_Error_Output;
end

%%%% Wieghts updating between Hidden and Input layer
for j = 1:length(Hidden_Nodes)-1
    for i = 1:length(Input_Nodes)
        Delta_Weights_Input(i,j) = Learning_Rate*Delta_Error_Hidden_Nodes(j)*Input_Nodes(i);
    end
end

Updated_Weights_Input_Hidden = Weigthts_Hidden_inputs + Delta_Weights_Input;
Updated_Weights_Input_Hidden = Updated_Weights_Input_Hidden'; %Transpose
