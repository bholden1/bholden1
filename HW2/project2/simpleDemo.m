%% This script applies a random policy on a constant game
clc;
close;
close all;
clear all;

%% Get the constant game
% game = gameGaussian(10,10000);
% game = gameConstant();
% game = gameAdversarial();
% game = gameLookupTable('data/univLatencies.mat',1);
game = gameLookupTable('data/plannerPerformance.mat',1);

%% Get a set of policies to try out
policies = {policyEXP3(), policyUCB()};
policy_names = {'policyEXP3', 'policyUCB'};
policy_colors = {'b', 'g'};

%% Run the policies on the game
reward_m = zeros(length(policies),game.totalRounds);
action_m = zeros(length(policies),game.totalRounds);
regret_m = zeros(length(policies),game.totalRounds);
for k = 1:length(policies)
    fprintf('Start %s\n',policy_names{k});
    policy = policies{k};
    game.resetGame();
    [reward, action, regret] = game.play(policy);
    fprintf('Policy: %s Reward: %.2f\n', class(policy), sum(reward));
    reward_m(k,:) = reward;
    action_m(k,:) = action;
    regret_m(k,:) = regret;
end
time = 1:game.totalRounds;
figure(1)
hold on
title('Regret');
for k = 1:length(policies)
    plot(time,regret_m(k,:),sprintf('%s',policy_colors{k}));
end
legend(policy_names);
hold off
figure(2)
hold on
title('Action');
for k = 1:length(policies)
    plot(time,action_m(k,:),sprintf('%s',policy_colors{k}));
end
legend(policy_names);
hold off
