function X = CreateBatch (X, D, batchSize)
% On définie les proportions
P1 = floor(batchSize*sum(D)/size(D,1)); % Proportion de 1
P0 = batchSize-P1;                      % Proportion de 0

% On separt les indexes des 0 et des 1
D0 = find(~D, size(X,1));  % Index de D pour D = 0
D1 = find( D, size(X,1));  % Index de D pour D = 1

% On melange les index
I0 = randperm(length(D0)); % Index random de D = 0
I1 = randperm(length(D1)); % Index random de D = 1

% On applique le melange aux entres
X0 = X(I0,:); % X = 0 random
X1 = X(I1,:); % X = 1 random

%% Création des échantillons

% nombre de lot bien proportionné que l'on peut construire
nbBatch           = min(floor(size(X0,1)/P0),...
                        floor(size(X1,1)/P1));
% Initialisation
X(1:P1,:)       = X1(1:P1,:);
X(P1+1:P1+P0,:) = X0(1:P0,:);

% Iteration
for i = 1:(nbBatch-1)
    X(i*batchSize+1:i*batchSize+P1,:)       = X1(i*P1+1:(i+1)*P1,:); % Ajout des cas D = 1
    X(i*batchSize+P1+1:i*batchSize+P0+P1,:) = X0(i*P0+1:(i+1)*P0,:); % Ajout des cas D = 0
    X(i*batchSize+1:i*batchSize+P0+P1,:)    = X(i*batchSize+1+randperm(batchSize),:); % Melange des cas dans le lot
end

% Rajout des restes
% Cas ou il restes des D = 1 hors des lots
nbReste = size(X1,1)-nbBatch*P1+size(X0,1)-P0*nbBatch;
if size(X1,1)>= nbBatch*P1+1
    if size(X0,1)>= nbBatch*P0+1 % Cas ou il restes des D = 0 hors des lots
        X = [X1(nbBatch*P1+1:end,:); X0(nbBatch*P0+1:end,:); X(1:end-nbReste,:)];
        X(1:nbReste,:) =...
            X(randperm(nbReste),:); % mélange des restes
    else
        X = [X1(nbBatch*P1+1:end,:); X(1:end-nbReste,:)];
    end
else % Cas ou il n'y a plus de D = 1 hors des lots
    if size(X0,1)>= nbBatch*P0+1 % Cas ou il restes des D = 0 hors des lots
        X = [X0(nbBatch*P0+1:end,:); X(1:end-nbReste,:)];
    end
end
end
