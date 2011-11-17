%brute-force solution to TSP--runs VERY slowly
%specialized for 10-cities tour
% you do not need to run this, but you can if you like.

%compute all solutions exhaustively and save a list of the trip costs
%for any circle trip, may arbitrarily assume starting from city 1 and
%ending at city 1--all such trips have an equivalency starting at city 2
%and ending at city 2, etc.  Therefore, don't need to recalculate these.
%Also, if the costs are symmetric (cost from A to B = cost from B to A)
%then don't need to compute reverse-order trips.  E.g., can enforce that
%2nd city visited ranges from 2 to Ncities/2, and next to last city visited
%starts at Ncities/2+1 and ranges to Ncities--cuts number of candidates in
%half.
%function [all_solutions] = brute_force(intercity_distances)
clear all
load 'intercity_distances.dat'; %read in the intercity distances
temp = size(intercity_distances);
Ncities=temp(1);
all_solutions=[];
%set first and last cities to city 1:
trip = ones(1,11);
ntries=0;
nvalid=0;
for c2=2:6  %range of values for city2; consider cities 7 through 10 only for c10; generates
                    %trips that are not redundant forward vs reverse order
    for c3=2:10
        for c4=2:10
            for c5=2:10
                for c6=2:10
                    for c7=2:10
                        for c8=2:10
                            for c9=2:10
                                for c10=7:10 %no need to repeat any values used by c2; can consider reverse-order trip
                                    ntries=ntries+1;
                                    if (0 == mod(ntries,100000)) %output every 100,000 trys to report on progress
                                        ntries
                                    end
                                    trip=[1,c2,c3,c4,c5,c6,c7,c8,c9,c10,1]; %need to check if this trip is viable
                                    ndistinct=num_cities_visited(trip); 
                                    if ndistinct==Ncities %valid tour
                                        trip
                                        dist=eval_soln(trip,intercity_distances)
                                        all_solutions=[all_solutions,dist];
                                        nvalid=nvalid+1
                                         %pause
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
mu = mean(all_solutions)
sigma = std(all_solutions)
best = min(all_solutions)
worst = max(all_solutions)
hist(all_solutions,100)
title('cost histogram of viable trips')
               
           