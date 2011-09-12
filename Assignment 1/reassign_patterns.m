%reassign_patterns.m  NO CHANGES REQUIRED
nchanges=0;
for ipat=1:npatterns
    %ipat %debug echo--report current pattern under consideration
    attributes(ipat);
    current_cluster=pattern_assignments(ipat); %and current cluster assignment of this pattern
    find_closest_cluster %closest cluster index now in closestClust
    closestClust %echo closest cluster
    %cluster_attributes(closestClust)
    %pattern_assignments
    if (current_cluster ~=closestClust)
        remove_pattern_from_cluster %operates on current_cluster and ipat
        put_pattern_into_cluster %operates on closestClust and ipat
        nchanges=nchanges+1; %increment counter for pattern reassignments
        %cluster_attributes
        %cluster_populations
        %dummy=input ('pause--enter 1 to continue');
    end
    %pattern_assignments
    %pause
end