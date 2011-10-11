%computes derivatives w/rt weights for BP
function  [dWkj,dWji] = compute_W_derivs(Wji,Wkj,training_patterns,targets)
dWji=0*Wji; %sets dimensions of output matrices
dWkj=0*Wkj;

temp =size(targets);
P=temp(1); %number of training patterns
K=temp(2); %number of outputs
temp = size(Wji);
J=temp(1); %number of interneurons
I=temp(2); %dimension of input patterns

%loop over all input patterns and compute influence of each pattern on
%dE/dw
for p=1:P %make the P loop the outer loop, since need to re-use results of
    %network simulation for pattern p many times
    stim_vec= training_patterns(p,:)'; % extract p'th training input
    
    %perform a network simulation with current values of W's
    %need to know outputs of both j and k layers for stimulus pattern p to
    %compute dE/dwji
    [outputj,outputk]=eval_2layer_fdfwdnet(Wji,Wkj,stim_vec);
    
    %compute contribution of this pattern to all elements of Wkj and Wji
    % requires nested loops
    for k=1:K %compute influence w/rt output node k
        err_k = outputk(k)-targets(p,k); %error for output k vs target k--will need this
        gprime_k=0; %slope of activation fnc for neuron k for pattern p; FIX THIS
        % will also need gprime_j in an inner loop for dE/dwji terms
        
        %NEED CODE HERE; debug by comparing to numerical estimate
        
    end %done w/ loop over all K output neurons
end %done evaluating influence of all P stimulus patterns
