function [ind] = getIndex(array, value)
k = sum(array==value);
count = 1;
ind = zeros(k,1);
for i = 1:size(array,1)
    if(array(i)==value)
        ind(count) = i;
        count = count + 1;
    end
end
end