clear all; close; clc;
warning ('off','all');
%% A

%G1
b1 = [5];
a1 = [1 -1 -2];
[r1, p1, k1] = residue(b1,a1);

%G2
b2 = [2 14 3];
a2 = [1 5 4];
[r2, p2, k2] = residue(b2,a2);

%G3
b3 = [2 10 26];
a3 = [1 4 13];
[r3, p3, k3] = residue(b3,a3);

%G4

b4 = [5];
a4 = [1 5.3 6.3 0 0];
[r4, p4, k4] = residue(b4,a4);

%G5
b5 = [10];
a5 = [1 5 -100 -500];
[r5, p5, k5] = residue(b5,a5);

% G6 avec syms
% syms a b c alpha;
% b6 = [1 alpha];
% a6 = [1 a+b+c a*b+b*c+a*c a*b*c];
% [r6, p6, k6] residue(b6,a6);

%% B

syms s a b c alpha
g1=ilaplace(5/(s^2-s-2));
g2=ilaplace((2*s^2+14*s+3)/(s^2+5*s+4));
g3=ilaplace((2*s^2+10*s+26)/(s^3+4*s^2+13*s));
g4=ilaplace((5)/(s^4+5.3*s^3+6.3*s^2));
g5=ilaplace((10)/(s^3+5*s^2-100*s-500));
g6=ilaplace((s+ alpha )/((s+a)*(s+b)*(s+c)));


G1 = tf([5],[1 -1 -2]);
G2 = tf([2 14 3],[1 5 4]);
G3 = tf([2 10 26],[1 4 13 0]);
G4 = tf([5],[1 0 0])*tf([1],[1 3.5])*tf([1],[1 1.8]);
G5 = tf([10],[1 5])*tf([1],[1 10])*tf([1],[1 -10]);
syms s a b c alpha
G6 = (s+alpha)/(s^3+s^2*(a+b+c)+s*(a*b+b*c+c*a)+a*b*c);

%% C

Te = 0.1;
z = tf('z',Te);
Z11 = 5/3*(z/(z-exp(2*Te))-z/(z-exp(-Te)));
Z21 = 2+7*z/(z-exp(-4*Te))-3*z/(z-exp(-Te));
Z31 = z/(z-1)-1i/3*(z/(z-exp((-2+3*1i)*Te))-z/(z-exp(((-2-3*1i)*Te))));
Z41 = (5/12.6-5/93.7125-5/48.0816)*z/(z-1)+5/6.3*z/(z-1)^2-5/20.825*z/(z-exp(-3.5*Te))+5/17.172*z/(z-exp(-1.8*Te));
Z51 = -0.1333*z/(z-exp(-5*Te))+0.0333*z/(z-exp(10*Te))+0.1*z/(z-exp(-10*Te));

Te = 0.05;
z = tf('z',Te);
Z12 = 5/3*(z/(z-exp(2*Te))-z/(z-exp(-Te)));
Z22 = 2+7*z/(z-exp(-4*Te))-3*z/(z-exp(-Te));
Z32 = z/(z-1)-1i/3*(z/(z-exp((-2+3*1i)*Te))-z/(z-exp(((-2-3*1i)*Te))));
Z42 = 0.6677*z/(z-1)+0.7937*z/(z-1)^2-0.2401*z/(z-exp(-3.5*Te));
Z52 = -0.1333*z/(z-exp(-5*Te))+0.0333*z/(z-exp(10*Te))+0.1*z/(z-exp(-10*Te));

Te = 0.01;
z = tf('z',Te);
Z13 = 5/3*(z/(z-exp(2*Te))-z/(z-exp(-Te)));
Z23 = 2+7*z/(z-exp(-4*Te))-3*z/(z-exp(-Te));
Z33 = z/(z-1)-1i/3*(z/(z-exp((-2+3*1i)*Te))-z/(z-exp(((-2-3*1i)*Te))));
Z43 = 0.6677*z/(z-1)+0.7937*z/(z-1)^2-0.2401*z/(z-exp(-3.5*Te));
Z53 = -0.1333*z/(z-exp(-5*Te))+0.0333*z/(z-exp(10*Te))+0.1*z/(z-exp(-10*Te));
%% D

%
% j'ai utilisé la notation Zijk avec i l'indice de la fonction,
%                                    k le temps d'échantillonage
%                                    j la méthode utilisée
%

Te = [0.1 0.05 0.01];

%Nous definissons Forward
syms ('z' , 's')
s = [(z-1)/Te(1) (z-1)/Te(2) (z-1)/Te(3)] ;
s2 = [(z-1)/Te(1)/z (z-1)/Te(2)/z (z-1)/Te(3)/z] ;

%% G1

%G1(Z) pour la méthode Forward pour les 3 Te
z111 = simplifyFraction(5/(s(1)^2-s(1)-2));
z111 = tf([5],[100 -210 108],Te(1));

z121 = simplifyFraction(5/(s(2)^2-s(2)-2));
z121 = tf([5],[400 -820 418],Te(2));

z131 = simplifyFraction(5/(s(3)^2-s(3)-2));
z131 = tf([5],[10000 -20100 10098],Te(3));

%G1(Z) pour la méthode Backward pour les 3 Te
z112 = simplifyFraction(5/(s2(1)^2-s2(1)-2));
z112 = tf([5 0 0],[88 -190 100],Te(1));

z122 = simplifyFraction(5/(s2(2)^2-s2(2)-2));
z122 = tf([5 0 0],[2*189 -2*390 400],Te(2));

z132 = simplifyFraction(5/(s2(3)^2-s2(3)-2));
z132 = tf([5 0 0],[2*4949 -9950*2 10000],Te(3));

%G1(Z) pour les 3 Te avec Tustin
z113 = c2d(G1,Te(1),'tustin');
z123 = c2d(G1,Te(2),'tustin');
z133 = c2d(G1,Te(3),'tustin');

%% G2

%G2(Z) pour la méthode Forward pour les 3 Te
z211 = simplifyFraction((2*s(1)^2+14*s(1)+3)/(s(1)^2+5*s(1)+4));
z211 = tf([200 -260 63],[100 -150 54],Te(1));

z221 = simplifyFraction((2*s(2)^2+14*s(2)+3)/(s(2)^2+5*s(2)+4));
z221 = tf([800 -1320 523],[400 -700 304],Te(2));

z231 = simplifyFraction((2*s(3)^2+14*s(3)+3)/(s(3)^2+5*s(3)+4));
z231 = tf([20000 -38600 18603],[10000 -19500 9504],Te(3));

%G2(Z) pour la méthode Backward pour les 3 Te
z212 = simplifyFraction((2*s2(1)^2+14*s2(1)+3)/(s2(1)^2+5*s2(1)+4));
z212 = tf([343 -540 200],[144 -250 100],Te(1));

z222 = simplifyFraction((2*s2(2)^2+14*s2(2)+3)/(s2(2)^2+5*s2(2)+4));
z222 = tf([1083 -1880 800],[4*126 -900 400],Te(2));

z232 = simplifyFraction((2*s2(3)^2+14*s2(3)+3)/(s2(3)^2+5*s2(3)+4));
z232 = tf([21403 -41400 20000],[4*2626 -4*5125 4*2500],Te(3));


%G2(Z) pour les 3 Te avec Tustin
z213 = c2d(G2,Te(1),'tustin');
z223 = c2d(G2,Te(2),'tustin');
z233 = c2d(G2,Te(3),'tustin');

%% G3
%G3(Z) pour la méthode Forward pour les 3 Te
z311 = simplifyFraction((2*s(1)^2+10*s(1)+26)/(s(1)^3+4*s(1)^2+13*s(1)));
z311 = tf([100 -150 63],[5*100 -5*260 5*233 -5*73],Te(1));

z321 = simplifyFraction((2*s(2)^2+10*s(2)+26)/(s(2)^3+4*s(2)^2+13*s(2)));
z321 = tf([400 -700 313],[10*400 -10*1120 10*1053 -10*333],Te(2));

z331 = simplifyFraction((2*s(3)^2+10*s(3)+26)/(s(3)^3+4*s(3)^2+13*s(3)));
z331 = tf([10000 -19500 9513],[50*10000 -50*29600 50*29213 -50*9613],Te(3));

%G3(Z) pour la méthode Backward pour les 3 Te
z312 = simplifyFraction((2*s2(1)^2+10*s2(1)+26)/(s2(1)^3+4*s2(1)+13*s2(1)));
z312 = series(tf([1 0],[1 -1],Te(1)),tf([163 -250 100],[5*117 -5*200 5*100],Te(1)));

z322 = simplifyFraction((2*s2(2)^2+10*s2(2)+26)/(s2(2)^3+4*s2(2)+13*s2(2)));
z322 = series(tf([1 0],[1 -1],Te(2)),tf([513 -900 400],[10*417 -10*800 10*400],Te(2)));

z332 = simplifyFraction((2*s2(3)^2+10*s2(3)+26)/(s2(3)^3+4*s2(3)+13*s2(3)));
z332 = series(tf([1 0],[1 -1],Te(3)),tf([10513 -20500 10000],[50*10017 -50*20000 50*10000],Te(3)));

%G3(Z) pour les 3 Te avec Tustin
z313 = c2d(G3,Te(1),'tustin');
z323 = c2d(G3,Te(2),'tustin');
z333 = c2d(G3,Te(3),'tustin');

%% G4

%G4(Z) pour la méthode Forward pour les 3 Te
z411 = simplifyFraction(5/(s(1)^4+5.3*s(1)^3+6.3*s(1)^2));
z411 = tf([1],[2000 -6940 8946 -5072 1066],Te(1));

z421 = simplifyFraction(5/(s(2)^4+5.3*s(2)^3+6.3*s(2)^2));
z421 = tf([1],[32000 -119520 167064 -103568 24024],Te(2));

z431 = simplifyFraction(5/(s(3)^4+5.3*s(3)^3+6.3*s(3)^2));
z431 = tf([1],[200*100000 -200*394700 200*584163 -200*384226 200*94763],Te(3));

%G4(Z) pour la méthode Backward pour les 3 Te
z412 = simplifyFraction(5/(s2(1)^4+5.3*s2(1)^3+6.3*s2(1)^2));
z412 = tf([1 0 0 0],[1593 -2530 1000],Te(1))*tf([1],[2 -4 2],Te(1));

z422 = simplifyFraction(5/(s2(2)^4+5.3*s2(2)^3+6.3*s2(2)^2));
z422 = tf([1 0 0 0],[5123 -9060 4000],Te(2))*tf([1],[8 -16 8],Te(2));

z432 = simplifyFraction(5/(s2(3)^4+5.3*s2(3)^3+6.3*s2(3)^2));
z432 = tf([1 0 0 0],[105363 -205300 100000],Te(3))*tf([1],[200 -400 200],Te(3));

%G4(Z) pour les 3 Te avec Tustin
z413 = c2d(G4,Te(1),'tustin');
z423 = c2d(G4,Te(2),'tustin');
z433 = c2d(G4,Te(3),'tustin');

%% G5

%G5(Z) pour la méthode Forward pour les 3 Te
z511 = simplifyFraction((10)/(s(1)^3+5*s(1)^2-100*s(1)-500));
z511 = tf([1],50*[2 -5 2 0],Te(1));

z521 = simplifyFraction((10)/(s(2)^3+5*s(2)^2-100*s(2)-500));
z521 = tf([1],50*[16 -44 36 -9],Te(2));

z531 = simplifyFraction((10)/(s(3)^3+5*s(3)^2-100*s(3)-500));
z531 = tf([1],50*[2000 -5900 5780 -1881],Te(3));

%G5(Z) pour la méthode Backward pour les 3 Te
z512 = simplifyFraction((10)/(s2(1)^3+5*s2(1)^2-100*s2(1)-500));
z512 = tf([1 0 0],[300 -350 100],Te(1));

z522 = simplifyFraction((10)/(s2(2)^3+5*s2(2)^2-100*s2(2)-500));
z522 = tf([1 0 0],[50*15 -50*52 50*52 -50*16],Te(2));

z532 = simplifyFraction((10)/(s2(3)^3+5*s2(3)^2-100*s2(3)-500));
z532 = tf([1 0 0],[50*2079-50*6180 50*6100 -50*2000],Te(3));

%G5(Z) pour les 3 Te avec Tustin
z513 = c2d(G5,Te(1),'tustin');
z523 = c2d(G5,Te(2),'tustin');
z533 = c2d(G5,Te(3),'tustin');



%% step G1
Tfinal = 3;

figure(1);
subplot(3,1,1);
step(G1,Z11*Te(1),z111,z112,z113,Tfinal);
title('G1 et Te = 0.1');
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,2);
step(G1,Z12*Te(2),z121,z122,z123,Tfinal);
title('G1 et Te = 0.05');
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,3);
step(G1,Z13*Te(3),z131,z132,z133,Tfinal);
title('G1 et Te = 0.01');
legend('Continuous','Math','Forward','Backward','Tustin');
%% step G2
Tfinal = 7;
figure(2)
subplot(3,1,1)
step(G2,2+Te(1)*(Z21-2),z211,z212,z213,Tfinal)
title('G2 et Te = 0.1')
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,2)
step(G2,2+Te(2)*(Z22-1),z221,z222,z223,Tfinal)
title('G2 et Te = 0.05')
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,3)
step(G2,2+Te(3)*(Z23-1),z231,z232,z233,Tfinal)
title('G2 et Te = 0.01')
legend('Continuous','Math','Forward','Backward','Tustin');

%% step G3
figure(3)
subplot(3,1,1);
step(G3,Z31*Te(1)*2,z311,z312,z313,Tfinal);
title('G3 et Te = 0.1');
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,2);
step(G3,Z32*Te(2)*2,z321,z322,z323,Tfinal);
title('G3 et Te = 0.05');
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,3);
step(G3,Z33*Te(3)*2,z331,z332,z333,Tfinal);
title('G3 et Te = 0.01');
legend('Continuous','Math','Forward','Backward','Tustin');

%% step G4
Tfinal = 100;
figure(4)   
subplot(3,1,1)
step(G4,Z41*Te(1)^2,z411,z412,z413,Tfinal)
title('G4 et Te = 0.1')
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,2)
step(G4,Z42*Te(2)^2,z421,z422,z423,Tfinal)
title('G4 et Te = 0.05')
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,3)
step(G4,Z43*Te(3)^2,z431,z432,z433,Tfinal)
title('G4 et Te = 0.01')
legend('Continuous','Math','Forward','Backward','Tustin');

%% step G5
Tfinal = 10;
figure(5);   
subplot(3,1,1);
step(G5,Z51*Te(1),z511,z512,z513,Tfinal);
title('G5 et Te = 0.1');
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,2)
step(G5,Z52*Te(2),z521,z522,z523,Tfinal);
title('G5 et Te = 0.05');
legend('Continuous','Math','Forward','Backward','Tustin');

subplot(3,1,3)
step(G5,Z53*Te(3),z531,z532,z533,Tfinal);
title('G5 et Te = 0.01');
legend('Continuous','Math','Forward','Backward','Tustin');
