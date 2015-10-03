clear;clc;close all
%% Création des données
% Cette section génère des données 2-D provenant de 4 gaussiennes
% arrangées en ou-exclusif

% nombre d'exemple dans chaque groupe
Nc1 = 25; % nombre d'exemple dans la classe 1
Nc2 = 25; % nombre d'exemple dans la classe 1

% Centre et écart type des gaussiennes
u1 = [ 2  1]; s1 = 0.5;
u2 = [-2  1]; s2 = 0.5;
u3 = [-1 -2]; s3 = 0.5;
u4 = [ 1 -2]; s4 = 0.5;

% Génération des vecteur
X1 = (randn([Nc1,2])*s1)+repmat(u1,Nc1,1);
X2 = (randn([Nc2,2])*s2)+repmat(u2,Nc2,1);
X3 = (randn([Nc1,2])*s3)+repmat(u3,Nc1,1);
X4 = (randn([Nc2,2])*s4)+repmat(u4,Nc2,1);

X = [X1;X3;X2;X4];

% Génération des étiquettes {0,1}
D = ones(2*Nc1+2*Nc2,1);
D(2*Nc1+1:end) = 0;


%% Création de l'objet servant à lMaffichage
view = displayMLP;
view = view.initialize();
% Montrer les données
view = view.plotState(X,D,[]);
% disp('Appuyez sur une touche pour continuer...')
% pause

%% Création du réseau multi-couche
MLP = myMLP; % création de l'objet

% initialisation du réseau
% les paramètres sont le numbre de neurones sur la
%(couche d'entrée, couche caché, couche de sortie)
MLP = MLP.initialisation(2,3,1);

%% Affichage de l'état actuel du réseau
% Afficher le réseau avant l'apprentissage
Y      =  MLP.propagation(X)>0.5; % classifier toutes les données
% afficher la classification
view   = view.plotState(X,D,Y);

%% Entrainement

% Données
eta    = 0.1; % constante d'apprentissage
nEpoch = 400; % nombre de d'époques d'entrainement
Y      = zeros(size(X,1),4);
MSE    = zeros(nEpoch,4);
% Ajustement pour full = 0 et random = 0
tic;
[MLP1, MSE(:,1), Y(:,1)] = Training( MLP, X, D, eta, nEpoch, 0, 0 );
display('Temps d''entrainnement dans le cas full = 0 et random = 0');
toc;
display(' ');

% Ajustement pour full = 1 et random = 0
tic;
[MLP2, MSE(:,2), Y(:,2)] = Training( MLP, X, D, eta, nEpoch, 1, 0 );
display('Temps d''entrainnement dans le cas full = 1 et random = 0');
toc;
display(' ');

% Ajustement pour full = 0 et random = 1
tic;
[MLP3, MSE(:,3), Y(:,3)] = Training( MLP, X, D, eta, nEpoch, 0, 1 );
display('Temps d''entrainnement dans le cas full = 0 et random = 1');
toc;
display(' ');

% Ajustement pour full = 1 et random = 1
tic;
[MLP4, MSE(:,4), Y(:,4)] = Training( MLP, X, D, eta, nEpoch, 1, 1 );
display('Temps d''entrainnement dans le cas full = 1 et random = 1');
toc;
display(' ');

% % Afficahge des données
[minMSE, idx] =  min(MSE(end,:));
 view = view.plotState(X,D,Y(:,idx));% afficher la classification dans le meilleur cas
 view = view.plotMSE(MSE(:,idx));    % afficher l'erreur dans le meilleur cas
 
 % Comparaison de l'erreur
 figure(2)
 plot(repmat((1:nEpoch)',1,4),MSE,'LineWidth',2);
 xlabel('nombre d''époque');
 ylabel('Valeur de l''erreur');
 title('MSE');
 legend('full = 0, random = 0','full = 1, random = 0','full = 0, random = 1','full = 1, random = 1');
 