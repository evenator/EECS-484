%run through all input patterns and view responses w/rt all clusters
function view_all_pattern_responses(scrambled_vecs,clusters)
temp=size(scrambled_vecs);
npats=temp(1);

temp=size(clusters);
gridrows=temp(1);
gridcols=temp(1);
for (ipat=1:npats)
  stimvec=squeeze(scrambled_vecs(ipat,:)); %sequence through all input patterns
response_pat=zeros(gridrows,gridcols); %build grid response to input pattern
for i=1:gridrows
    for j=1:gridcols
        featurevec=squeeze(clusters(i,j,:)); %get similarity to each cluster feature vec
        response_pat(i,j)=stimvec*featurevec; %similiarity is dot product
    end
end
figure(1)
bar3(response_pat)
title(['grid response to stimulus vector ',int2str(ipat)])
end