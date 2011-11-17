%eval_soln:
%input a sequence of cities and return the trip cost
%presumably, first and last cities in the list are both city 1
function [tripcost]  = eval_soln(trip,costs)
 temp=size(trip);
 triplength=temp(2);
 tripcost=0;
 cityB=trip(1);
 for i=2:triplength
     cityA=cityB;
     cityB=trip(i);
     tripcost=tripcost+costs(cityA,cityB);
 end
     