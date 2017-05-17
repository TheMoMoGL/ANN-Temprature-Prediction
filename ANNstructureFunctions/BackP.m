function [Updated_Weights_Input_Hidden,Updated_Weights_Hidden_Output,Hidden_weights] = BackP(Output_of_the_System,Target,Weights_Hidden_Output,Weigthts_Hidden_inputs,Hidden_Nodes,Input_Nodes,Learning_Rate,Hidden_weights,numberOfhidden)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: Output_of_the_System -> output of the system
%         Target -> the desired target
%         Weights_Hidden_Output -> Weights between last hidden layer and output
%         Weigthts_Hidden_inputs -> Weights between first hidden layer and input layer
%         Hidden_Nodes -> the matrix that contents all nodes of hidden layers
%         Input_Nodes -> input parameters
%         Learning_Rate -> Learning Rate
%         Hidden_weights -> The matrix that contents all wieghts for every hidden layer
%         numberOfhidden -> an integer that tells how many hidden layer to calculate
% Outputs: Updated_Weights_Input_Hidden -> Updated wieghts between first hidden layer and inputs
%          Updated_Weights_Hidden_Output -> Updated wieghts betwwen last hidden and the oupt layer
%          Hidden_weights -> updated wieghts i hidden layers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[m,n] = size(Hidden_Nodes);
%%%%Calculating output error
Delta_Error_Output = (Target-Output_of_the_System); % Linear
%Delta_Error_Output = (4*exp(2*Output_of_the_System))/((exp(2*Output_of_the_System) + 1)^2)*(Target-Output_of_the_System); % Tanh
% Delta_Error_Output = Output_of_the_System*(1 - Output_of_the_System)*(Target-Output_of_the_System); % Sigmoid
%%%%%%%%%%%%%%%Weights updating for Weights between hidden and output
for i = 1:length(Weights_Hidden_Output)
    [Updated_Weights_Hidden_Output(i)] = Weight_Updator(Learning_Rate,Delta_Error_Output,Hidden_Nodes(m,i),Weights_Hidden_Output(i));
end

%%%%%%%%%%%%%%% Calculation of the Delta Error for last Hidden layer

for i = 2:n
    %%% delta erro for RElU
    %     if (Hidden_Nodes(m,i) > 0)
    %         Hidden_Nodes(m,i)=1;
    %     else
    %         Hidden_Nodes(m,i) = 0.01;
    %     end
    %     Delta_Error_LastHidden_Nodes(i-1)=Hidden_Nodes(m,i)*Updated_Weights_Hidden_Output(i)*Delta_Error_Output;
    %%% delta erro for Tanh
    % Delta_Error_LastHidden_Nodes(i-1) = (4*exp(2*Hidden_Nodes(m,i)))/((exp(2*Hidden_Nodes(m,i)) + 1)^2)*Updated_Weights_Hidden_Output(i)*Delta_Error_Output;
    %%% delta error for linear
    % Delta_Error_LastHidden_Nodes(i-1) = Updated_Weights_Hidden_Output(i)*Delta_Error_Output;
    %%% Delta error for sigmoid
     Delta_Error_LastHidden_Nodes(i-1) = Hidden_Nodes(m,i)*(1 - Hidden_Nodes(m,i))*Updated_Weights_Hidden_Output(i)*Delta_Error_Output;
    
end
%%%% Delta Error calculating for all hidden layer and weights updating
if numberOfhidden > 1 %% if we have more than 1 hidden layer
    [r,w] = size(Hidden_weights);
    cnt = r-length(Delta_Error_LastHidden_Nodes)+1;
    %%% calculating the weights between the last and output later
    
    for j = 1:length(Delta_Error_LastHidden_Nodes)
        for u = 1:w
            [Hidden_weights(cnt,u)] = Weight_Updator(Learning_Rate,Hidden_Nodes(m-1,u), Delta_Error_LastHidden_Nodes(j),Hidden_weights(cnt,u));
        end
        cnt = cnt+1;
    end
    
    
    %%%%%% calculating the delta erro of each hidden layer and weight
    
    for d = m - 1:-1:1 % begin from next last hiden layer
        for k = 2:1:n
            cnt = length(Delta_Error_LastHidden_Nodes)-1;
            sum_delta = 0;
            for i = 1:length(Delta_Error_LastHidden_Nodes)
                
                sum_delta = sum_delta+(Delta_Error_LastHidden_Nodes(i)*Hidden_weights(r-cnt,k)); % calculating the sum delta of the previous hidden layer
                cnt = cnt-1;
                
            end
            
            %%% delta error for RELU
            %         if (Hidden_Nodes(d,k) > 0)
            %             Hidden_Nodes(d,k)=1;
            %         else
            %             Hidden_Nodes(d,k) = 0.01;
            %         end
            %
            %            Delta_Error_LastHidden_Nodes(k-1)= Hidden_Nodes(d,k)*sum_delta;
            %%% delta error for Tanh
            %          Delta_Error_LastHidden_Nodes(k-1) = (4*exp(2*Hidden_Nodes(d,k)))/((exp(2*Hidden_Nodes(d,k)) + 1)^2)*sum_delta;
            %%% delta error for Linear
            %          Delta_Error_LastHidden_Nodes(k-1) = sum_delta;
            %%% Delta error for sigmoid
                      Delta_Error_LastHidden_Nodes(k-1) = Hidden_Nodes(d,k)*(1 - Hidden_Nodes(d,k))*sum_delta;
            
        end
        
        r = r-length(Delta_Error_LastHidden_Nodes);
        if d ~= 1 %% if not the first hidden layer  then update the weight between the hidden layers
            cnt = length(Delta_Error_LastHidden_Nodes)-1;
            for j = 1:length(Delta_Error_LastHidden_Nodes)
                for u = 1:n
                    [Hidden_weights(r-cnt,u)] = Weight_Updator(Learning_Rate,Hidden_Nodes(d-1,u),Delta_Error_LastHidden_Nodes(j),Hidden_weights(r-cnt,u));
                end
                cnt = cnt-1;
            end
        else %%% otherwise update the wieghts between input and first hidden layer
            [~,n] = size(Weigthts_Hidden_inputs);
            for k = 1:length(Delta_Error_LastHidden_Nodes)
                for i = 1:n
                    [Updated_Weights_Input_Hidden(k,i)] = Weight_Updator(Learning_Rate,Input_Nodes(i),Delta_Error_LastHidden_Nodes(k),Weigthts_Hidden_inputs(k,i));
                end
            end
            
        end
    end
else %% if we dont have more than one hidden layer then update the weights between the last hidden layer and input layer
    
    [~,n] = size(Weigthts_Hidden_inputs);
    for k = 1:length(Delta_Error_LastHidden_Nodes)
        
        for i = 1:n
            
            [Updated_Weights_Input_Hidden(k,i)] = Weight_Updator(Learning_Rate,Input_Nodes(i),Delta_Error_LastHidden_Nodes(k),Weigthts_Hidden_inputs(k,i));
        end
        
    end
end