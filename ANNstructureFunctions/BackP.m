 function [Updated_Weights_Input_Hidden,Updated_Weights_Hidden_Output,Hidden_weights] = BackP(Output_of_the_System,Target,Weights_Hidden_Output,Weigthts_Hidden_inputs,Hidden_Nodes,Input_Nodes,Learning_Rate,Hidden_weights,numberOfhidden)

[m,n] = size(Hidden_Nodes);                                                                         
%%%%Calculating output error 
Delta_Error_Output = (Target-Output_of_the_System);
%%%%%%%%%%%%%%%Weights updating for Weights between hidden and output
for i = 1:length(Weights_Hidden_Output)
[Updated_Weights_Hidden_Output(i)] = Weight_Updator(Learning_Rate,Delta_Error_Output,Hidden_Nodes(m,i),Weights_Hidden_Output(i));
end 

%%%%%%%%%%%%%%% Calculation of the Delta Error for last Hidden layer

for i = 2:n

%     if (Hidden_Nodes(m,i) > 0)
%         Hidden_Nodes(m,i)=1;
%     else
%         Hidden_Nodes(m,i) = 0.01;
%     end
%     Delta_Error_LastHidden_Nodes(i-1)=Hidden_Nodes(m,i)*Updated_Weights_Hidden_Output(i)*Delta_Error_Output;
      Delta_Error_LastHidden_Nodes(i-1) = (4*exp(2*Hidden_Nodes(m,i)))/((exp(2*Hidden_Nodes(m,i)) + 1)^2)*Updated_Weights_Hidden_Output(i)*Delta_Error_Output;

end
%%%% Error calculating for all hidden layer and weights updating
if numberOfhidden > 1 %% if we have more than 1 hidden layer 
    [r,w] = size(Hidden_weights);
    cnt = r-length(Delta_Error_LastHidden_Nodes)+1;
    %%% calculating the weights between the last and previous hidden layer
                                                                                                                  
    for j = 1:length(Delta_Error_LastHidden_Nodes)
      for u = 1:w
        
          
            [Hidden_weights(cnt,u)] = Weight_Updator(Learning_Rate,Hidden_Nodes(m-1,u), Delta_Error_LastHidden_Nodes(j),Hidden_weights(cnt,u));
            
      end
      cnt = cnt+1;
    end

    
    %%%%%% calculating the delta erro of each hidden layer and weight
   
    for d = m - 1:-1:1 % begin from the next last hiden layer 
        for k = 2:1:n
            cnt = length(Delta_Error_LastHidden_Nodes)-1;
            sum_delta = 0;
           for i = 1:length(Delta_Error_LastHidden_Nodes)
              
             sum_delta = sum_delta+(Delta_Error_LastHidden_Nodes(i)*Hidden_weights(r-cnt,k));
             cnt = cnt-1;
            
           end

%         if (Hidden_Nodes(d,k) > 0)
%             Hidden_Nodes(d,k)=1;
%         else
%             Hidden_Nodes(d,k) = 0.01;
%         end
%            Delta_Error_LastHidden_Nodes(k-1)= Hidden_Nodes(d,k)*sum_delta;  
          Delta_Error_LastHidden_Nodes(i-1) = (4*exp(2*Hidden_Nodes(d,k)))/((exp(2*Hidden_Nodes(d,k)) + 1)^2)*sum_delta;

        end
        
        r = r-length(Delta_Error_LastHidden_Nodes);
        Hidden_weights1 = Hidden_weights;
        if d ~= 1 %% if not the first hidden layer  then update the weight by this way
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
 
else %% if we dont have more than one hidden layer then update the weights between the last hidden layer and input 
    
    [~,n] = size(Weigthts_Hidden_inputs);
    for k = 1:length(Delta_Error_LastHidden_Nodes)
       
            for i = 1:n
                
                [Updated_Weights_Input_Hidden(k,i)] = Weight_Updator(Learning_Rate,Input_Nodes(i),Delta_Error_LastHidden_Nodes(k),Weigthts_Hidden_inputs(k,i));
            end
        
    end
end