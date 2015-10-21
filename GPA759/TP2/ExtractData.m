function [X, D] = ExtractData(path,patchSize,step,minDist)
%EXTRACTDATA : extraction des donn�es des images avec entr�e et sortie

% path: contient le chemin d'acc�s au r�pertoire d'images
% patchSize: dimension de l'imagette (patchSize x patchSize)
% step: distance entre les imagettes extraites
% minDist: distance eucl�dienne minimal entre les exemples
extraireVecteursdesImages(path,patchSize,step);
[X,D] = selectionDesExemples(path, minDist);
end