clear;clc;close all
%% Paramètres
patchSize = 3;
step = 8;
minDist = 0.8;
eta = 0.05;
nEpoch = 10000;

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
[MLP, MSE, Y, MLPgood] = TrainingExp4( MLP, X, D, eta, nEpoch, 0, 0 );



%% Utiliser les réseaux 

fileName = 'roo';

mX = dlmread(['images/Test/' fileName '.mx']);
figure
imshow(mX)
title('image originale')

mD = dlmread(['images/Test/' fileName '.md']);
figure
imshow(mD)
title('image désirée')

%Modèle surentrainné
mY = extraireContourMLP(mX,MLP,patchSize);
figure
imshow(mY)
title('image à la sortie du MLP SE')

figure
imshow(mY>0.5)
title('image de sortie seuillée SE')

%Modèle correctement entrainné
mY = extraireContourMLP(mX,MLPgood,patchSize);
figure
imshow(mY)
title('image à la sortie du MLP CE')

figure
imshow(mY>0.5)
title('image de sortie seuillée CE')

