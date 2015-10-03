clear all;clc;close all
%% Param�tres
patchSize = 3;
step = 8;
minDist = 0.8;
eta = 0.05;
nEpoch = 20000;

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
%% train
MSE = [];   % vecteur contenant l'erreur quadratique pour chaque iteration

% Entrainer pour nEpoch
for ep = 1:nEpoch
    
     % cr�er un vecteur d'index al�atoirement (pas n�cessaire en batch learning)
    idx = randperm(size(X,1));
    
    % matrices contenant la somme de tous les ajustements pour les poids
    % de la couche cach�e et de sortie
    adjW_s = 0;
    adjW_c = 0;
    
    % pour chaque donn�e de la base X
    for i = 1:length(idx)
        
         % obtenir les ajustement pour une donn�e par r�tropropagation
        [tmps,tmpc] = MLP.retroPropagation(X(idx(i),:),D(idx(i)),eta);
        
       % ajouter aux ajustements existants
        adjW_s = adjW_s + tmps;
        adjW_c = adjW_c + tmpc;
        
    end
    
    % Mettre � jour le r�seau
    MLP.W_c = MLP.W_c + adjW_c;
    MLP.W_s = MLP.W_s + adjW_s;
    
    %% Montrer les resultats
    
    % classifier toutes les donn�es
    [Y] = MLP.propagation(X); 
    % Calculer l'erreur quadratique moyenne et l'ajouter au vecteur
    new_MSE = sum(((D-Y).^2))/size(X,1);
    MSE = [MSE new_MSE];
    
    % afficher l'�tat du r�seau
    if mod(ep,100) == 0
        figure(46546)
        plot(MSE(3:end))
        drawnow
    end
    
end

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

