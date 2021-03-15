% close all
clearvars

A = [-0.0558 -0.9968 0.0802 0.0415; 0.5980 -0.1150 -0.0318 0; -3.0500 0.3880 -0.4650 0; 0 0.0805 1 0];
B = [0.0729 0; -4.7500 0.00775; 0.153 0.143; 0 0];
C = [1 0 0 0; 0 0 0 1];
D = 0;

x0 = [0 0 0 pi/2];

Ps = ss(A,B,C,D);
% figure, impulse(P,20)

Qbar = 1; % Se Qbar è alto gli stati vanno a 0 prima e pago il controllo, e viceversa se è basso
rho = 1;
Q = C' * Qbar * C; 
R = rho;

Ccal = ctrb(A,B);
Ocal = obsv(A,C);

% if length(A) == rank(Ccal) && length(A) == rank(Ocal)
%     fprintf("Il sitema è contr e oss completamente \n");
% end 

Kc = lqr(A,B,Q,R);
L = ss(A,B,Kc,0);

% figure, impulse(P,LssFs,20), legend('Open Loop', 'LQR')

Bbar = B;
Rf = eye(2);
s = 10; % sigma
Qf = eye(2) * s;

Kf = lqe(A, Bbar, C, Qf, Rf);
K = ss(A-B*Kc-Kf*C,Kf,-Kc,0); %Sistema con output feedback
LOss = Ps * K;
LOss = minreal(LOss);

bodemag(L, LOss), legend('L', 'Loss');