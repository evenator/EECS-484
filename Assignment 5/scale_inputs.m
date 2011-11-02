function [ scaled, minimum, maximum ] = scale_inputs( inputs )
%This function rescales the inputs to the range -1..1
    minimum = min(inputs);
    maximum = max(inputs);
    scaled = 2*(inputs - ones(length(inputs),1) * minimum) / (maximum - minimum) - 1;
end

