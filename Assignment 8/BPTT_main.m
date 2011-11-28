%PS8 BPTT, recurrent neural net 
%this code is specialized for a single input and a single output
%uses logsig() activation fnc

%set virtual neuron (bias input) to be neuron #1
%set input neuron to be neuron 2, 
%set output neuron to be neuron 3,
% additional neurons are 4 through Nneurons
clear all
Nneurons = 3; %CHOOSE THIS; N=4 for  single "interneuron" case
INIT_WEIGHT_MAG = 1.0; %scale synapse initializations to random number +/- in this range
ETA = 0.01; %learning factor--tune this
ETASIG=0.01; %learning weight for adjusting initial conditions of interneurons--tune this
%read in the training file:
load beats.dat  %simple pattern
%alternatively, uncomment next two lines to use second, more complex pattern
%load beats2.dat 
%beats=beats2;
temp=size(beats);
T_time_steps = temp(1);
time_vec=(1:T_time_steps);
inputs=beats(:,1)
targets=beats(:,2)

%initialize network: set synaptic weights to random values, scaled by INIT_WEIGHT_MAG
W = (rand(Nneurons,Nneurons)-0.5)*2.0*INIT_WEIGHT_MAG

%define matrices to hold entire time history of values of interest:
u_history=zeros(Nneurons,T_time_steps);
sigma_history = zeros(Nneurons,T_time_steps);
F_sigmas=zeros(Nneurons,T_time_steps);
F_uvals=zeros(Nneurons,T_time_steps);
gprimes = zeros(Nneurons,T_time_steps);

%output for bias node should be  unity for all time steps:
sigma_history(1,:)=1.0; %bias node always outputs unity
%for sensory node, output must be the prescribed beat sync stimulation:
sigma_history(2,:)=inputs;
%force the network to give correct output at initial time:
sigma_history(3,1)=targets(1);  %node three at time 1
%all other "interneurons" are initialized to random values
%(these values may be optimized by BPTT)
sigma_history(4:Nneurons,1)=rand(Nneurons-3,1); %all other nodes at time 1

%don't care about u-values at time 1, since we have already defined sigma vals for time 1;

%iterate on learning:
niters=1
while niters>0
    for iiter = 1:niters
    %simulate network for all time steps
        for t=2:T_time_steps
                 %note insertion of time slip--sigmas at time t-1 induce
                 %u-vals at time t
          u_history(:,t)=W*sigma_history(:,t-1); %inputs are defined by sigmas, including bias and input                                                                       
          %compute outputs for these inputs, except for predefined bias and stimulation
          sigma_history(3:Nneurons,t)= logsig(u_history(3:Nneurons,t)); %squashing function    
        end
        
        %done with simulation; compute all errors
        outputs=sigma_history(3,:); %have defined neuron 3 as the sole output neuron
        errs = outputs'-targets; %compare output-neuron value to target at each time step
        Esqd = 0.5*errs'*errs; %sum squared error
        %u_history % optionally, output u_history and sigma_history for debug
        %sigma_history
        
        %compute all derivatives; could do this in a summation,
%          for t=1:T_time_steps
%             gprimes(:,t) = dlogsig(u_history(:,t),sigma_history(:,t)); %dsigma/du for each node for each time step
%          end
 %or faster in a single operation:
        gprimes=dlogsig(u_history,sigma_history);
        gprimes(1:2,:)=zeros(2,T_time_steps); %force bias and input nodes to be unchanging

        %compute all ordered derivatives w/ rt sigmas and u's for all time
        %steps, backwards through time
        for t=T_time_steps:-1:1
            F_sigmas(:,t)= compute_F_o(W,errs,F_uvals,t); %F_sigma at time t first,
            F_uvals(:,t)= compute_F_u(F_sigmas,gprimes,t); %followed by F_uvals at time t
            %then continue to work backwards in time, completing all
            %F_sigmas and F_uvals terms back to time 1
        end
        %compute ordered derivatives for wij for network unfolded in time
        [F_wji] = compute_F_wji(sigma_history,F_uvals) %INSERT ; TO SUPPRESS PRINTING ONCE DEBUGGED

        %debug--test derivs relative to numerical approx
        %approx_F_wji should be the same as F_wji
        %COMMENT this out once F_wji is debugged
        [approx_F_wji] = test_dEsqd_dwji(W,sigma_history,u_history,targets)

        %update weights:
        W = W - ETA*F_wji;   %same as back-propagation
        
        %update initial firing rates of hidden nodes using ordered deriv dE/dsigma(time=1):
        sigma_history(4:Nneurons,1)= sigma_history(4:Nneurons,1)-ETASIG*F_sigmas(4:Nneurons,1);
        %every 100 iterations, print out the fit error and update a
        %graphical display of target values and output values
        if  mod(iiter,100)==0
                    iiter %iteration number
                  rms_err=sqrt(Esqd/T_time_steps)
                 figure(1)
                plot(time_vec,targets,'*',time_vec,outputs,'o');
                pause
        end
    end
    %F_wji %debug
    %approx_F_wji
    %sigma_history %(4:Nneurons,1)
    figure(1)
    plot(time_vec,targets,'*',time_vec,outputs,'o');
    title('targets and network responses vs. time')
    niters= input('enter number of iterations: ')
end  %iterate