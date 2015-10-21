clear;close all;clc;
%%
% Définition du systeme
H     = tf([0 10],[1 10]);
Te    = 0.001;

% Transformé en Z
Hz      = tf([10 0],[1 -exp((-10*Te))],Te);
Hz_corr = tf([1-exp(-10*Te) 0],[1 -exp(-10*Te)],Te);

% Affichage
figure;
subplot(2,1,1);
impulse(H,Hz,Hz_corr);
title('Réponse imulptionnelle du système');
legend('Continue', 'Tz', 'Tz avec gain corrigé');

subplot(2,1,2);
step(H,Hz,Hz_corr);
title('Réponse à un échellon unitaire du système');
legend('Continue', 'Tz', 'Tz avec gain corrigé');