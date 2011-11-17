%function to evaluate if a proposed trip is viable (test if any cities repeated)
%returns Ncities if the trip has no repeats (except for returning to
%originating city)
function [ndistinct] = num_cities_visited(trip)
temp=size(trip);
Ncities=temp(2);
citylist = zeros(1,Ncities); %check these off as they are visited
for i=1:Ncities
    city=trip(i);
    citylist(city)=1;
end
ndistinct = sum(citylist);
