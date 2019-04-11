clc;
format long
ca = cos(pi/6);
sa = sin(pi/6);
y0 = 0.2;
B = [ca -ca ca -ca;sa sa sa sa; -sa*y0 sa*y0 sa*y0 -sa*y0];
B_Pinv  = pinv(B);
B_Null = eye(4)-B_Pinv*B;
T = [10 20 5]';

My_timeall = [];
My_timesum = 0;
My_obj = [];
for i=1:1000
T = [10 + rand(1);20 + 2*rand(1);5 + 1*rand(1)];
tic
T1 = B_Pinv*T;
T1_Temp = [T1(1);T1(2);-T1(3);-T1(4)];

%%
limit = [-40 40;-40 40;-40 40;-40 40] - [T1_Temp T1_Temp];
[Left_MaxValue pos1] = max(limit(:,1));
[Right_MinValue pos2] = min(limit(:,2));

T_optimal = 0;
flag = 0;
coffi = 1;


if Right_MinValue >= Left_MaxValue   %% exist the solution 
    if Right_MinValue * Left_MaxValue <=0
        temp = 0;
        flag = 1;
    else
        if Right_MinValue < 0 
            temp = Right_MinValue;
            flag = 21;
        else
            temp = Left_MaxValue;
            flag = 22;
        end
    end
else                                % exist no solution 
    coffi = 80/(T1_Temp(pos2) - T1_Temp(pos1));
    flag = 3;
    temp = -40 - coffi*T1_Temp(pos1);
end
T_optimal = coffi*T1 + [1;1;-1;-1]*temp;
z1 = norm(T_optimal)^2/2;
My_obj = [My_obj z1];
My_timeall = [My_timeall toc];
My_timesum = My_timesum + toc;
end








