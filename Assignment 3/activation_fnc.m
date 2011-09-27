%activation function--linear for u>=0, zero for u<0
function sigma = activation_fnc(u)
%here's a pure linear activation function (output = input)
    if(u>0)
        sigma = u;
    else
        sigma = 0;
    end
 %fix this--make it pure linear for positive inputs, but outputs 0 for
 %negative inputs
