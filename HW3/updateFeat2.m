function [feats] = updateFeat2(feats, numEnvironmentsTrain, numTrajPerEnv, L)
E = numEnvironmentsTrain;
feats = [feats,zeros(size(feats,1),1)];
for e = 1:E
    fi = 30*(e-1) + L(e);
    feat_dist = sum(feats(fi,:).^2);
    for t = numTrajPerEnv
        i = 30*(e-1) + t;
        feats(i,size(feats,2)) = sum(feats(i,:).^2) - feat_dist;
    end
end 
end