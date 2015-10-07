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
% D�finition du syst�me
P1 = series(Ka*tf([0 1],[1 s2]),tf([0 1],[1 s3]));
P2 = tf([0 1],[1 s1]);
P  = series(P1,P2);
% D�finition du gain k1
k1 = 2;
% D�finition du correcteur H
c  = 1;
s0 = 1;
q  = 1;
H  = c*P1;
for i = 1 : q
    H = series(H,tf([0 1],[1 s0]));
end
% D�finition du correcteur J1
w1 = 1;
J1 = tf([0 w1],[1 w1]);
% D�finition du correcteur J2
z  = [1 1];
p  = [1 1];
J2 = 1;
for i = 1 : 2
    J2 = series(J2,tf([1 z(i)],[1 p(i)]));
end
% D�finition du correcteur J3
k  = 1;
w2 = 1;
J3 = 1;
for i = 1:k
    J3 = series(J3,tf([0 w2],[1 w2]));
end
% D�finition du correcteur total
C = series(series(series(k1*H, J1),J2),J3);
% D�finition de la boucle ouverte
J = series(C,P);
% Affichage des performances temporelles du correcteur
step(C);
% Affichage des performances frequentielles de la boucle ouverte

figure(1);
grid on;
margin(J);
figure(2);
grid on;
nyquist(J);
figure(3);
grid on;
nichols(J);
