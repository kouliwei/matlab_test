clc;
clear;
format long
% a = [4 40 30 45]';
% b = [3 30 45 35]';
% T1 = [70 -60 800 50]';
a = [4 40 30 45]';
b = [30 30 45 35]';
T1 = [70 -60 80 50]';
limit = [-a b] - [T1 T1]
[temp_lmax pos_l] = max(limit(:,1));
[temp_rmin pos_r] = min(limit(:,2));

Beta_all = zeros(4,2);
if temp_rmin < temp_lmax
    beta = (b(pos_r) + a(pos_l))/(T1(pos_r) - T1(pos_l));
    for i=1:4
        if abs(T1(pos_l) - T1(i)) < 1e-6
            Beta_all(i,1) = 0;
        else
            Beta_all(i,1) = (a(i) - a(pos_l))/(T1(pos_l) - T1(i));
            if Beta_all(i,1) <= 0 || Beta_all(i,1) >= 1
                Beta_all(i,1) = 0;
            end
        end

        if abs(T1(pos_r) - T1(i)) < 1e-6
            Beta_all(i,2) = 0;
        else
            Beta_all(i,2) = (b(i) - b(pos_r))/(T1(i) - T1(pos_r));
            if Beta_all(i,2) <= 0 || Beta_all(i,2) >= 1
                Beta_all(i,2) = 0;
            end
        end
    end
    Max_Beta_all = max(max(Beta_all));
    if beta >= Max_Beta_all
        disp('congratulation, find the beta');
        beta
    else
        [row_pos col_pos] = find(Beta_all == max(max(Beta_all)));
        if col_pos == 1
            
        else
        end
    end
    
    
end




