%% Parameteres:
m=0.5; M=5; L=1; g=9.8;

%% 1) The Model and its eig's:
A = [0          1 0 0
    g*(m+M)/M/L 0 0 0
    0           0 0 1
    -m*g/M      0 0 0];

B = [0 ; -1/M/L; 0; 1/M];

C= [1 0 0 0
    0 0 1 0]; Ci = eye(4); 

D = [0;0]; Di = [0; 0; 0; 0];
% The eig's:
g =ss(A,B,C,D);
eig(A);
pole(g)

%% 2) Commandability 
% the commandability Matrix Cm
Cm = [B A*B A*A*B A*A*A*B];
Commandability =rank(Cm)
p1 = -1+i; p2 =-1-i; p3 = 2*p1; p4=2*p2;
P = [p1,p2,p3,p4];
F = acker(A,B,P)
%ctrb et ctrbf

%% 3) the observability:
Ob = [C ;C*A ;C*A*A ;C*A*A*A];
observablity = rank(Ob);
po1 = -100+i; po2 =-100-i; po3 = 200*po1; po4=200*p2;
Po = [po1,po2,po3,po4];
K = place(A',C',Po)'
K_ = place(A',C',P)'
X0 = [0.3 0 0.1 0]';

%% 5) The tranfer function of the looped system:
Ab=A-B*F;
s = tf('s');
G=C*inv(s*eye(4,4)-Ab)*B;    %% G[consign:position](s=0)=-31.36/256 then we take 
K2=  -256/31.36
