clearvars;
clc

gamma = 1;
rho = 1;
sigma = 1;

A = [0 1 0; 0 -.875 -20; 0 0 -50];
B = [0 0 50]';
C = [1 0 0]; %scelta da noi
D = 0; %scelta da noi

x0 = [1 1 1]';

ss = ss(A,B,C,D);
P = tf(ss);



G = [1 0 0; 0 gamma*1 0];
H = [0 0]';
Qc = G'* G; 
Rc = H'* H + rho;

Kc = lqr(A,B,Qc,Rc);

Bbar = B;
Rf = 1;
Qf = sigma *1;
Kf = lqe(A,Bbar,C,Qf,Rf);
ciro = A-Kf*C-B*Kc;
 ss(ciro,Kf,-Kc,0)
