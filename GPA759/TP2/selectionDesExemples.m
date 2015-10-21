function [X,D] = selectionDesExemples(path, minDist)
% path: contient le chemin d'acc�s au r�pertoire de fichiers de vecteurs
% minDist: distance eucl�dienne minimal entre les exemples


% obtenir la liste de tous les fichiers
allFiles = dir([path '*.vx']);

% obtenir le carr�e de la distance minimal pour acc�lerer le calcul...
minDist = minDist^2;

% Matrices contenant les exemples retenus
X = [];
D = [];

% ouvrir chacun des fichier et ajouter les exemples appropri�s
for i = 1:length(allFiles)
    
    % obtenir les vecteurs contenus dans les fichiers
    fileName = [path allFiles(i).name];
    vX       = dlmread(fileName);
    fileName = strrep(fileName,'.vx','.vd');
    vD       = dlmread(fileName);
    
    % regarder les vecteurs un par un et les ajouter s'il sont assez
    % diff�rents de ceux d�j� dans X
    for j = 1:size(vX,1)
        
        % comparer avec tous les vecteurs d�j� s�lectionn�s
        addIt = true;
        for k = 1:size(X,1)
            dist = sum((X(k,:) - vX(j,:)).^2);
            if dist<minDist
                addIt = false;
                break;
            end
        end     
        % si diff�rent de tous les autres, on ajoute
        if addIt
            X = [X;vX(j,:)];
            D = [D;vD(j)];
        end
    end
    
end
end