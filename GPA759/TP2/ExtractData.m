function [X, D] = ExtractData(path,patchSize,step,minDist)
%EXTRACTDATA : extraction des données des images avec entrée et sortie

% path: contient le chemin d'accès au répertoire d'images
% patchSize: dimension de l'imagette (patchSize x patchSize)
% step: distance entre les imagettes extraites
% minDist: distance euclédienne minimal entre les exemples
extraireVecteursdesImages(path,patchSize,step);
[X,D] = selectionDesExemples(path, minDist);
end