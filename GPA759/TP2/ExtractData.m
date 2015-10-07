function [X, D, Xval, Dval] = ExtractData(patchSize,step,minDist)
%EXTRACTDATA : extraction des donn�es des images avec entr�e et sortie
%d�sir�e associ�e.
%La matrice X est une matrice compos� de niveau de gris de l'image
extraireVecteursdesImages('images\Training\',patchSize,step)
extraireVecteursdesImages('images\Validation\',patchSize,step)
extraireVecteursdesImages('images\Test\',patchSize,step)
[X,D] = selectionDesExemples('images\Training\', minDist);
[Xval,Dval] = selectionDesExemples('images\Validation\', 0);
end