clc;
format long
ca = cos(pi/6);
sa = sin(pi/6);
y0 = 0.2;
B = [ca -ca ca -ca;sa sa sa sa; -sa*y0 sa*y0 sa*y0 -sa*y0];
B_Pinv  = pinv(B);
B_Null = eye(4)-B_Pinv*B
T = [10 20 5]';
%% matlab toolbox computation
H =[1 0 0 0;0 1 0 0;0 0 1 0; 0 0 0 1];
lb= [-40;-40;-40;-40];
ub=[40;40;40;40];
B = [ca -ca ca -ca;sa sa sa sa; -sa*y0 sa*y0 sa*y0 -sa*y0];
bx = T;
f=[];

QP_timeall = [];
QP_timesum = 0;
QP_obj = [];
QP_Terr = [];
MDA_timeall = [];
MDA_timesum = 0;
MDA_obj = [];
MDA_Terr = [];
Tu = [];
Tw = [];
Tr = [];
flag_all = [];



for i=1:1000
    %  T = [10 + 5*rand(1);45 + 2*rand(1);5 + 1*rand(1)];
    %  T = [10 + 5*rand(1);20 + 2*rand(1);5 + 1*rand(1)];
    T = [10 + 5*rand(1);20+ 2*rand(1);5 + 1*rand(1)];
    Tu = [Tu T(1)];
    Tw = [Tw T(2)];
    Tr = [Tr T(3)];
    %% quadratic program algorithm
    tic
    bx = T;
    [x,z]=quadprog(H,f,[],[],B,bx,lb,ub);
    QP_timeall = [QP_timeall toc];   % time computation
    QP_timesum = QP_timesum + toc;
    if isempty(z)
        z = 0;
    end
    QP_obj = [QP_obj z];            % objective value computation
    if isempty(x)
        x = [0;0;0;0];
    end
    QP_Terr = [QP_Terr B*x - T];      % force derivation computation
    
    %% my algorithm (based on direct allocation algorithm)
    
    tic
    T1 = B_Pinv*T;
    T1_Temp = [T1(1);T1(2);-T1(3);-T1(4)];

    limit = [-40 40;-40 40;-40 40;-40 40] - [T1_Temp T1_Temp];
    [Left_MaxValue pos1] = max(limit(:,1));
    [Right_MinValue pos2] = min(limit(:,2));

    flag = 0;
    coffi = 1;
    if Right_MinValue >= Left_MaxValue   %% exist the solution 
        if Right_MinValue * Left_MaxValue <=0
            temp = 0;
            flag = 1;
        else
            if Right_MinValue < 0 
                temp = Right_MinValue;
                flag = 2;
            else
                temp = Left_MaxValue;
                flag = 3;
            end
        end
    else                                % exist no solution 
        coffi = 80/(T1_Temp(pos2) - T1_Temp(pos1))
        flag = 4;
        temp = -40 - coffi*T1_Temp(pos1);
    end
    T_optimal = coffi*T1 + [1;1;-1;-1]*temp;
    z1 = norm(T_optimal)^2/2;
    MDA_timeall = [MDA_timeall toc];
    MDA_timesum = MDA_timesum + toc;
    MDA_obj = [MDA_obj z1];           % objective value computation
    MDA_Terr = [MDA_Terr B*T_optimal - T];      % force derivation computation
    flag_all = [flag_all flag];
end
size(find(flag_all == 3));



