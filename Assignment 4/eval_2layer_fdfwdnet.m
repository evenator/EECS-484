%helper fnc to evaluate outputs of a 2-layer fdfwd net;
%assumes stimulus vector and interneuron layer include bias node
%layer-j output includes a dummy interneuron output set to unity to drive bias of layer K
function [outputj,outputk]=eval_2layer_fdfwdnet(W1p,W21,stim_vec)
u_net_layer1 = W1p*stim_vec;
outputj=logsig(u_net_layer1);
outputj (1)= 1; %set bias node in outputj(1)

%augment interneuron outputs with addl bias term:
u_net_layer2 = W21*outputj;

%output = layer_activation_fnc(u_net_layer2)
outputk=logsig(u_net_layer2);