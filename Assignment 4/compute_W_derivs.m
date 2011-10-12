%computes derivatives w/rt weights for BP
function  [dWkj,dWji] = compute_W_derivs(Wji,Wkj,training_patterns,targets)
dWji=0*Wji; %sets dimensions of output matrices
dWkj=0*Wkj;

[P,K] = size(targets); %P training patterns, K-dimensional output
[J,I] = size(Wji); %J interneurons, I-dimensional input patterns

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
    %For loops are slow, but matrices are hard and I was up until 3AM
    %building a function generator last night
    for k=1:K %compute influence w/rt output node k
        err_k = outputk(k)-targets(p,k); %error for output k vs target k--will need this
        gprime_k = outputk(k) * (1-outputk(k)); %slope of activation fnc for neuron k for pattern p
        dWkj(k,:) = dWkj(k,:) + err_k * gprime_k * outputj';
        % will also need gprime_j in an inner loop for dE/dwji terms
        for j = 1:J %Compute influence w/rt interneuron j
            gprime_j = outputj(j) *( 1-outputj(j)); %slope of activation fnc for neuron j for pattern p
            dWji(j,:) = dWji(j,:) + err_k * gprime_k * gprime_j * Wkj(k, j) * stim_vec';
        end
    end %done w/ loop over all K output neurons
end %done evaluating influence of all P stimulus patterns
