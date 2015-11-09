%% Train a Learner
numFeat = size(feat_train,2);
labels = result_train;
feats = feat_train;
w = zeros(numFeat,8);
for k = 1:8
    [w(:,k), L] = train_new_learner(feats, numEnvironmentsTrain, numTrajPerEnv, labels);
    labels = updateLabels(labels, numEnvironmentsTrain, L);
    feats = updateFeat2(feats, numEnvironmentsTrain, numTrajPerEnv, L);
end

%% Test The Learner On Training Data
wrong = zeros(numEnvironmentsTrain,8);
for e = 1:numEnvironmentsTrain
    min_ind = 30*(e-1)+1;
    max_ind = 30*e;
    ye = sign(result_train(min_ind:max_ind)-0.5);
    fe = feat_train(min_ind:max_ind,:)';
    traj = zeros(8,1);
    for k = 1:8
        y = zeros(numTrajPerEnv,1);
        conf = zeros(numTrajPerEnv,1);
        for t = 1:numTrajPerEnv
            i = (e-1)*30+t;
            y(t) = sign(result_train(i)-0.5);
            f = feat_train(i,:)';
            conf(t) = w(:,k)'*f;
        end
        [~,guess_ind] = maxN(conf,8);
        r = 1;
        while(sum(traj == guess_ind(r)) > 0)
            r = r + 1;
        end
        traj(k) = guess_ind(r);
    end
    for k = 1:8
        if(sum(ye(traj(1:k))==1) == 0)
            % No good trajectories
            wrong(e,k) = 1;
        end
    end
end


avg_success = zeros(1,8);
for k = 1:8
    avg_success(k) = 1 - sum(wrong(:,k))/size(wrong,1);
end
figure(3);
scatter(1:8,avg_success);
title('1.3.3) Average Training Data Success Rate');
fprintf('1.3.3) Average Training Data Success Rate\n');
disp(avg_success)

%% Test The Learner On Testing Data
wrong = zeros(numEnvironmentsTest,8);
for e = 1:numEnvironmentsTest
    min_ind = 30*(e-1)+1;
    max_ind = 30*e;
    ye = sign(result_test(min_ind:max_ind)-0.5);
    fe = feat_test(min_ind:max_ind,:)';
    traj = zeros(8,1);
    for k = 1:8
        y = zeros(numTrajPerEnv,1);
        conf = zeros(numTrajPerEnv,1);
        for t = 1:numTrajPerEnv
            i = (e-1)*30+t;
            y(t) = sign(result_test(i)-0.5);
            f = feat_test(i,:)';
            conf(t) = w(:,k)'*f;
        end
        [~,guess_ind] = maxN(conf,8);
        r = 1;
        while(sum(traj == guess_ind(r)) > 0)
            r = r + 1;
        end
        traj(k) = guess_ind(r);
    end
    for k = 1:8
        if(sum(ye(traj(1:k))==1) == 0)
            % No good trajectories
            wrong(e,k) = 1;
        end
    end
end


avg_success = zeros(1,8);
for k = 1:8
    avg_success(k) = 1 - sum(wrong(:,k))/size(wrong,1);
end
figure(4);
scatter(1:8,avg_success);
title('1.3.3) Average Testing Data Success Rate');
fprintf('1.3.3) Average Testing Data Success Rate\n');
disp(avg_success)