%find_minmax_feature_values.m  NO EDITS REQUIRED
%comb through all values of each feature for all patterns and find and record peak for each
%feature;  uses training_data and populates feature_max_vals and
%feature_min_vals
for ifeature=1:nfeatures
    for jpattern=1:npatterns
        testval=raw_features(jpattern,ifeature);
        if (testval>feature_max_vals(ifeature))
            feature_max_vals(ifeature)=testval;
        end %end "if" for max test
        if (testval<feature_min_vals(ifeature))
            feature_min_vals(ifeature)=testval;
        end %end "if" for min test
    end %end pattern loop
end %end feature loop
