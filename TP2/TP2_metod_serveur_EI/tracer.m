% ECN C2Syst2E METOD TP2 2016-2017

% Simulations temporelles

% Choix de valeurs de Tc et To pour choix de F et K
% puis simulation 
% - de la boucle avec précompensation statique
% - de la boucle avec précompensation dynamique (directe dans l'énoncé)
% - de la boucle avec précompensation statique (pratique dans l'énoncé)

clc,clear all,close all,
format compact

% I,1 étude de la boucle ouverte
%-------------------------------
k=35;a=2;b=3;c=5;    % cas d'un zéro à partie réelle <0

% défintion de G
s=tf('s');

disp(' transfert du modèle utilisé ')
G=k*(s+c)/(s+a)/(s+b)/(s+b)

% Choix d'une représentation d'état

% ??????

% Etude de la boucle cible: retour d'état
disp('---Calcul de F ---------');
Tc=0.1;
disp(sprintf('--- Tc=%1.4f -----',Tc))

% ???

% Etude de la boucle complète: gain d'observateur
disp('---Calcul de K ---------');
To=Tc/3;
disp(sprintf('--- To=%1.4f -----',To))

% ???


% caclul du précompensateur statique et/ou dynamique
disp('---Précompensation------')

% ???


disp(sprintf('--- Tr=%1.4f -----',Tr))

% définition d'incertitude sur le système étudié
disp('---Gp-------------------')
% rappel a=2;b=3;c=5;    % cas d'un zéro à partie réelle <0
err=0;
kp=k*(1+err/100);ap=a*(1+err/100);bp=b*(1+err/100);cp=c*(1+err/100);
disp(' transfert du procédé étudié ')
Gp=kp*(s+cp)/(s+ap)/(s+bp)/(s+bp)

sim('precom_stat')

sim('precom_dyn_1')

sim('precom_dyn_2')
[f1x f1y f3x f3y window_x window_y]=screen_split;

figure(1),set(1,'position',[f1x f1y window_x window_y])
subplot(211),plot(y_stat.time,y_stat.signals(1).values(:,1),'k',...
y_stat.time,y_stat.signals(1).values(:,2),'b')
title('Réponse en asservissement (précomp. statique)'),zoom on,grid on
subplot(212),plot(y_stat.time,y_stat.signals(2).values)
title('Commande de la reponse en asservissement (précomp. statique)'),zoom on,grid on

figure(2),set(2,'position',[f3x f1y window_x window_y])
subplot(211),plot(y_dyn_1.time,y_dyn_1.signals(1).values(:,1),'k',...
y_dyn_1.time,y_dyn_1.signals(1).values(:,2),'b')
title('Réponse en asservissement (précomp. dyn. v.1)'),zoom on,grid on
subplot(212),plot(y_dyn_1.time,y_dyn_1.signals(2).values)
title('Commande de la reponse en asservissement (précomp. dyn. v.1)'),zoom on,grid on

figure(3),set(3,'position',[f3x f3y window_x window_y])
subplot(211),plot(y_dyn_2.time,y_dyn_2.signals(1).values(:,1),'k',...
y_dyn_2.time,y_dyn_2.signals(1).values(:,2),'b')
title('Réponse en asservissement (précomp. dyn. v.2)'),zoom on,grid on
subplot(212),plot(y_dyn_2.time,y_dyn_2.signals(2).values)
title('Commande de la reponse en asservissement (précomp. dyn. v.2)'),zoom on,grid on
