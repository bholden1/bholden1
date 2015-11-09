%% Reset Workspace For SVM
close all;
clear;
clc;
load svm_data.mat;

%% Get Relevant SVM Data
unique_ids = [1004,1100,1103,1200,1400];
label1 = unique_ids(4);
label2 = unique_ids(5);
I1 = getIndex(node_label,label1);
I2 = getIndex(node_label,label2);
figure(1);
hold on;
scatter3(x(I1),y(I1),z(I1),0.5,'c');
scatter3(x(I2),y(I2),z(I2),0.5,'m');
legend('Ground','Facade');
hold off;
I = [I1;I2];
len = size(I,1);
data_rel.x = zeros(len,1);
data_rel.y = zeros(len,1);
data_rel.z = zeros(len,1);
data_rel.node_id = zeros(len,1);
data_rel.node_label = zeros(len,1);
data_rel.features = zeros(len,size(features,2));
for i = 1:len
    data_rel.x(i) = x(I(i));
    data_rel.y(i) = y(I(i));
    data_rel.z(i) = z(I(i));
    data_rel.node_id(i) = node_id(I(i));
    data_rel.node_label(i) = node_label(I(i));
    data_rel.features(i,:) = features(I(i),:);
end

%% Run SVM 
T = size(data_rel.x,1);
w = zeros(size(data_rel.features,2),1);
l = zeros(T,1);
wrong = zeros(T,1);
wrong1 = zeros(T,1);
wrong2 = zeros(T,1);
e = randperm(T);
pos = label1;
time_0 = cputime;
for i = 1:T
    t = e(i);
    y = sign((data_rel.node_label(t)==pos)-0.5);
    f = data_rel.features(t,:)';
    [w_next,loss] = FTRL(w, y, f, i, T);
    wrong(i) = y*w'*f < 0;
    wrong1(i) = wrong(i)*(y==1);
    wrong2(i) = wrong(i)*(y==-1);
    w = w_next;
    l(i) = loss;
end
time_1 = cputime;
fprintf('Time to run learner: %.4f\n\n',time_1-time_0);
fprintf('Total Points: %i\nIncorrect Labels: %i\nPercent Mislabeled: %.2f%%\n\n',T,sum(wrong),sum(wrong)/T*100);
fprintf('Total Ground Points: %i\nTotal Ground Points Mislabeled: %i\nPercent Ground Mislabeled: %.2f\n\n',size(I1,1),sum(wrong1),sum(wrong1)/size(I1,1)*100);
fprintf('Total Facade Points: %i\nTotal Facade Points Mislabeled: %i\nPercent Facade Mislabeled: %.2f\n\n',size(I2,1),sum(wrong2),sum(wrong2)/size(I2,1)*100);