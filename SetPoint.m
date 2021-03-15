
clearvars;
close all

rho = 1;
<<<<<<< Updated upstream
s = 10^15; % sigma
=======
gamma = 1;
s = 10000000000; % sigma
>>>>>>> Stashed changes

A = [0 1 0; 0 -.875 -20; 0 0 -50];
B = [0 0 50]';
C = [1 0 0;]; %scelta da noi
D = 0; %scelta da noi

x0 = [1 1 1];

Ps = ss(A,B,C,D); % Sistema di partenza
P = tf(Ps);

G = [1 0 0];
H = 0;
Qc = G'* G;
Rc = H'* H + rho;


Kc = lqr(A,B,Qc,Rc);
L = ss(A,B,Kc,0); %Sistema con Feedback di stato

<<<<<<< Updated upstream
% inversa = inv([A B; G H]);
inversa = [A B; G H] \ [0 0 0 1]';
=======
inversa = [A B; G H]\[0 0 0 1]';
>>>>>>> Stashed changes
F = inversa(1:3);
N = inversa(end);

%% Output Feedback con SetPoint

Bbar = B;

<<<<<<< Updated upstream
K = ss(A-Kf*C-B*Kc,Kf,-Kc,0); %Sistema con output feedback
L0 = K * Ps;
=======
Kf = lqe(A,Bbar,G,s,1);

Ak = A-Kf*G-B*Kc;

K = ss(Ak,Kf,-Kc,0); %Sistema con output feedback
L0 = Ps*K;
>>>>>>> Stashed changes
L0 = minreal(L0);
bode(L,L0)
