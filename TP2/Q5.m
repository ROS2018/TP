%clc,clear all,close all
clc;
format compact
k=35;a=-2;b=3;c=-3;
% définition de G
s=tf('s');
disp('---G----------------');
G=k*(s+c)/(s+a)/(s+b)/(s+b)
% calcul d’une représentation d’état
disp('---A B C D pour G --');
[A,B,C,D]=ssdata(G)

disp('===== Stability====');
eig(A); %% inStable

disp('Les poles a choisir pour Tc1:');
% Puisque toutes les valeurs propres de A sont sur l'axe x alors
% alors:
Tc1=0.05;
P1 = -[1; 1; 1]/Tc1;
F1 = -acker(A,B,P1);
Lc1= minreal(-F1*inv(s*eye(3,3)-A)*B,0.01);
%ss(A,B,-F1,[0,0,0])
Sc1=minreal(1/(1+Lc1),0.01)
Tubc1=minreal(Lc1*Sc1,0.01)

%------------

disp('Les marges de stabilite, Margin');
%figure(1)
%margin(Lc1)% Mg= inf, Mph=78.79;
%figure(2)
u0 = (s-1)/(s+1); u1 = -1 + u0 ;
%nyquist(Lc1,u0,u1)%


disp('Diagramme de bode de Tc1 et Tc2, Kc1 et Kc2');


% 3/ Étude de la boucle complète (avec le retour d’état et l’observateur)

disp('Calcul de valeurs propres de A-KC ');
To1=Tc1/30;
Po1=[-c; -1/To1; -1/To1];

disp('Calcule de Ki');
K1 = acker(A',C',Po1)';

disp(' Calcule de Regi= F1*inv(sI ? A ? BF1 + KiC)Ki');
Reg1=minreal(tf(ss(A+B*F1-K1*C, K1, -F1,0)),0.01);

disp(' Calcule de Li');
L1=minreal(Reg1*G,01)
polesO=eig(L1)
LL = minreal(L1/(L1+1),1)
polesF = eig(LL)
disp(' Calcule de Si');
S1=1/(1+L1);

disp(' Calcule de Si');
Tub1 = G*S1;

%------------

disp('Les marges de stabilite');
disp('Li');
figure(3);
margin(L1)% Mg= inf, Mph=;
figure(4)
nyquist(L1)

