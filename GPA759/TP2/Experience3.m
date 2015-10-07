clear;clc;close all
%% Paramètres
patchSize = 3;
step = 8;
minDist = 0.8;
eta = 0.05;
nEpoch = 50000;

%% Création des bases de données
extraireVecteursdesImages('images\Training\',patchSize,step)
extraireVecteursdesImages('images\Validation\',patchSize,step)
extraireVecteursdesImages('images\Test\',patchSize,step)
[X,D] = selectionDesExemples('images\Training\', minDist);
[Xval,Dval] = selectionDesExemples('images\Validation\', 0);

%% Création du réseau de neurones
MLP = myMLP;
MLP = MLP.initialisation(9,5,1);

%% Entrainement du réseau

MSE = [];   % vecteur contenant l'erreur quadratique pour chaque iteration

% Entrainer pour nEpoch
[MLP, MSE, Y, Yv] = TrainingExp3( MLP, X, D, Xval, Dval, eta, nEpoch, 0, 0 );

hold on
for(i=1:2)
    plot(MSE(i,:));
end
legend('MSE base entrainement','MSE base test' );
title('Evolution du MSE entre les bases test et entrainement');



%% Utiliser le réseau

fileName = 'roo';

mX = dlmread(['images/Test/' fileName '.mx']);
figure
imshow(mX)
title('image originale')

mD = dlmread(['images/Test/' fileName '.md']);
figure
imshow(mD)
title('image désirée')

mY = extraireContourMLP(mX,MLP,patchSize);
figure
imshow(mY)
title('image à la sortie du MLP')

figure
imshow(mY>0.5)
title('image de sortie seuillée')

