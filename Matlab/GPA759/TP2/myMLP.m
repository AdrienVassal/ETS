classdef myMLP
    % une classe contenant un MLP pour le lab2 de GPA759
    %   Cet objet contient les poids d'un r�seau de neurone et des
    %   fonctions pour l'initialiser, classifier et entrainer
    %
    
    properties
        
        % Dans les matices de poids, les neurones sont sur les lignes
        % et les connexions sur les colonnes
        
        % poids de la couche cach�e
        W_c = []
        % poids de la couche de sortie
        W_s = [];
        
        % fonction d'activation
        F = @(net) 1./(1+exp(-net));
        % d�riv�e de la fonction d'activation
        Fd = @(y) y.*(1-y);
        
    end
    
    methods
        
        function obj = initialisation(obj, n_entree, n_cache, n_sortie)
            
            % initialise les poids de mani�re al�atoire
            obj.W_c = randn(n_cache,n_entree+1);
            obj.W_s = randn(n_sortie,n_cache+1);
        end
        
        function [Y] = propagation(obj,X)
            %% Cette fonction fait la propagation directe du vecteur
            % ou de la matrice d'entr�e � travers le r�seau.
            % Elle retourne la sortie du r�seau pour chacune des lignes X            
            
            %Couche cach�e
            Xa    = [X ones(size(X,1),1)];    % Seuil couche cach�e            
            Net_c = Xa*obj.W_c';
            Y_c   = obj.F(Net_c);
            
            %Couche de sortie
            Y_ca  = [Y_c ones(size(Y_c,1),1)]; % Seuil couche sortie
            Net_s = Y_ca*obj.W_s';
            Y     = obj.F(Net_s);            
        end
        
        function [dW_s,dW_c,Y_s] = retroPropagation(obj,X,D,eta)
            
            % Cette function calcule les ajustements aux matrices de poids
            % W_c et W_s obtenus quand on pr�sente le vecteur d'entr�e X.
            % X: vecteur pr�sent� � l'entr�e du r�seau
            % D: vecteur d�sir� � la sortie du r�seau
            % eta: constante d'apprentissage
            % dW_s: ajustement aux poids de la couche de sortie
            % dW_s: ajustement aux poids de la couche cach�e
            
            %Couche cach�e
            Xa    = [X ones(size(X,1),1)];      % Seuil couche cach�e
            Net_c = Xa*obj.W_c';
            Y_c   = obj.F(Net_c);
            
            %Couche de sortie
            Y_ca  = [Y_c ones(size(Y_c,1),1)]; % Seuil couche sortie
            Net_s = Y_ca*obj.W_s';
            Y_s   = obj.F(Net_s);           
            
            % R�tropropagation
            Delta_s = (Y_s-D).*obj.Fd(Y_s);
            dW_s    = -eta*Delta_s'*Y_ca;
            
            Delta_c = Delta_s*obj.W_s(:,1:end-1).*obj.Fd(Y_c);
            dW_c    = -eta*Delta_c'*Xa;
        end        
    end    
end

