function ViewNetworkResult(MLP, patchSize)
%VIEWNETWORKRESULT : affiche les résultats obtenues avec le réseau.
%Quatres images sont affichées, l'image originale, l'image désirée, l'image
%à la sortie du MLP et la sortie seuillée
%
% ViewNetworkResult (MLP, patchSize)
%
%   MLP       : objet contenant le réseau MPL dans son état final
%   patchSize : taille des imagettes utilisées

fileName = 'roo';

mX = dlmread(['images/Test/' fileName '.mx']);
figure;
imshow(mX);
title('image originale');

mD = dlmread(['images/Test/' fileName '.md']);
figure;
imshow(mD);
title('image désirée');

figure
for i = 1 : size(MLP,1)
    h = subplot(size(MLP,1),2,2*i-1);
    mY = extraireContourMLP(mX,MLP(i),patchSize);
    imshow(mY, 'Parent', h);
    title(['image à la sortie du MLP ' num2str(i)]);
    
    h = subplot(size(MLP,1),2,2*i);
    imshow(mY>0.5, 'Parent', h);
    title(['image de sortie seuillée' num2str(i)]);
end




end