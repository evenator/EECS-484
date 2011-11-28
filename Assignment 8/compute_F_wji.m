%ordered derivatives with respect to wji 
function [F_wji] = compute_F_wji(sigma_history,F_u)
[Nneurons, T_time_steps] = size(F_u);
F_wji = zeros(Nneurons,Nneurons); %create holder for output with correct dimensions

%This is really inefficient, but should work
for j = 1:Nneurons
    for i = 1:Nneurons
        for t = 1:(T_time_steps-1)
            F_wjk(j,i) = F_u(j,t+1)*sigma_history(t);
        end
    end
end
