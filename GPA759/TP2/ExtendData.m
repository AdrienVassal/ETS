function [X,D] = ExtendData(X,D,varargin)
%EXTENDDATA : Creer des données synthètiques à partire d'un set de données
%Cette fonction ne s'applique que à des matrices décrivants des images
%
% ExtendData(X,D,'option'...)
%
%   X      : le set de donées que l'on souhaite etendre
%   D      : la valeur de sortie associée au set de donnée
%   option : Le type de synthèse a appliquer pour avoir de nouvelles
%   données. Il est possible d'appliquer toutes les options en même temps.
%   ATTENTION, il faut au moins sélectionner une option de synthèse.
%
%   Les différentes options existantes sont :
%   symlr  : symétrie verticale de l'image
%   symud  : symétrie horizontale de l'image

%#ok<*AGROW>

    if nargin < 3
        error('Option de synthèse manquante');
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
                error('Option de synthèse non reconne');
        end
    end

end

