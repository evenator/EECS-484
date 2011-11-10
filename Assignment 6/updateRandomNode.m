   % fnc to correct nodes in matrix memory
   %YOU MUST WRITE THIS FUNCTION
function [vec,delta] = updateRandomNode(MatrixMem,vec)
    node_index = random('unid', length(vec));
    delta = vec(node_index);
    vec(node_index) = sign(MatrixMem(node_index,:) * vec);
    delta = abs(delta - vec(node_index))/2;
    
