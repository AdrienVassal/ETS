clear; close all; clc;
warning ('off','all');

%% %d�finition du syst�me
a = 4;
b = 9;
P = tf([300],[1 0 -100])
C = tf([1 a],[1 b])
Hbf = minreal (P*C/(1+P*C))

%% Question B
%Processus P
figure(1)
bode(P)

figure(2)
nyquist(P)


%% Question E
Hbo = minreal(P*C)

figure(3)
bode(Hbo)

figure(4)
nyquist(Hbo)


%% Question F

warning ('off','all');
P = tf([300],[1 0 -100]);
a_min = 0;
b_min = 0;
a_max = 1000;
b_max = 1000;
a_inc = 10;
b_inc = 10;
a_best = 0;
b_best = 0;
Marge = zeros(1,4);
a = a_min;
b = b_min;


% Ajout du 1er d�phaseur
for b=b_min:b_inc:b_max
    for a=a_min:a_inc:a_max
        if a > b/3 && b>a
            C = tf([1 a],[1 b]);
            Hbo = P*C;
            [Gm, Pm, Wgm, Wpm] = margin(Hbo);
            %if   30 < Pm &&  6 < Gm && Pm <100
                if   Marge(2) < Pm
                    Marge = [Gm, Pm, Wgm, Wpm];
                    a_best = a;
                    b_best = b;
                end
            %end
        end
        
    end
end
disp('1er d�phaseur')
disp('On trouve a =')
a_best
disp('On trouve b =')
b_best
disp('Avec PM =')
Marge(2)
disp('et GM =')
Marge(1)

%en affinant on trouve a = 9.8 et b= 2.2
D1 = tf([1 9.8],[1 20.2]);


% Ajout du 2nd d�phaseur pour augmenter les marges
for b=b_min:b_inc:b_max
    for a=a_min:a_inc:a_max
        if a > b/3 && b>a
            C = tf([1 a],[1 b]);
            Hbo = P*D1*C;
            [Gm, Pm, Wgm, Wpm] = margin(Hbo);
            %if   30 < Pm &&  6 < Gm && Pm <100
                if   Marge(2) < Pm
                    Marge = [Gm, Pm, Wgm, Wpm];
                    a_best = a;
                    b_best = b;
                end
            %end
        end
        
    end
end
disp('Algo')
disp('On trouve a =')
a_best
disp('On trouve b =')
b_best
disp('Avec PM =')
Marge(2)
disp('et GM =')
Marge(1)

%en affinant on trouve a = 9.8 et b= 2.2
D2 = tf([1 9.8],[1 20.2]);


%% Question G

%d�finition du gain du d�phaseur
K =5;
D = K*D1*D2;
Hbo = D*P;

%affichage des marges
figure()
margin(Hbo)

%affichage du Nyquist
figure()
nyquist(Hbo)

%affichage de la r�ponse � un �chellon
Hbf = feedback(Hbo,1);
figure()
step(Hbf)
%T95 = 0.726s

%% Question H

Te
Dz = c2d(D,Te,'tustin')



