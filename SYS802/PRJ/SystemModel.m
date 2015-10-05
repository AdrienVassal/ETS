clear; close all; clc
%%
% Point de fonctionnement 1
Ka = -7817.5;
s1 = -30.5122;
s2 = 31.3407;
s3 = 184.378;
% Point de fonctionnement 2
% Ka = -8515.2;
% s1 = -30.5122;
% s2 = 31.3407;
% s3 = 184.378;
% Définition du système
P1 = series(Ka*tf([0 1],[1 s2]),tf([0 1],[1 s3]));
P2 = tf([0 1],[1 s1]);
P  = series(P1,P2);
% Définition du gain k1
k1 = 2;
% Définition du correcteur H
c  = 1;
s0 = 1;
q  = 1;
H  = c*P1;
for i = 1 : q
    H = series(H,tf([0 1],[1 s0]));
end
% Définition du correcteur J1
w1 = 1;
J1 = tf([0 w1],[1 w1]);
% Définition du correcteur J2
z  = [1 1];
p  = [1 1];
J2 = 1;
for i = 1 : 2
    J2 = series(J2,tf([1 z(i)],[1 p(i)]));
end
% Définition du correcteur J3
k  = 1;
w2 = 1;
J3 = 1;
for i = 1:k
    J3 = series(J3,tf([0 w2],[1 w2]));
end
% Définition du correcteur total
C = series(series(series(k1*H, J1),J2),J3);
% Définition de la boucle ouverte
J = series(C,P);