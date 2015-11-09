function [w, L] = train_new_learner(feat_train, numEnvironmentsTrain, numTrajPerEnv, result_train)
numFeat = size(feat_train,2);
w = zeros(numFeat,1);
L = zeros(numEnvironmentsTrain,1);
for e = 1:numEnvironmentsTrain
    min_ind = 30*(e-1)+1;
    max_ind = 30*e;
    y = sign(result_train(min_ind:max_ind)-0.5);
    f = feat_train(min_ind:max_ind,:)';
    for t = 1:numTrajPerEnv
        [w,~] = FTRL(w, y(t), f(:,t), e, numEnvironmentsTrain);
    end
    utility = getUtility(w,f);
    [~,ind] = max(utility);
    L(e) = ind;
end
end