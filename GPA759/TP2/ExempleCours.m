clear;close all;clc;
%% Cas d'exemple du cours

% Créaion et initialisation des poids
MLP     = myMLP; 
MLP     = MLP.initialisation(2,2,2);
MLP.W_c = [-0.1 0.3 -0.4;-0.2 0.4 1.5];
MLP.W_s = [ 0.5 -0.3 0.5; 0.7 0.8 0.5];

% Données pour l'entrainement
eta    = 0.1;
nEpoch = 1;
X      = [1 2];
D      = [1 0];
% Entrainement pour une époque
[MLP, MSE, Y] = Training( MLP, X, D, eta, nEpoch, 1);

MLP.W_c
MLP.W_s