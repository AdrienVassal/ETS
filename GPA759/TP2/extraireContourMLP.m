function mY = extraireContourMLP(mX,MLP,patchSize)
% mX: matrice contenant une image test
% MLP: un objet classificateur
% patchSize: dimension des imagettes utilis�es


% cr�er un image de la m�me dimension que la matrice d'entr�e mX
mY = zeros(size(mX));

hps = floor(patchSize/2); % taille de la moiti� d'une imagette


for j = ceil(patchSize/2):1:size(mX,1)-ceil(patchSize/2)
    for k = ceil(patchSize/2):1:size(mX,2)-ceil(patchSize/2)
        
        % extraire un vecteur pour l'imagette centr�e � [j,k]
        tmp = mX(j-hps:j+hps,k-hps:k+hps);
        tmp = tmp(:)';
        % pr�dire si le pixel au centre de l'imagette est un contour
        mY(j,k) = MLP.propagation(tmp);
    end
end

end
