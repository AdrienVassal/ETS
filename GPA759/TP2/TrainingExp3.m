function [MLP, MSE, Y, Yv] = TrainingExp3( MLP, X, D, Xv, Dv, eta, nEpoch, full, random )
%TRAINING : entraine un réseau de neurones MLP, avec les data X, durant
%nEpoch époque selon le le type d'entrainement désiré.
%   Training(MLP, nbE, full, random)
%
%   MLP    : objet contenant le réseau MPL déjà initialisé
%   X      : Les données d'entrées set d'entrainement
%   D      : Les données de sorties du set d'entrainement
%   Xv     : Les données d'entrées set de validation
%   Dv     : Les données de sorties du de validation
%   eta    : valeur de la constante d'apprentissage
%   nEpoch : Le nombre d'époque à réaliser
%   full   : Boolean 1 = apprentissage sur le set complet, 0 = apprentissage
%   par exmple du set
%   random : Boolean 1 = sélection des données du set d'entrainement dans
%   un ordre aléatoire, 0 = sélection des données du set d'entrainement
%   dans l'ordre déjà établi.

% Initialisation du vecteur de l'erreur quadratique moyenne
MSE = zeros(2,nEpoch);

if random
    getIdx = @(X) randperm(size(X,1));
else
    getIdx = @(X) (1:size(X,1));
end

if full
    for ep = 1:nEpoch
        % Initialisation
        idx             = getIdx(X);
        % Rétropropagation sur le set complet
        [adjW_s,adjW_c] = MLP.retroPropagation(X(idx,:),D(idx,:),eta);
        % Correction
        MLP.W_c         = MLP.W_c + adjW_c;
        MLP.W_s         = MLP.W_s + adjW_s;
        % Calcul du résultat
        Y       = MLP.propagation(X);
        Yv       = MLP.propagation(Xv);
        % Calculer l'erreur quadratique moyenne et l'ajouter au vecteur
        MSE(1,ep) = sum(((D-Y).^2))/size(X,1);
        MSE(2,ep) = sum(((Dv-Yv).^2))/size(Xv,1);
    end
else
    
    for ep = 1:nEpoch
        % Initialisation
        idx = getIdx(X);
        % Rétropropagation par exemple
        for i = 1:length(idx)
            % obtenir les ajustement pour une donnée par rétropropagation
            [adjW_s,adjW_c] = MLP.retroPropagation(X(idx(i),:),D(idx(i),:),eta);
            
            % Correction
            MLP.W_c = MLP.W_c + adjW_c;
            MLP.W_s = MLP.W_s + adjW_s;
        end
        % Calcul du résultat
        Y        = MLP.propagation(X);
        Yv       = MLP.propagation(Xv);
        % Calculer l'erreur quadratique moyenne et l'ajouter au vecteur
        MSE(1,ep) = sum(((D-Y).^2))/size(X,1);
        MSE(2,ep) = sum(((Dv-Yv).^2))/size(Xv,1);
    end
end
end