function [] = extraireVecteursdesImages(path,patchSize,step)

% path: contient le chemin d'accès au répertoire d'images
% patchSize: dimension de l'imagette (patchSize x patchSize)
% step: distance entre les imagettes extraites
% mute: si vrai, les images ne s'afficheront plus.

% obtenir la liste de tous les fichiers
allFiles = dir([path '*.tif']);
mute = true;

hps = floor(patchSize/2); % taille de la moitié d'une imagette

for i = 1:length(allFiles)
    
    %% Lire les images et les sauvegarder dans des matrices formattées
    
    % lire l'image
    xM = imread([path allFiles(i).name]);
    
    % convertir en tons de gris si l'image est en couleur
    if size(xM,3)>1
        xM = rgb2gray(xM);
    end
    
    % obtenir l'image désirée trouvant le contour avec la méthode Canny
    % edges
    yM = edge(xM,'canny');
    
    % montrer l'image original et l'image de sortie
    if ~mute
        figure;
        imshowpair(xM,yM,'montage')
    end
    
    % Sauvegarder l'image désirée dans une matrice (*.md)
    newFileName = [path allFiles(i).name];
    newFileName = strrep(lower(newFileName),'tif','md');
    dlmwrite(newFileName,yM)
    
    % Sauvegarder l'image d'entrée dans une matrice (*.mx)
    newFileName = [path allFiles(i).name];
    newFileName = strrep(lower(newFileName),'tif','mx');
    
    % normaliser les valeur de l'image
    xM = double(xM)/255;
    dlmwrite(newFileName,xM)
    
    %% Extraire les vecteurs et les valeurs désirées
    
    X = []; % Collection de vecteurs d'entrainement
    D = []; % Collceiton de valeurs désirées
    
    % parcourir l'image, imagette par imagette 
    for j = ceil(patchSize/2):step:size(xM,1)-ceil(patchSize/2)
        for k = ceil(patchSize/2):step:size(xM,2)-ceil(patchSize/2)
            
            % extraire les pixels de l'imagette centrée à [j,k]
            tmp = xM(j-hps:j+hps,k-hps:k+hps);
            % mettre sous la forme d<un vecteur ligne
            tmp = tmp(:)';
            
            % ajouter à la collection de vecteurs
            X = [X;tmp];
            % ajouter la valeur désirée à la collection
            D = [D;yM(j,k)];  
        end
    end
    
    % Sauvegarder les vecteurs d'entrainement dans un fichier
    newFileName = [path allFiles(i).name];
    newFileName = strrep(lower(newFileName),'tif','vx');
    dlmwrite(newFileName,X)
    
    % Sauvegarder les valeurs désirées dans un fichier
    newFileName = [path allFiles(i).name];
    newFileName = strrep(lower(newFileName),'tif','vd');
    dlmwrite(newFileName,D)
    
    
end

end

