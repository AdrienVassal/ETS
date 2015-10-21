clear;clc;close all
%% Paramètres
patchSize   = 3;
step        = 8;
minDist     = 0.8;
eta         = 0.05;
nEpoch      = 10000;
%% Création des bases de données
[X,D]       = ExtractData('images\Training\',patchSize,step,minDist);
batchSize   = size(X,2); 
[Xval,Dval] = ExtractData('images\Validation\',patchSize,step,0);
%% Création du réseau de neurones
MLP = myMLP;
MLP = MLP.initialisation(9,5,1);
%% Entrainement du réseau

% Entrainer pour nEpoch
[MLP, MSE, Y, MLPgood] = TrainingExp4( MLP, X, D, Xval, Dval, eta, nEpoch, 1, 0);

%Afficher le MSE pour les bases entrainnement et validations
hold on
for(i=1:2)
    plot(MSE(i,:),'LineWidth',2);
end
legend('MSE base entrainement','MSE base validation');
title('Evolution du MSE entre les bases validation et entrainement');


%% Utiliser les réseaux sur la base Test

fileName = 'roo';
figure
subplot(2,3,1)
mX = dlmread(['images/Test/' fileName '.mx']);
imshow(mX)
title('image originale')

subplot(2,3,4)
mD = dlmread(['images/Test/' fileName '.md']);
imshow(mD)
title('image désirée')

%Modèle surentrainné
subplot(2,3,2)
mY_SE = extraireContourMLP(mX,MLP,patchSize);
imshow(mY_SE)
title('image à la sortie du MLP surentrainné')

subplot(2,3,5)
imshow(mY_SE>0.5)
title('image de sortie seuillée surentrainné')

%Modèle correctement entrainné
mY = extraireContourMLP(mX,MLPgood,patchSize);
subplot(2,3,3)
imshow(mY)
title('image à la sortie du MLP correctement entrainné')

subplot(2,3,6)
imshow(mY>0.5)
title('image de sortie seuillée correctement entrainné')

%% Calcul des erreurs de classifications

id = size(mY);
err = 0;
err_SE = 0;
for i = 1:id(1)
    for j = 1:id(2)
        if (mY(i,j)>0.5) ~= (mD(i,j)>0.5)
            err = err +1;            
        end
        if (mY_SE(i,j)>0.5) ~= (mD(i,j)>0.5)
            err_SE = err_SE +1;            
        end
    end
end
disp('Nombre d erreur de classification pour le réseau correctement entrainé :')
err
disp('Nombre d erreur de classification pour le réseau sur-entrainé :')
err_SE