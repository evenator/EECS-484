
%Begin tunable parameters%
n_clusters=20;
max_passes=1000;
%End tunable parameters

[n_pats, n_features] = size(patterns);

%Scale patterns to 0-1 range
feature_max_vals = max(patterns,[],1);
feature_min_vals = min(patterns,[],1);
feature_range_vals = feature_max_vals - feature_min_vals;
feature_range_vals = feature_range_vals + (feature_range_vals==0); %Divide by zero protection
scaled_patterns = (patterns - ones(n_pats,1) * feature_min_vals) ./ (ones(n_pats,1) * feature_range_vals);

%Seed clusters with random patterns
%Cluster roster has binary value at index (i, j) indicating
%whether pattern j is a member of cluster i
cluster_roster = k_means_seed_clusters(n_clusters, n_pats);

%Perform clustering
nchanges=1;
num_passes=0;
while((nchanges>0) && (num_passes<max_passes))
    old_roster = cluster_roster;
    cluster_roster = k_means_cluster(cluster_roster, scaled_patterns);
    nchanges = sum(sum(abs(cluster_roster - old_roster)));
    num_passes = num_passes+1;
end

%Calculate Cluster Centroids
cluster_centroids = zeros(n_clusters, n_features);
for i = 1:n_clusters
    cluster_centroids(i, :) = k_means_cluster_centroid(cluster_roster(i,:),scaled_patterns);
end

[num_validation_pats ~] = size(validation);

%Calculate Attribute Values
cluster_attributes = zeros(n_clusters,1);
cluster_sd = zeros(n_clusters,1);
for i=1:n_clusters
    cluster_members = cluster_roster(i,:)==1;
    if(sum(cluster_members)>0)
        cluster_attributes(i) = mean(targets(cluster_members,:),1);
        cluster_sd(i) = std(targets(cluster_members,:),1);
    end
end
cluster_populations = sum(cluster_roster,2)
cluster_attributes
cluster_sd

%Scale validation patterns
scaled_validation = (validation - ones(num_validation_pats,1) * feature_min_vals) ./ (ones(num_validation_pats,1) * (feature_range_vals));

%Assign validation patterns to clusters
cluster_list = zeros(num_validation_pats,1);
for i = 1:num_validation_pats
    cluster_list(i) = k_means_closest_cluster(scaled_validation(i,:),cluster_centroids);
end

%Debug results
result_eval = cluster_attributes(cluster_list)-val_targets;
disp('Bin; Target Value(1=r, 2=u, 3=o); Calculated Value');
cat(2,cluster_list,val_targets,cluster_attributes(cluster_list))