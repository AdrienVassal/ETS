function [MLP, MSE, Y] = Training( MLP, X, D, eta, nEpoch, batchSize)
%TRAINING : entraine un réseau de neurones MLP, avec les data X, durant
%nEpoch époque selon le le type d'entrainement désiré.
%   Training(MLP, nbE, full, random)
%
%   MLP    : objet contenant le réseau MPL déjà initialisé
%   X      : Les données d'entrées set d'entrainement
%   D      : Les données de sorties du set d'entrainement
%   eta    : valeur de la constante d'apprentissage
%   nEpoch : Le nombre d'époque à réaliser
%   batchSize  : Taille des lots d'entrainement.
%   Si batchSize = 1, cela consiste à entrainer le réseau élément par
%   élément.
%   Si batchSize = size(X,1), cela consiste à entrainer le réseau sur tout
%   le set de data X
%
%   NB : toutes les données sont mélangées quelque soit la taille des lots

% Initialisation du vecteur de l'erreur quadratique moyenne
MSE            = zeros(1,nEpoch);
[X, D, Xr, Dr] = CreateBatch(X,D,batchSize);

for ep = 1:nEpoch
    % Initialisation
    % Rétropropagation par exemple
    for i = 1:floor(size(X,1)/batchSize)
        % obtenir les ajustement pour une donnée par rétropropagation
        [adjW_s,adjW_c] = MLP.retroPropagation(X((i-1)*batchSize+1:i*batchSize,:),...
            D((i-1)*batchSize+1:i*batchSize,:),eta);
        % Correction
        MLP.W_c = MLP.W_c + adjW_c;
        MLP.W_s = MLP.W_s + adjW_s;
    end
    % Rajout des restes
    if ~isempty(Xr)
    [adjW_s,adjW_c] = MLP.retroPropagation(Xr, Dr ,eta);
    MLP.W_c = MLP.W_c + adjW_c;
    MLP.W_s = MLP.W_s + adjW_s;
    end
    % Calcul du résultat
    Y       = MLP.propagation([X;Xr]);
    % Calculer l'erreur quadratique moyenne et l'ajouter au vecteur
    MSE(ep) = sum((([D;Dr]-Y).^2))/size([X;Xr],1);
end

end