clearvars;
close all

s = 10000; % sigma

P = tf([1 1],[1 1 1 ]);
Ps = ss(P);

A = Ps.A;
B = Ps.B;
C = Ps.C;
D = Ps.D;

G = [1 0];
H = 0;
Q = G' *1* G;
R = 1;
x0 = [0 0 ]';

% Kc = lqr(A,B,C'*C,R); il prof aveva messo Q poi si trovava uno 0 in Kc e ha
% cambiato mettendo C'* C al posto di Q
Kc = lqr(A,B,C'*C,R);
L = ss(A,B,Kc,0); %Sistema con Feedback di stato

inversa = [A B; C H]\[0 0 1]';
F = inversa(1:2);
N = inversa(end);

%% Output Feedback con SetPoint


Kf = lqe(A,B,C,s,1);

Ak = A-Kf*C-B*Kc;

K = ss(Ak,Kf,-Kc,0); %Sistema con output feedback
L0 = Ps*K;
L0 = minreal(L0);
bode(L,L0)
