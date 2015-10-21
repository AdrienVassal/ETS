clear;clc;close all
%% Paramètres
patchSize   = 3;
step        = 8;
minDist     = 0.8;
eta         = 0.05;
nEpoch      = 20000;

%% Création des bases de données
extraireVecteursdesImages('images\Training\',patchSize,step)
extraireVecteursdesImages('images\Validation\',patchSize,step)
extraireVecteursdesImages('images\Test\',patchSize,step)
[X,D]       = selectionDesExemples('images\Training\', minDist);
[Xval,Dval] = selectionDesExemples('images\Validation\', 0);

%% Création du réseau de neurones
MLP = myMLP;
MLP = MLP.initialisation(9,5,1);

%% Entrainement du réseau

% Entrainer pour nEpoch
tic;
[MLP, MSE, Y, Yv] = TrainingExp3( MLP, X, D, Xval, Dval, eta, nEpoch, 1, 0 );
toc;
%Afficher le MSE pour les bases entrainnement et validations
hold on
for(i=1:2)
    plot(MSE(i,:),'LineWidth',2);
end
legend('MSE base entrainement','MSE base validation');
title('Evolution du MSE entre les bases validation et entrainement');


