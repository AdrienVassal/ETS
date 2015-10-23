clear;clc;close all
%% Paramètres
patchSize = 3;
step      = 8;
minDist   = 0.8;
eta       = 0.05;
nEpoch    = 5000;
%% Création des bases de données
[X,D]     = ExtractData('images\Training\',patchSize,step,minDist);
batchSize = [1 20 40 60 size(X,1)];
% Blanchir les données si nécessaire
%% Création du réseau de neurones
MLP     = myMLP;
MLP     = MLP.initialisation(patchSize^2,5,1);
MLPExp1 = repmat(MLP,length(batchSize),1);
%% Entrainement du réseau

MSE    = zeros(nEpoch   ,length(eta));
Y      = zeros(size(X,1),length(eta));

for i = 1 : length(batchSize);
    tic;
    [MLPExp1(i), MSE(:,i), Y(:,i)] = Training( MLP, X, D, eta,...
                                                  nEpoch, batchSize(i),0 );
    ledg{i} = strcat('batch size = ', num2str(batchSize(i)));
    display(['Temps batch size = ', num2str(batchSize(i))]);
    toc;
    display(' ');
end

% Visualitasion de l'erreur
figure;
plot(repmat((1:nEpoch)',1,length(batchSize)),MSE,'LineWidth',2);
xlabel('nombre d''époque');
ylabel('Valeur de l''erreur');
legend(ledg);
title('MSE');

%% Visulaliser le résultat
%ViewNetworkResult(MLPExp1, patchSize);