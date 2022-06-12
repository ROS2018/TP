% ECN C2Syst2E METOD TP2 2016-2017

% Simulations temporelles

% Choix de valeurs de Tc et To pour choix de F et K
% puis simulation 
% - de la boucle avec pr�compensation statique
% - de la boucle avec pr�compensation dynamique (directe dans l'�nonc�)
% - de la boucle avec pr�compensation statique (pratique dans l'�nonc�)

clc,clear all,close all,
format compact

% I,1 �tude de la boucle ouverte
%-------------------------------
k=35;a=2;b=3;c=5;    % cas d'un z�ro � partie r�elle <0

% d�fintion de G
s=tf('s');

disp(' transfert du mod�le utilis� ')
G=k*(s+c)/(s+a)/(s+b)/(s+b)

% Choix d'une repr�sentation d'�tat

% ??????

% Etude de la boucle cible: retour d'�tat
disp('---Calcul de F ---------');
Tc=0.1;
disp(sprintf('--- Tc=%1.4f -----',Tc))

% ???

% Etude de la boucle compl�te: gain d'observateur
disp('---Calcul de K ---------');
To=Tc/3;
disp(sprintf('--- To=%1.4f -----',To))

% ???


% caclul du pr�compensateur statique et/ou dynamique
disp('---Pr�compensation------')

% ???


disp(sprintf('--- Tr=%1.4f -----',Tr))

% d�finition d'incertitude sur le syst�me �tudi�
disp('---Gp-------------------')
% rappel a=2;b=3;c=5;    % cas d'un z�ro � partie r�elle <0
err=0;
kp=k*(1+err/100);ap=a*(1+err/100);bp=b*(1+err/100);cp=c*(1+err/100);
disp(' transfert du proc�d� �tudi� ')
Gp=kp*(s+cp)/(s+ap)/(s+bp)/(s+bp)

sim('precom_stat')

sim('precom_dyn_1')

sim('precom_dyn_2')
[f1x f1y f3x f3y window_x window_y]=screen_split;

figure(1),set(1,'position',[f1x f1y window_x window_y])
subplot(211),plot(y_stat.time,y_stat.signals(1).values(:,1),'k',...
y_stat.time,y_stat.signals(1).values(:,2),'b')
title('R�ponse en asservissement (pr�comp. statique)'),zoom on,grid on
subplot(212),plot(y_stat.time,y_stat.signals(2).values)
title('Commande de la reponse en asservissement (pr�comp. statique)'),zoom on,grid on

figure(2),set(2,'position',[f3x f1y window_x window_y])
subplot(211),plot(y_dyn_1.time,y_dyn_1.signals(1).values(:,1),'k',...
y_dyn_1.time,y_dyn_1.signals(1).values(:,2),'b')
title('R�ponse en asservissement (pr�comp. dyn. v.1)'),zoom on,grid on
subplot(212),plot(y_dyn_1.time,y_dyn_1.signals(2).values)
title('Commande de la reponse en asservissement (pr�comp. dyn. v.1)'),zoom on,grid on

figure(3),set(3,'position',[f3x f3y window_x window_y])
subplot(211),plot(y_dyn_2.time,y_dyn_2.signals(1).values(:,1),'k',...
y_dyn_2.time,y_dyn_2.signals(1).values(:,2),'b')
title('R�ponse en asservissement (pr�comp. dyn. v.2)'),zoom on,grid on
subplot(212),plot(y_dyn_2.time,y_dyn_2.signals(2).values)
title('Commande de la reponse en asservissement (pr�comp. dyn. v.2)'),zoom on,grid on
