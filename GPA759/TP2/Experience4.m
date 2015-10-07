clear;clc;close all
%% Param�tres
patchSize = 3;
step = 8;
minDist = 0.8;
eta = 0.05;
nEpoch = 10000;

%% Cr�ation des bases de donn�es
extraireVecteursdesImages('images\Training\',patchSize,step)
extraireVecteursdesImages('images\Validation\',patchSize,step)
extraireVecteursdesImages('images\Test\',patchSize,step)
[X,D] = selectionDesExemples('images\Training\', minDist);
[Xval,Dval] = selectionDesExemples('images\Validation\', 0);

%% Cr�ation du r�seau de neurones
MLP = myMLP;
MLP = MLP.initialisation(9,5,1);

%% Entrainement du r�seau

MSE = [];   % vecteur contenant l'erreur quadratique pour chaque iteration

% Entrainer pour nEpoch
[MLP, MSE, Y, MLPgood] = TrainingExp4( MLP, X, D, eta, nEpoch, 0, 0 );



%% Utiliser les r�seaux 

fileName = 'roo';

mX = dlmread(['images/Test/' fileName '.mx']);
figure
imshow(mX)
title('image originale')

mD = dlmread(['images/Test/' fileName '.md']);
figure
imshow(mD)
title('image d�sir�e')

%Mod�le surentrainn�
mY = extraireContourMLP(mX,MLP,patchSize);
figure
imshow(mY)
title('image � la sortie du MLP SE')

figure
imshow(mY>0.5)
title('image de sortie seuill�e SE')

%Mod�le correctement entrainn�
mY = extraireContourMLP(mX,MLPgood,patchSize);
figure
imshow(mY)
title('image � la sortie du MLP CE')

figure
imshow(mY>0.5)
title('image de sortie seuill�e CE')

