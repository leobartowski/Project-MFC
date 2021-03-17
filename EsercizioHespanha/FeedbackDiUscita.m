clearvars;
close all

gamma = 1;
rho = 1;
s = 1000000; % sigma

A = [0 1 0; 0 -.875 -20; 0 0 -50];
B = [0 0 50]';
C = [1 0 0]; %scelta da noi
D = 0; %scelta da noi

x0 = [pi/2 0 0];

Ps = ss(A,B,C,D); % Sistema di partenza
P = tf(Ps);

G = [1 0 0; 0 gamma*1 0];
H = [0 0]';
Qc = G'* G;
Rc = H'* H + rho;


Kc = lqr(A,B,Qc,Rc);
L = ss(A,B,Kc,0); %Sistema con Feedback di stato


Bbar = B;
Rf = 1;
Qf = s * 1000;
Kf = lqe(A,Bbar,C,Qf,Rf);

K = ss(A-B*Kc-Kf*C,Kf,-Kc,0); %Sistema con output feedback
LOss = Ps * K;
LOss = minreal(LOss);

% sigma(L,K*Ps)
% figure, impulse(L, L0)
bode(L, LOss)
