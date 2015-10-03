function mY = extraireContourMLP(mX,MLP,patchSize)
% mX: matrice contenant une image test
% MLP: un objet classificateur
% patchSize: dimension des imagettes utilisées


% créer un image de la même dimension que la matrice d'entrée mX
mY = zeros(size(mX));

hps = floor(patchSize/2); % taille de la moitié d'une imagette


for j = ceil(patchSize/2):1:size(mX,1)-ceil(patchSize/2)
    for k = ceil(patchSize/2):1:size(mX,2)-ceil(patchSize/2)
        
        % extraire un vecteur pour l'imagette centrée à [j,k]
        tmp = mX(j-hps:j+hps,k-hps:k+hps);
        tmp = tmp(:)';
        % prédire si le pixel au centre de l'imagette est un contour
        mY(j,k) = MLP.propagation(tmp);
    end
end

end
