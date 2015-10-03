function [X,D] = selectionDesExemples(path, minDist)
% path: contient le chemin d'accès au répertoire de fichiers de vecteurs
% minDist: distance euclédienne minimal entre les exemples


% obtenir la liste de tous les fichiers
allFiles = dir([path '*.vx']);

% obtenir le carrée de la distance minimal pour accélerer le calcul...
minDist = minDist^2;

% Matrices contenant les exemples retenus
X = [];
D = [];

% ouvrir chacun des fichier et ajouter les exemples appropriés
for i = 1:length(allFiles)
    
    % obtenir les vecteurs contenus dans les fichiers
    fileName = [path allFiles(i).name];
    vX = dlmread(fileName);
    fileName = strrep(fileName,'.vx','.vd');
    vD = dlmread(fileName);
    
    % regarder les vecteurs un par un et les ajouter s'il sont assez
    % différents de ceux déjà dans X
    for j = 1:size(vX,1)
        
        % comparer avec tous les vecteurs déjà sélectionnés
        addIt = true;
        for k = 1:size(X,1)
            dist = sum((X(k,:) - vX(j,:)).^2);
            if dist<minDist
                addIt = false;
                break;
            end
        end
        
        % si différent de tous les autres, on ajoute
        if addIt
            X = [X;vX(j,:)];
            D = [D;vD(j)];
        end
    end
    
end





end