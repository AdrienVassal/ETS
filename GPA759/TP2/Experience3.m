clear;clc;close all
%% Param�tres
patchSize = 3;
step = 8;
minDist = 0.8;
eta = 0.05;
nEpoch = 50000;

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
[MLP, MSE, Y, Yv] = TrainingExp3( MLP, X, D, Xval, Dval, eta, nEpoch, 0, 0 );

hold on
for(i=1:2)
    plot(MSE(i,:));
end
legend('MSE base entrainement','MSE base test' );
title('Evolution du MSE entre les bases test et entrainement');



%% Utiliser le r�seau

fileName = 'roo';

mX = dlmread(['images/Test/' fileName '.mx']);
figure
imshow(mX)
title('image originale')

mD = dlmread(['images/Test/' fileName '.md']);
figure
imshow(mD)
title('image d�sir�e')

mY = extraireContourMLP(mX,MLP,patchSize);
figure
imshow(mY)
title('image � la sortie du MLP')

figure
imshow(mY>0.5)
title('image de sortie seuill�e')

