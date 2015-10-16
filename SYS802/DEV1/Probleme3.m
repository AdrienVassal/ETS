clear;close all;clc;
%% TO DO : faire un zoom sur le dépassement dans la dernière TF
% Retrancher 360° a la phase pour H(8)
% Titre de chacun des graphiques


H(1)   = tf([0 1],[1  1]);
H(2)   = tf([0 1],[1 -1]);
H(3)   = -H(1);
H(4)   = -H(2);

H(5)   = tf([1 1],[0 1]);
H(6)   = tf([1 -1],[0 1]);
H(7)   = -H(5);
H(8)   = -H(6);

H(9)   = tf([1 0],[0 1]);
H(10)  = tf([0 1],[1 0]);
H(11)  = -H(9);
H(12)  = -H(10);

H(13) = tf([0 0 1],[1 4   1]);
H(14) = tf([0 0 1],[1 2   1]);
H(15) = tf([0 0 1],[1 1.6 1]);
H(16) = tf([0 0 1],[1 1   1]);

figure;
for i=1:4
    subplot(2,2,i);
    bode(H(i));
end

figure;
for i=5:7
    subplot(2,2,i-4);
    bode(H(i));
end

% Cas -s+1 : il faut corriger la phase
[mag,phase,wout] = bode(H(8));
mag   = squeeze(mag);
phase = squeeze(phase)-360;
figure;
subplot(2,1,1);
semilogx(wout,mag);
title('Bode diagramme');
xlabel('w');
ylabel('mag');
subplot(2,1,2);
semilogx(wout,phase);
xlabel('w');
ylabel('phase');

figure;
for i=9:12
    subplot(2,2,i-8);
    bode(H(i));
end

figure;
for i=13:16
    subplot(2,2,i-12);
    bode(H(i));
end