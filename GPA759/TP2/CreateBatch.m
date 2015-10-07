nbInput   = 2;
nbOutput  = 1;
n         = 100;
batchSize = 10;

X = rand(n,nbInput );
D = rand(n,nbOutput)>0.5;

% On définie les proportions
P1 = floor(batchSize*sum(D)/size(D,1)); % Proportion de 1
P0 = batchSize-P1;                      % Proportion de 0

% On separt les indexes des 0 et des 1
D0 = find(~D,n); % Index de D pour D = 0
D1 = find(D,n);  % Index de D pour D = 1

% On melange les index
I0 = randperm(length(D0)); % Index random de D = 0
I1 = randperm(length(D1)); % Index random de D = 1

% On applique le melange aux entres/sorties
D0 = D0(I0); % D = 0 random
D1 = D1(I1); % D = 1 random
X0 = X(I0,:); % X = 0 random
X1 = X(I1,:); % X = 1 random

% Création des échantillons

nbLot           = min(floor(size(X0,1)/P0),...
                      floor(size(X1,1)/P1)); % nombre de lot bien proportionné que l'on peut construire
% Initialisation
X(:,:)          = 0; % uniquement pour mieux voir le résultat lors de la construction du code
X(1:P1,:)       = X1(1:P1,:);
X(P1+1:P1+P0,:) = X0(1:P0,:); 

for i = 1:(nbLot-1) % le premier lot est fait dans l'initialisation
   X(i*batchSize+1:i*batchSize+P1,:)       = X1(i*P1+1:(i+1)*P1,:);
   X(i*batchSize+P1+1:i*batchSize+P0+P1,:) = X0(i*P0+1:(i+1)*P0,:);
end

% Rajout des restes