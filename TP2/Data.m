%clc,clear all,close all
clc;
format compact
k=35;a=2;b=3;c=-5;
% définition de G
s=tf('s');
disp('---G----------------');
G=k*(s+c)/(s+a)/(s+b)/(s+b)
% calcul d’une représentation d’état
disp('---A B C D pour G --');
[A,B,C,D]=ssdata(G)

disp('===== Stability====');
eig(A); %% Stable

disp('Les poles a choisir pour Tc1:');
% Puisque toutes les valeurs propres de A sont sur l'axe x alors
% alors:
Tc1=0.1;
P1 = -[1; 1; 1]/Tc1;
F1 = -acker(A,B,P1);
Lc1= minreal(-F1*inv(s*eye(3,3)-A)*B,0.01);
% Lc1 = ss(A,B,-F,0)
Sc1=1/(1+Lc1)
Tubc1=minreal(Lc1*Sc1,0.01)
Kc1=minreal(Lc1/G,0.01)
%tf(tf(minreal(...

disp('Les poles a choisir pour Tc2:');
Tc2=0.05;
P2 = -[1; 1; 1]/Tc2;
F2 = -acker(A,B,P2);
Lc2= minreal(-F2*inv(s*eye(3,3)-A)*B,0.01);
%ss(A,B,-F2,0)
Sc2=minreal(1/(1+Lc2),0.01)
Tubc2=minreal(Lc2*Sc2,0.01)
Kc2=minreal(Lc2/G,0.01)

%------------

disp('Les marges de stabilite, Margin');
% figure(1)
% margin(Lc1)% Mg= inf, Mph=78.79;
% figure(12)
% margin(Lc2)% Mg= inf, Mph=53.7017;
% 
disp('Le diagramme de Nyquist de Lc1 et Lc2');
figure(2)
u0 = (s-1)/(s+1); u1 = -1 + u0 ;
nyquist(Lc1,Lc2,u0,u1)%

disp('Bod-Gain Sc1 et Sc2');
%figure(3)
%bodemag(Sc1,Sc2); 

disp('Reponse indicielle de Sc1 et Sc2:');
%figure(4)
%step(Sc1,Sc2); 

disp('Diagramme de bode de Tc1 et Tc2, Kc1 et Kc2');

%figure(5)
%bodemag(Tubc1,Tubc2); 

%figure(6)
%bodemag(Kc1,Kc2); 

% 3/ Étude de la boucle complète (avec le retour d’état et l’observateur)

disp('Calcul de valeurs propres de A-KC ');
To1=Tc1/3;
Po1=[-c; -1/To1; -1/To1];

To2=Tc1/5;
Po2=[-c; -1/To2; -1/To2];

To3=Tc1/30;
Po3=[-c; -1/To3; -1/To3];

To4=Tc1/50;
Po4=[-c; -1/To4; -1/To4];

disp('Calcule de Ki');

K1 = acker(A',C',Po1)';
K2 = acker(A',C',Po2)';
K3 = acker(A',C',Po3)';
K4 = acker(A',C',Po4)';

disp(' Calcule de Regi= F1*inv(sI ? A ? BF1 + KiC)Ki');

Reg1=tf(ss(A+B*F1-K1*C, K1, -F1,0));
Reg2=tf(ss(A+B*F1-K2*C, K2, -F1,0));
Reg3=tf(ss(A+B*F1-K3*C, K3, -F1,0));
Reg4=tf(ss(A+B*F1-K4*C, K4, -F1,0));

disp(' Calcule de Li');

L1=Reg1*G;
L2=Reg2*G;
L3=Reg3*G ;
L4=Reg4*G;

disp(' Calcule de Si');

S1=1/(1+L1);
S2=1/(1+L2);
S3=1/(1+L3);
S4=1/(1+L4);

disp(' Calcule de Si');

Tub1 = L1*S1;
Tub2 = L2*S2;
Tub3 = L3*S3;
Tub4 = L4*S4;

%------------

% disp('Les marges de stabilite');
% disp('Li');
% figure(71); margin(L1);
% figure(72); margin(L2);
% figure(73); margin(L3);
% figure(74); margin(L4);
% 
disp('c/ Tracer les reponses frequentielles et temporelles');

disp('Nyquist de Li');
figure(10);
nyquist(Lc1,L1,L2,L3,L4,u1,u0)
% grid
% 
% disp('Si');
% figure(8);
% bodemag(Sc1,S1,S2,S3,S4)
% grid
% 
% disp('les reponse temporelles de S')
% figure(82)
% step(Sc1,S1,S2,S3,S4)
% grid
% 
% disp('Tubi');
% figure(9);
% bodemag(Tubc1,Tub1,Tub2,Tub3,Tub4)
% 
% figure(10);
% bodemag(Kc1,Reg1,Reg2,Reg3,Reg4)




disp('Etude de precompensateur')
disp('precompensateur statique')
precomp_stat = 1/0.175 ;
disp('precompensateur dynamyque')
% Le systeme en boucle ouvert G = k(s+c)/(s+a)/(s+b)^2
K1_ = 1+F1*inv(s*eye(3,3)-A+K1*C-B*F1)*B; K1_=minreal(K1_,0.0001);
Tr = Tc1/3;
Gm = 1/(Tr*s+1)^3;
k = Gm/K1_/(S1*G)
