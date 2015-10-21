clear;close all;clc;
%%
% D�finition du systeme
H     = tf([0 10],[1 10]);
Te    = 0.001;

% Transform� en Z
Hz      = tf([10 0],[1 -exp((-10*Te))],Te);
Hz_corr = tf([1-exp(-10*Te) 0],[1 -exp(-10*Te)],Te);

% Affichage
figure;
subplot(2,1,1);
impulse(H,Hz,Hz_corr);
title('R�ponse imulptionnelle du syst�me');
legend('Continue', 'Tz', 'Tz avec gain corrig�');

subplot(2,1,2);
step(H,Hz,Hz_corr);
title('R�ponse � un �chellon unitaire du syst�me');
legend('Continue', 'Tz', 'Tz avec gain corrig�');