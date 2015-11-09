function [val,ind] = maxN(array,N)
ind = zeros(N,1);
val = zeros(N,1);
m = inf;
for i = 1:N
    ind(i) = 0;
    val(i) = -inf;
    for j = 1:size(array,1)
        if(array(j) < m && array(j) > val(i))
            ind(i) = j;
            val(i) = array(j);
        end
    end
    m = val(i);
end
end