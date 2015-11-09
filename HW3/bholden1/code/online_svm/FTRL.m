function [w_next,loss] = FTRL(w, y, f, t, T)
lambda = 0.1;
eta = 0.1;
alpha = eta/sqrt(t);
if 1-y*w'*f > 0
    loss_grad = w*lambda/T - y*f;
else
    loss_grad = w*lambda/T;
end
w_next = w - alpha*loss_grad;
loss = (eta/(2*T))*sum(w.^2) + max(0,1-y*w'*f);
end