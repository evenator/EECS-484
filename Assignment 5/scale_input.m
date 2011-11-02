function [ scaled] = scale_input( input , minimum, maximum )
%This function rescales the inputs to the range -1..1
    scaled = 2*(input - ones(length(input),1) * minimum) / (maximum - minimum) - 1;
end

