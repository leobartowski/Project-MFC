clearvars;
close all
clc

gamma = 1;
rho = 1;
s = 1; % sigma

A = [0 1 0; 0 -.875 -20; 0 0 -50];
B = [0 0 50]';
C = [1 0 0]; %scelta da noi
D = 0; %scelta da noi

x0 = [1 1 1]';

Ps = ss(A,B,C,D);
P = tf(ss);

G = [1 0 0; 0 gamma*1 0];
H = [0 0]';
Qc = G'* G;
Rc = H'* H + rho;


Kc = lqr(A,B,Qc,Rc);
L = ss(A,B,Kc,0);


Bbar = B;
Rf = 1;
Qf = s *1;
Kf = lqe(A,Bbar,C,Qf,Rf);
Ak = A-Kf*C-B*Kc;
K = ss(Ak,Kf,-Kc,0);
L0 = Ps * K;
L0 = minreal(L0);
bode(L, L0)

% for i=1:10000:100000
%     sigma = i;
%     Bbar = B;
%     Rf = 1;
%     Qf = sigma *1;
%     Kf = lqe(A,Bbar,C,Qf,Rf);
%     K = ss(A-Kf*C-B*Kc,Kf,-Kc,0);
%     L0 = Ps * K;
%     L0 = minreal(L0);
%     bode(L0)
%
% end
