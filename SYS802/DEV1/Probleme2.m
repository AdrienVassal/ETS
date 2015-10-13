clear;close;clc;
%% Problème 2

%-------------------------------------------------------------------------%
% a) Définition de la fonction de transfert
%-------------------------------------------------------------------------%
H  = tf([0 10],[1 10]);
Te = [0.1 0.05 0.01]; 
%-------------------------------------------------------------------------%
% b) Backward
%-------------------------------------------------------------------------%
syms('s','z');
s           = (z-1)/(z*Te(1));
simplifyFraction(10/(10+s));
Hbw1        = tf([1 0],[2 -1],Te(1));

s           = (z-1)/(z*Te(2));
simplifyFraction(10/(10+s));
Hbw2        = tf([1 0],[3 -2],Te(2));

s           = (z-1)/(z*Te(3));
simplifyFraction(10/(10+s));
Hbw3        = tf([1 0],[11 -10],Te(3));
%-------------------------------------------------------------------------%
% c) Forward
%-------------------------------------------------------------------------%
Hfw1 = c2d(H,Te(1),'zoh');
Hfw2 = c2d(H,Te(2),'zoh');
Hfw3 = c2d(H,Te(3),'zoh');
%-------------------------------------------------------------------------%
% d) Tustin
%-------------------------------------------------------------------------%
Htu1 = c2d(H,Te(1),'tustin');
Htu2 = c2d(H,Te(2),'tustin');
Htu3 = c2d(H,Te(3),'tustin');

%-------------------------------------------------------------------------%
% d) Mathématique
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% Time response
%-------------------------------------------------------------------------%

figure;
subplot(2,2,1);
step(H,Hbw1,Hbw2,Hbw3);
title('Step response for backward discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');


subplot(2,2,2);
step(H,Hfw1,Hfw2,Hfw3);
title('Step response for forward discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');


subplot(2,2,3);
step(H,Htu1,Htu2,Htu3);
title('Step response for Tustin discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');

%-------------------------------------------------------------------------%
% Frequency response
%-------------------------------------------------------------------------%

figure;

subplot(2,2,1);
bode(H,Hbw1,Hbw2,Hbw3);
title('Bode response for backward discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');


subplot(2,2,2);
bode(H,Hfw1,Hfw2,Hfw3);
title('Bode response for forward discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');


subplot(2,2,3);
bode(H,Htu1,Htu2,Htu3);
title('Bode response for Tustin discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');