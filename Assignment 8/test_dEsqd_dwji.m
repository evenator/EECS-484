%numerical approximation to derivatives w/rt w 
function       [approx_F_wji] = test_dEsqd_dwji(W,sigma_history,u_history,targets)
temp = size(sigma_history);
DELW = 0.000001; %weight perturbation
Nneurons = temp(1);
T_time_steps=temp(2);
approx_F_wji=zeros(Nneurons,Nneurons);
    %simulate network for all time steps to get reference error
        for t=2:T_time_steps
          u_history(:,t)=W*sigma_history(:,t-1); %inputs are defined by sigmas, including bias and input                                                                       
          %compute outputs for these inputs, except for predefined bias and stimulation
          sigma_history(3:Nneurons,t)= logsig(u_history(3:Nneurons,t)); %squashing function    
        end
        %compute all errors
        outputs=sigma_history(3,:); %have defined neuron 3 as the sole output neuron
        errs = outputs'-targets; %compare output-neuron value to target at each time step
        Esqd_nom = 0.5*errs'*errs; %sum squared error
        
   %now,  perturb one synaptic weight at a time, re-simulate and compute
   %change in error
  for i=1:Nneurons
      for j=1:Nneurons
          Wtest=W;
          Wtest(j,i)=Wtest(j,i)+DELW ; %perturb weight by this much
         for t=2:T_time_steps
           u_history(:,t)=Wtest*sigma_history(:,t-1); %inputs are defined by sigmas, including bias and input                                                                       
           %compute outputs for these inputs, except for predefined bias and stimulation
           sigma_history(3:Nneurons,t)= logsig(u_history(3:Nneurons,t)); %squashing function    
         end
        %compute all errors
        outputs=sigma_history(3,:); %have defined neuron 3 as the sole output neuron
        errs = outputs'-targets; %compare output-neuron value to target at each time step
        Esqd = 0.5*errs'*errs; %sum squared error
        approx_F_wji(j,i)= (Esqd-Esqd_nom)/DELW;
      end
  end
  
