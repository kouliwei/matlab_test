clc
clear;
ca = cos(pi/6);
sa = sin(pi/6);
y0 = 0.2;
B = [ca -ca ca -ca;sa sa sa sa; -sa*y0 sa*y0 sa*y0 -sa*y0];
B_Pinv  = pinv(B);
B_Null = eye(4)-B_Pinv*B;
[S V D]=svd(B_Null)