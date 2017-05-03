 function [ Updated_Weights_Input_Hidden,Updated_Weights_Hidden_Output ] = BackP(Output_of_the_System,Target,Weights_Hidden_Output,Weigthts_Hidden_inputs,Hidden_Nodes,Input_Nodes,Learning_Rate)





%%%%%%%%%%%%%Calculation of the Delta Error for Output
Delta_Error_Output=(Target-Output_of_the_System);

Weigthts_Hidden_inputs=Weigthts_Hidden_inputs';
%%%%%%%%%%%%%%%Weights updating for Weights between hidden and output
i=1:length(Weights_Hidden_Output);
[Updated_Weights_Hidden_Output(i)]=Weight_Updator(Learning_Rate,Delta_Error_Output,Hidden_Nodes(i),Weights_Hidden_Output(i));

%%%%%%%%%%%%%%% Calculation of the Delta Error for Hidden nodes

i=1:length(Hidden_Nodes)-1;
 if (Hidden_Nodes(i+1) > 0)
        Hidden_Nodes(i+1)=1;
    else 
        Hidden_Nodes(i+1) = 0.01;
 end

Delta_Error_Hidden_Nodes(i)=Hidden_Nodes(i+1)*Updated_Weights_Hidden_Output(i+1)'*Delta_Error_Output;
%%%%Wieghts updating between Hidden and Input layer
for j=1:length(Hidden_Nodes)-1
 for i=1:length(Input_Nodes)
    
    [Updated_Weights_Input_Hidden(i,j)]=Weight_Updator(Learning_Rate,Input_Nodes(i),Delta_Error_Hidden_Nodes(j),Weigthts_Hidden_inputs(i,j));
 end 
end 
Updated_Weights_Input_Hidden=Updated_Weights_Input_Hidden';%Tranponat
