clc
clear;
A = [1 2];
b = 10;
A_inv = pinv(A)
A_Nul = eye(2) -  pinv(A)*A
x = A_inv*b