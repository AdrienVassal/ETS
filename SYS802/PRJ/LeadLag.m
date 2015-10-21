clear;close all;clc;
%%
% Définition du systeme
H1 = tf(-7817.5,[1 -30.5122]);
H2 = tf(1,[1 31.3407]);
H3 = tf(1,[1 184.378]);
H  = series(series(H1,H2),H3);

ka  = 139;
s1  = 50;
p1  = 0.5;
s2  = 156;
p2  = 138;
w2  = 3000;

J11 = tf([1/s1 1],[1/p1 1]);
J2  = tf([1/s2 1],[1/p2 1]);
J3  = tf(w2,[1 w2]);
J   = ka*series(J11,series(J2,J3));
figure;
nyquist(feedback(series(H,J),1));

%%

% Déphaseur ordre 1
H1 = tf([1 2],[1 4]);
figure;
bode(H1);
hold on;

% Déphaseur odre 2
H2 = tf([1 sqrt(2)*2 4],[1 sqrt(2)*4 16]);
bode(H2);

