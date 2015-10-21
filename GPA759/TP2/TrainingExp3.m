function [MLP, MSE, Y, Yv] = TrainingExp3( MLP, X, D, Xv, Dv, eta, nEpoch, full, random )
%TRAINING : entraine un r�seau de neurones MLP, avec les data X, durant
%nEpoch �poque selon le le type d'entrainement d�sir�.
%   Training(MLP, nbE, full, random)
%
%   MLP    : objet contenant le r�seau MPL d�j� initialis�
%   X      : Les donn�es d'entr�es set d'entrainement
%   D      : Les donn�es de sorties du set d'entrainement
%   Xv     : Les donn�es d'entr�es set de validation
%   Dv     : Les donn�es de sorties du de validation
%   eta    : valeur de la constante d'apprentissage
%   nEpoch : Le nombre d'�poque � r�aliser
%   full   : Boolean 1 = apprentissage sur le set complet, 0 = apprentissage
%   par exmple du set
%   random : Boolean 1 = s�lection des donn�es du set d'entrainement dans
%   un ordre al�atoire, 0 = s�lection des donn�es du set d'entrainement
%   dans l'ordre d�j� �tabli.

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
        % R�tropropagation sur le set complet
        [adjW_s,adjW_c] = MLP.retroPropagation(X(idx,:),D(idx,:),eta);
        % Correction
        MLP.W_c         = MLP.W_c + adjW_c;
        MLP.W_s         = MLP.W_s + adjW_s;
        % Calcul du r�sultat
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
        % R�tropropagation par exemple
        for i = 1:length(idx)
            % obtenir les ajustement pour une donn�e par r�tropropagation
            [adjW_s,adjW_c] = MLP.retroPropagation(X(idx(i),:),D(idx(i),:),eta);
            
            % Correction
            MLP.W_c = MLP.W_c + adjW_c;
            MLP.W_s = MLP.W_s + adjW_s;
        end
        % Calcul du r�sultat
        Y        = MLP.propagation(X);
        Yv       = MLP.propagation(Xv);
        % Calculer l'erreur quadratique moyenne et l'ajouter au vecteur
        MSE(1,ep) = sum(((D-Y).^2))/size(X,1);
        MSE(2,ep) = sum(((Dv-Yv).^2))/size(Xv,1);
    end
end
end