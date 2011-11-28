%ordered derivatives with respect to wji 
function [F_wji] = compute_F_wji(sigma_history,F_u)
[Nneurons, T_time_steps] = size(F_u);
F_wji = zeros(Nneurons,Nneurons); %create holder for output with correct dimensions

%compute sum of F_uvals terms over time:
%DO SOMETHING REAL HERE
