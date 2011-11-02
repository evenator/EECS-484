function [ error ] = output_error( output, targets )
%Calculates rms error
    npatterns = length(targets);
    errvec = targets - output';
    Esqd_avg = norm(errvec)/npatterns;
    error = sqrt(Esqd_avg);
end

