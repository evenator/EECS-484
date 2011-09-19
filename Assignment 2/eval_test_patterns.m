%eval_test_patterns.m
%given clusters and an input vector, compute pattern response due to
%resonance with each cluster
%NO EDITS NEEDED


load scrambled_testpats %brings in scrambled I, X and H

response_pat=zeros(nclustrows,nclustcols);
stim_pat = I_scrambled_pat;
stim_vec=pat2vec(stim_pat);
stim_vec = stim_vec/norm(stim_vec);
for i=1:nclustrows
    for j=1:nclustcols
        featurevec=squeeze(clusters(i,j,:));
        response_pat(i,j)=stim_vec'*featurevec;
    end
end
figure(2)
bar3(response_pat)
title('response to scrambled I pattern')

%H pattern...
stim_pat = H_scrambled_pat;
stim_vec=pat2vec(stim_pat);
stim_vec = stim_vec/norm(stim_vec);
for i=1:nclustrows
    for j=1:nclustcols
        featurevec=squeeze(clusters(i,j,:));
        response_pat(i,j)=stim_vec'*featurevec;
    end
end
figure(3)
bar3(response_pat)
title('response to scrambled H pattern')

%X pattern...
stim_pat = X_scrambled_pat;
stim_vec=pat2vec(stim_pat);
stim_vec = stim_vec/norm(stim_vec);
for i=1:nclustrows
    for j=1:nclustcols
        featurevec=squeeze(clusters(i,j,:));
        response_pat(i,j)=stim_vec'*featurevec;
    end
end
figure(4)
bar3(response_pat)
title('response to scrambled X pattern')