%Assign synapse weights
function [T,Tabc] = assign_weights(A,B,C,D,n_cities,costs)	
   n_days = n_cities;
   
   Tabc = zeros(n_cities, n_days, n_cities, n_days);
   
   %Fill in the T matrix
   
   %Global inhibition
   T = -C * ones(n_cities, n_days, n_cities, n_days);
   
   for x = 1:n_cities
       for y = 1:n_cities
           for i = 1:n_days
               for j = 1:n_days
                   %Penalize visiting the same city on two different days
                    if x==y && i~=j
                        T(x,i,y,j) = T(x,i,y,j) - A;
                    end
                    %Penalize visiting two cities on the same day
                    if i==j &&x~=y
                        T(x,i,y,j) = T(x,i,y,j) - B;
                    end
                    
                    %Copy first three terms to Tabc
                    Tabc(x,i,y,j) = T(x,i,y,j);
                    
                    %Data term
                    if j==(i-1)
                        T(x,i,y,j) = T(x,i,y,j) - D*costs(x,y);
                    end
                    if i==(j-1)
                        T(x,i,y,j) = T(x,i,y,j) - D*costs(x,y);
                    end
               end
           end
       end
   end