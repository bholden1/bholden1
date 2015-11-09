function [feats] = updateFeat(feats, numEnvironmentsTrain, numTrajPerEnv, L)
E = numEnvironmentsTrain;
for e = 1:E
    fi = 30*(e-1) + L(e);
    for t = numTrajPerEnv
        i = 30*(e-1) + t;
        feats(i,:) = feats(i,:) - feats(fi,:);
    end
end 
end