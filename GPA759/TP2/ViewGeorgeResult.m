function ViewGeorgeResult(MLP, patchSize)
%VIEWGEORGERESULT : Affiche l'image de notre carismatique George
% 


fileName = 'Bukakke';

mX = dlmread(['images/George/' fileName '.mx']);
figure;
subplot(1,2,1);
imshow(mX);
title('image originale');

mD = dlmread(['images/George/' fileName '.md']);
subplot(1,2,2);
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