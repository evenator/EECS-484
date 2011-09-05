%plot_clusters.m  UTILITY--DOES NOT NEED EDITING
figure(1)
clf
for ipat=1:npatterns
    jclust = pattern_assignments(ipat);
    attrib_val = attributes(ipat);
    plot(jclust,attrib_val,'xb')
    hold on
end
for jclust=1:nclusters
    plot(jclust,cluster_attributes(jclust),'or')
end
title('cluster results')
xlabel('cluster number')
ylabel('pattern attribute values')
grid
%hold off
    
    
    