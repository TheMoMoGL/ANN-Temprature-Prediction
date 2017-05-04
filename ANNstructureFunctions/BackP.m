 function [ Updated_Weights_Input_Hidden,Updated_Weights_Hidden_Output,Hidden_weights ] = BackP(Output_of_the_System,Target,Weights_Hidden_Output,Weigthts_Hidden_inputs,Hidden_Nodes,Input_Nodes,Learning_Rate,Hidden_weights,numberOfhidden)

   [m,n]=size(Hidden_Nodes);                                                                         

%%%%Calculating output error
Delta_Error_Output=(Target-Output_of_the_System);
%%%%%%%%%%%%%%%Weights updating for Weights between hidden and output
for i=1:length(Weights_Hidden_Output)
[Updated_Weights_Hidden_Output(i)]=Weight_Updator(Learning_Rate,Delta_Error_Output,Hidden_Nodes(m,i),Weights_Hidden_Output(i));
end 
%%%%%%%%%%%%%%% Calculation of the Delta Error for last Hidden layer

for i=2:n
    if (Hidden_Nodes(m,i) > 0)
        Hidden_Nodes(m,i)=1;
    else
        Hidden_Nodes(m,i) = 0.01;
    end
    Delta_Error_LastHidden_Nodes(i-1)=Hidden_Nodes(m,i)*Updated_Weights_Hidden_Output(i)*Delta_Error_Output;
end
%%%%error calculating for all hidden layer and weights updating

if numberOfhidden > 1
    [r,w]=size(Hidden_weights);
    cnt=r-length(Delta_Error_LastHidden_Nodes)+1;
    for j=1:length(Delta_Error_LastHidden_Nodes)
      for u=1:n
        for i=1:w
           
            [Hidden_weights(cnt,i)]=Weight_Updator(Learning_Rate,Hidden_Nodes(m-1,u),Delta_Error_LastHidden_Nodes(j),Hidden_weights(cnt,i));
           
        end
      end
      cnt=cnt+1;
    end
    
    %%%%%%%%%%
    for d=m-1:-1:1
   
        for k=2:1:n
            sum_delta=0;
           for i=1:length(Delta_Error_LastHidden_Nodes) 
             sum_delta=sum_delta+(Delta_Error_LastHidden_Nodes(i)*Hidden_weights(i,k));    
           end 
           Delta_Error_LastHidden_Nodes(k-1)= Hidden_Nodes(d,k)*sum_delta; 
          
        end
        
        if d~= 1
            r=r-length(Delta_Error_LastHidden_Nodes);
            cnt=r-length(Delta_Error_LastHidden_Nodes)+1;
            for j=1:length(Delta_Error_LastHidden_Nodes)
                for u=1:n
                    for i=1:w
                        
                        [Hidden_weights(cnt,i)]=Weight_Updator(Learning_Rate,Hidden_Nodes(m-1,u),Delta_Error_LastHidden_Nodes(j),Hidden_weights(cnt,i));
                        
                    end
                end
                cnt=cnt+1;
            end
        else 
            [m,n] = size(Weigthts_Hidden_inputs);
            for j=1:length(Delta_Error_LastHidden_Nodes)
                for i=1:n
                    
                    [Updated_Weights_Input_Hidden(j,i)]=Weight_Updator(Learning_Rate,Input_Nodes(i),Delta_Error_LastHidden_Nodes(j),Weigthts_Hidden_inputs(j,i));
                end
            end
            
            
        end
    end
else 
    
    [m,n] = size(Weigthts_Hidden_inputs);
    for j=1:length(Delta_Error_LastHidden_Nodes)
        for i=1:n
            
            [Updated_Weights_Input_Hidden(j,i)]=Weight_Updator(Learning_Rate,Input_Nodes(i),Delta_Error_LastHidden_Nodes(j),Weigthts_Hidden_inputs(j,i));
        end
    end
    
end 





 end















