function [X,D] = ExtendData(X,D,varargin)
%EXTENDDATA : Creer des donn�es synth�tiques � partire d'un set de donn�es
%Cette fonction ne s'applique que � des matrices d�crivants des images
%
% ExtendData(X,D,'option'...)
%
%   X      : le set de don�es que l'on souhaite etendre
%   D      : la valeur de sortie associ�e au set de donn�e
%   option : Le type de synth�se a appliquer pour avoir de nouvelles
%   donn�es. Il est possible d'appliquer toutes les options en m�me temps.
%   ATTENTION, il faut au moins s�lectionner une option de synth�se.
%
%   Les diff�rentes options existantes sont :
%   symlr  : sym�trie verticale de l'image
%   symud  : sym�trie horizontale de l'image

%#ok<*AGROW>

    if nargin < 3
        error('Option de synth�se manquante');
    end

    for i = 3 : nargin
        switch varargin{i-2}
            case 'symlr'
                X = [X; fliplr(X)]; 
                D = [D; D        ];
            case 'symud'
                X = [X; flipud(X)];
                D = [D; flipud(D)];
            otherwise
                error('Option de synth�se non reconne');
        end
    end

end

