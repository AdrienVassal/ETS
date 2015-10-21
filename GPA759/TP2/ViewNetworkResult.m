function ViewNetworkResult(MLP, patchSize)
%VIEWNETWORKRESULT : affiche les r�sultats obtenues avec le r�seau.
%Quatres images sont affich�es, l'image originale, l'image d�sir�e, l'image
%� la sortie du MLP et la sortie seuill�e
%
% ViewNetworkResult (MLP, patchSize)
%
%   MLP       : objet contenant le r�seau MPL dans son �tat final
%   patchSize : taille des imagettes utilis�es

fileName = 'roo';

mX = dlmread(['images/Test/' fileName '.mx']);
figure;
subplot(1,2,1);
imshow(mX);
title('image originale');

mD = dlmread(['images/Test/' fileName '.md']);
subplot(1,2,2);
imshow(mD);
title('image d�sir�e');

figure
for i = 1 : size(MLP,1)
    h = subplot(size(MLP,1),2,2*i-1);
    mY = extraireContourMLP(mX,MLP(i),patchSize);
    imshow(mY, 'Parent', h);
    title(['image � la sortie du MLP ' num2str(i)]);
    
    h = subplot(size(MLP,1),2,2*i);
    imshow(mY>0.5, 'Parent', h);
    title(['image de sortie seuill�e' num2str(i)]);
end

end