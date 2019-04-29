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
flag = 0;  % to judge whether beta is max or not
pos_lmatrix = [];   
pos_rmatrix = [];
if value_rmin >= value_lmax
    disp('gammma belongs to Omege');
else
    while(1)
        flag = 0;
        beta = (b(pos_r) + a(pos_l))/(T(pos_r) - T(pos_l))
        Limit = [-a b]-beta*[T T]
        if pos_l_last ~= pos_l
            pos_l_last = pos_l;
            pos_lmatrix = [pos_lmatrix pos_l];
        end
        if pos_r_last ~= pos_r
            pos_r_last = pos_r;
            pos_rmatrix = [pos_rmatrix pos_r];
        end
        
        for j=1:4
            if ismember(j,pos_lmatrix) == 0
                if -a(j) - beta*T(j) > -a(pos_l) - beta*T(pos_l) % check which row value is more than origin value
                    pos_l_last = pos_l;
                    pos_l = j;
                    flag = 1;
                    break;
                end
            end
        end
        
        for k=1:4
            if  ismember(k,pos_rmatrix) == 0
                if b(k) - beta*T(k) < b(pos_r) - beta*T(pos_r)
                    pos_r_last = pos_r;
                    pos_r = k;
                    flag = 1;
                    break;
                end
            end
        end
        
        if flag == 0
            break;
        end
    end   
end
