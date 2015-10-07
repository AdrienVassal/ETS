clear;clc;close all
%% Paramètres
patchSize = 3;
step      = 8;
minDist   = 0.8;
eta       = [0.001 0.01 0.1 1];
nEpoch    = 5000;
%% Création des bases de données
[X,D,Xval,Dval] = ExtractData(patchSize,step,minDist);
%% Création du réseau de neurones
MLP     = myMLP;
MLP     = MLP.initialisation(9,5,1);
MLPExp1 = repmat(MLP,length(eta),1);
%% Entrainement du réseau

MSE    = zeros(nEpoch   ,length(eta));
Y      = zeros(size(X,1),length(eta));

for i = 1 : length(eta);
    tic;
    [MLPExp1(i), MSE(:,i), Y(:,i)] = Training( MLP, X, D, eta(i), nEpoch, 1, 0 );
    ledg{i} = strcat('eta = ', num2str(eta(i)));
    display(['Temps pour eta = ', num2str(eta(i))]);
    toc;
    display(' ');
end

% Visualitasion de l'erreur
figure;
plot(repmat((1:nEpoch)',1,length(eta)),MSE,'LineWidth',2);
xlabel('nombre d''époque');
ylabel('Valeur de l''erreur');
legend(ledg);
title('MSE');
%% Utiliser le réseau
ViewNetworkResult(MLPExp1, patchSize);