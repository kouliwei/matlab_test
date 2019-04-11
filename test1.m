clc;
clear;
format long
B=randn(2,3);
B1 = pinv(B)
B_NULL = diag([1 1 1])-B1*B
rank(B_NULL)
plim=[-10*ones(3,1),10*ones(3,1)];
ratio = vview(B,plim,pinv(B));
title('Random B')
xlabel('Gamma1');
ylabel('Gamma2');





