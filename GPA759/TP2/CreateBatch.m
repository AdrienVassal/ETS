function [X, D, Xr, Dr] = CreateBatch (X, D, batchSize)
% On dÃ©finie les proportions
P1 = floor(batchSize*sum(D)/size(D,1)); % Proportion de 1
P0 = batchSize-P1;                      % Proportion de 0

% On separt les indexes des 0 et des 1 et on les melanges
I0 = randperm(length(find(~D, size(X,1)))); % Index random de D = 0
I1 = randperm(length(find( D, size(X,1)))); % Index random de D = 1

% On applique le melange aux entres
X0 = X(I0,:); % X = 0 random
X1 = X(I1,:); % X = 1 random



%% CrÃ©ation des Ã©chantillons

% nombre de lot bien proportionné que l'on peut construire
nbBatch           = min(floor(size(X0,1)/P0),...
                        floor(size(X1,1)/P1));
% Vecteur contenant les retes inclassable dans les lots
Xr       = [];
Dr       = [];
if nbBatch >1
    % Initialisation : création du premier lot
    X(1:P1,:)       = X1(1:P1,:);
    D(1:P1)         = 1;
    X(P1+1:P1+P0,:) = X0(1:P0,:);
    D(P1+1:P1+P0)   = 0;
    % Mélange des données dans le premier lot
    idx = randperm(batchSize);
    X(1:P1+P0,:) = X(idx,:);
    D(1:P1+P0)   = D(idx);
    
    % Itérations
    for i = 1:(nbBatch-1)
        % Ajout des cas D = 1
        X(i*batchSize+1:i*batchSize+P1,:)       = X1(i*P1+1:(i+1)*P1,:);
        D(i*batchSize+1:i*batchSize+P1)         = 1;
        % Ajout des cas D = 0
        X(i*batchSize+P1+1:i*batchSize+P0+P1,:) = X0(i*P0+1:(i+1)*P0,:);
        D(i*batchSize+P1+1:i*batchSize+P0+P1)   = 0;
        
        % Melange des cas dans le lot
        idx = i*batchSize+1+randperm(batchSize);
        X(i*batchSize+1:i*batchSize+P0+P1,:)    = X(idx,:);
        D(i*batchSize+1:i*batchSize+P0+P1)      = D(idx,:);
    end
    
    % Rajout des restes
    % Cas ou il restes des D = 1 ou ou D = 0 hors des lots
    nbReste1 = size(X1,1)-P1*nbBatch;
    nbReste0 = size(X0,1)-P0*nbBatch;
    nbReste  = nbReste1+nbReste0;
    if nbReste >0
        Xr = [X1(nbBatch*P1+1:end,:); X0(nbBatch*P0+1:end,:)];
        Dr = [ones(nbReste1,1);zeros(nbReste0,1)];
    end
    X = X(1:end-nbReste,:);
    D = D(1:end-nbReste);
end
end
