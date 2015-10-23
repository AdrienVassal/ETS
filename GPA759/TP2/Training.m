function [MLP, MSE, Y] = Training( MLP, X, D, eta, nEpoch, batchSize, mu)
%TRAINING : entraine un r�seau de neurones MLP, avec les data X, durant
%nEpoch �poque selon le le type d'entrainement d�sir�.
%   Training(MLP, nbE, full, random)
%
%   MLP       : objet contenant le r�seau MPL d�j� initialis�
%   X         : Les donn�es d'entr�es set d'entrainement
%   D         : Les donn�es de sorties du set d'entrainement
%   eta       : valeur de la constante d'apprentissage
%   nEpoch    : Le nombre d'�poque � r�aliser
%   batchSize : Taille des lots d'entrainement.
%   mu        : Valeur du momentum
%   Si batchSize = 1, cela consiste � entrainer le r�seau �l�ment par
%   �l�ment.
%   Si batchSize = size(X,1), cela consiste � entrainer le r�seau sur tout
%   le set de data X
%
%   NB : toutes les donn�es sont m�lang�es quelque soit la taille des lots

% Initialisation du vecteur de l'erreur quadratique moyenne
MSE            = zeros(1,nEpoch);
[X, D, Xr, Dr] = CreateBatch(X,D,batchSize);

for ep = 1:nEpoch
    % Initialisation
    % R�tropropagation par exemple
    for i = 1:floor(size(X,1)/batchSize)
        % obtenir les ajustement pour une donn�e par r�tropropagation
        [adjW_s,adjW_c] = MLP.retroPropagation(X((i-1)*batchSize+1:i*batchSize,:),...
            D((i-1)*batchSize+1:i*batchSize,:),eta);
        % Sauvegarde des valeurs pour le momentum
        adjW_s_temp = adjW_s;
        adjW_c_temp = adjW_c;
        % Correction
        MLP.W_c = MLP.W_c + adjW_c + mu*adjW_c_temp;
        MLP.W_s = MLP.W_s + adjW_s + mu*adjW_s_temp;
    end
    % Rajout des restes
    if ~isempty(Xr)
    [adjW_s,adjW_c] = MLP.retroPropagation(Xr, Dr ,eta);
    MLP.W_c = MLP.W_c + adjW_c;
    MLP.W_s = MLP.W_s + adjW_s;
    end
    % Calcul du r�sultat
    Y       = MLP.propagation([X;Xr]);
    % Calculer l'erreur quadratique moyenne et l'ajouter au vecteur
    MSE(ep) = sum((([D;Dr]-Y).^2))/size([X;Xr],1);
end

end