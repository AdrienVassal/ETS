clear;clc;close all
%% Param�tres
patchSize = 3; 
step      = 8;
minDist   = 0.8;
eta       = 0.05;
nEpoch    = 5000;
%% Cr�ation des bases de donn�es
[X,D]     = ExtractData('images\Training\',patchSize,step,minDist);
batchSize = size(X,1);
%% Cr�ation du r�seau de neurones
MLP     = myMLP;
MLP     = MLP.initialisation(9,5,1);
MLPExp1 = repmat(MLP,length(eta),1);
%% Entrainement du r�seau

MSE    = zeros(nEpoch   ,length(eta));
Y      = zeros(size(X,1),length(eta));

for i = 1 : length(eta);
    tic;
    [MLPExp1(i), MSE(:,i), Y(:,i)] = Training( MLP, X, D, eta(i),...
                                                  nEpoch, batchSize,0);
    ledg{i} = strcat('eta = ', num2str(eta(i)));
    display(['Temps pour eta = ', num2str(eta(i))]);
    toc;
    display(' ');
end

% Visualitasion de l'erreur
figure;
plot(repmat((1:nEpoch)',1,length(eta)),MSE,'LineWidth',2);
xlabel('nombre d''�poque');
ylabel('Valeur de l''erreur');
legend(ledg);
title('MSE');

%% Visulaliser le r�sultat
ViewNetworkResult(MLPExp1, patchSize);