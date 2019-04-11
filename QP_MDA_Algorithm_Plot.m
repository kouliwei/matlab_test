clc;
i=1:1000;

figure
plot(i,Tu,'r');
hold on;
plot(i,Tw,'b-');
hold on;
plot(i,Tr,'g*');
legend('Tu','Tw','Tr');
grid on;
title('Desired moments in the direction of surge, heave, and yaw');

figure
plot(i,QP_timeall,'r');
hold on;
plot(i,MDA_timeall,'b-');
title('Computation time');
legend('QP ','MDA');
grid on;
axis([0 1000 -0.001 0.05]);

figure
plot(i,QP_Terr(1,:),'r');
hold on;
plot(i,QP_Terr(2,:),'b');
hold on;
plot(i,QP_Terr(3,:),'g');
legend('Tu','Tw','Tr');
grid on;
%axis([0 1000 0 30]);
title('Moment derivation Using QP algorithm');

figure
plot(i,MDA_Terr(1,:),'r');
hold on;
plot(i,MDA_Terr(2,:),'b');
hold on;
plot(i,MDA_Terr(3,:),'g');
legend('Tu','Tw','Tr');
%axis([0 1000 0 30]);
grid on;
title('Moment derivation Using MDA algorithm');


figure
subplot(3,1,1);
plot(i,QP_obj);
grid on;
title('Objective value Using QP algorithm');
subplot(3,1,2);
plot(i, MDA_obj);
grid on;
title('Objective value Using MDA algorithm');
subplot(3,1,3);
plot(i,QP_obj - MDA_obj);
grid on;
title('Objective derivation');


figure
plot(i,flag_all);

