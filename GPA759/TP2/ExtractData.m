function [X, D, Xval, Dval] = ExtractData(patchSize,step,minDist)
%EXTRACTDATA : extraction des données des images avec entrée et sortie
%désirée associée.
%La matrice X est une matrice composé de niveau de gris de l'image
extraireVecteursdesImages('images\Training\',patchSize,step)
extraireVecteursdesImages('images\Validation\',patchSize,step)
extraireVecteursdesImages('images\Test\',patchSize,step)
[X,D] = selectionDesExemples('images\Training\', minDist);
[Xval,Dval] = selectionDesExemples('images\Validation\', 0);
end