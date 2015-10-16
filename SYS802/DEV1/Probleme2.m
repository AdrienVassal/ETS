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
s           = (z-1)/(Te(1));
simplifyFraction(10/(10+s));
Hfw1        = tf([0 1],[1 0],Te(1));

s           = (z-1)/(Te(2));
simplifyFraction(10/(10+s));
Hfw2        = tf([0 1],[2 -1],Te(2));
    
s           = (z-1)/(Te(3));
simplifyFraction(10/(10+s));
Hfw3        = tf([0 1],[10 -9],Te(3));

%-------------------------------------------------------------------------%
% d) Tustin
%-------------------------------------------------------------------------%
Htu1 = c2d(H,Te(1),'tustin');
Htu2 = c2d(H,Te(2),'tustin');
Htu3 = c2d(H,Te(3),'tustin');
%-------------------------------------------------------------------------%
% d) Mathématique
%-------------------------------------------------------------------------%
Hmat1 = tf([1-exp(-10*Te(1)) 0],[1 -exp(-10*Te(1))],Te(1));
Hmat2 = tf([1-exp(-10*Te(2)) 0],[1 -exp(-10*Te(2))],Te(2));
Hmat3 = tf([1-exp(-10*Te(3)) 0],[1 -exp(-10*Te(3))],Te(3));
%-------------------------------------------------------------------------%
% Time response
%-------------------------------------------------------------------------%

figure;
subplot(2,2,1);
impulse(H,Hbw1,Hbw2,Hbw3);
title('impulse response for backward discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');


subplot(2,2,2);
impulse(H,Hfw1,Hfw2,Hfw3);
title('impulse response for forward discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');


subplot(2,2,3);
impulse(H,Htu1,Htu2,Htu3);
title('impulse response for Tustin discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');


subplot(2,2,4);
impulse(H,Hmat1,Hmat2,Hmat3);
title('impulse response for mathematical discretisation');
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

subplot(2,2,4);
bode(H,Htu1,Htu2,Htu3);
title('Bode response for mathematical discretisation');
legend('Continuous','Te = 0.1','Te = 0.05','Te = 0.01');