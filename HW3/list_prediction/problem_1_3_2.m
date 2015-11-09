%% Train a Learner
T = size(feat_train,1);
numFeat = size(feat_train,2);
w = zeros(numFeat,1);
loss = zeros(numFeat,1);
wrong = zeros(T,1);
for i = 1:T
    y = sign(result_train(i)-0.5);
    f = feat_train(i,:)';
    wrong(i) = y*w'*f < 0;
    [w,loss(i)] = FTRL(w, y, f, i, T);
end
fprintf('Percent Error: %.2f\n',sum(wrong)/T*100);

%% Test The Learner On Training Data
wrong = zeros(numEnvironmentsTrain,8);
for e = 1:numEnvironmentsTrain
    conf = zeros(numTrajPerEnv,1);
    y = zeros(numTrajPerEnv,1);
    for t = 1:numTrajPerEnv
        i = (e-1)*30+t;
        y(t) = sign(result_train(i)-0.5);
        f = feat_train(i,:)';
        conf(t) = w'*f;
    end
    for k = 1:8
        [~,guess_ind] = maxN(conf,k);
        if(sum(y(guess_ind)==1) == 0)
            % No good trajectories
            wrong(e,k) = 1;
        end
    end
end
avg_success = zeros(1,8);
for k = 1:8
    avg_success(k) = 1 - sum(wrong(:,k))/size(wrong,1);
end
figure(1);
scatter(1:8,avg_success);
title('1.3.2) Average Training Data Success Rate');
fprintf('1.3.2) Average Training Data Success Rate\n');
disp(avg_success)

%% Test The Learner On Test Data
wrong = zeros(numEnvironmentsTest,8);
for e = 1:numEnvironmentsTest
    conf = zeros(numTrajPerEnv,1);
    y = zeros(numTrajPerEnv,1);
    for t = 1:numTrajPerEnv
        i = (e-1)*30+t;
        y(t) = sign(result_test(i)-0.5);
        f = feat_test(i,:)';
        conf(t) = w'*f;
    end
    for k = 1:8
        [~,guess_ind] = maxN(conf,k);
        if(sum(y(guess_ind)==1) == 0)
            % No good trajectories
            wrong(e,k) = 1;
        end
    end
end
avg_success = zeros(1,8);
for k = 1:8
    avg_success(k) = 1 - sum(wrong(:,k))/size(wrong,1);
end
figure(2);
scatter(1:8,avg_success);
title('1.3.2) Average Testing Data Success Rate');
fprintf('1.3.2) Average Testing Data Success Rate\n');
disp(avg_success);