clc
clear;
format long
beta = 1;
a = [49 50 5 10]';
b = [30 40 3 20]';
T =[-20 40 8 50]';
Limit = [-a b]-[T T]
pos_l_last = 0;     % to judge whether pos_lmatrix should be updated
pos_r_last = 0;     % to judge whether pos_rmatrix should be updated
[value_lmax pos_l] = max(Limit(:,1));
[value_rmin pos_r] = min(Limit(:,2));
flag = 0;
flag1 = 0;
if value_rmin >= value_lmax
    disp('gammma belongs to Omege');
else
    for i=1:4
        for j=1:4
            flag = 0;
            if j ~= i
                beta = (b(j) + a(i))/(T(j) - T(i))
                i
                j
                if beta<=0 || beta >= 1
                    continue;
                else
                    
                    for i1=1:4
                        if i1 ~= i
                            if -a(i1) - beta*T(i1) > -a(i) - beta*T(i)
                                flag = 1;
                                break;
                            end
                        end
                    end
                    
                    for j1=1:4
                        if j1 ~= j
                            if b(j1) - beta*T(j1) < b(j) - beta*T(j)
                                flag = 1;
                                break;
                            end
                        end
                    end
                end
            else
                continue;
            end
            if flag == 0
                disp('find the maximum of beta');
                flag1 = 1;
            end
        end
        if flag1 == 1
            break;
        end
    end
end
