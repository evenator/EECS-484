%scale_all_feature_values.m EDIT THIS FILE
% uses raw_features, feature_max_vals and feature_min_vals and populates
% feature_scaled_vals, puts in range 0 to 1
for ifeature=1:nfeatures
    maxval =  feature_max_vals(ifeature);
    minval = feature_min_vals(ifeature);
    for jpattern=1:npatterns
        rawval=raw_features(jpattern,ifeature);
        %NEXT LINE IS NOT CORRECT--FIX IT
        feature_scaled_vals(jpattern,ifeature)=(rawval-minval)/(maxval-minval);
    end %done w/ this feature for all patterns
end %done w/ all patterns
        