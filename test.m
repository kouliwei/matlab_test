clc;
clear;
format long
ca = cos(pi/6);
sa = sin(pi/6);
y0 = 0.2;
B = [ca -ca ca -ca;sa sa sa sa; -sa*y0 sa*y0 sa*y0 -sa*y0]
B_Pinv  = pinv(B)
B_Null = eye(4)-B_Pinv*B
Tstring1  = input('input Fu: ','s');
Tstring2  = input('input Fw: ','s');
Tstring3  = input('input Tr: ','s');
T = [str2double(Tstring1);str2double(Tstring2);str2double(Tstring3)];
T1 = B_Pinv*T;
T1_Temp = [T1(1);T1(2);-T1(3);-T1(4)];

%%
limit = [-40 40;-40 40;-40 40;-40 40] - [T1_Temp T1_Temp];
[Left_MaxValue pos1] = max(limit(:,1))
[Right_MinValue pos2] = min(limit(:,2))

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








%% matlab toolbox computation
H =[1 0 0 0;0 1 0 0;0 0 1 0; 0 0 0 1];
lb= [-40;-40;-40;-40];
ub=[40;40;40;40];
B = [ca -ca ca -ca;sa sa sa sa; -sa*y0 sa*y0 sa*y0 -sa*y0];
bx = T;
f=[];
[x,z]=quadprog(H,f,[],[],B,bx,lb,ub)
T_optimal
flag
coffi
z1 = norm(T_optimal)^2/2
if isempty(x)
    x = [0;0;0;0];
end
if isempty(z)
    z = 0;
end
A ={'flag' flag;'coffi' coffi; 'da_F' T_optimal; 'qp_F' x; 'da_obj' z1; 'qp_obj' z; 'F_deri' x-T_optimal ;'obj_deri' z-z1};




