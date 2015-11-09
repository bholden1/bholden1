function [labels] = updateLabels(labels, numEnvironmentsTrain, L)
E = numEnvironmentsTrain;
for e = 1:E
    i = 30*(e-1) + L(e);
    labels(i) = 0;
end 
end