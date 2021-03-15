close all
clearvars

rho = 1;

A = [-0.0558 -0.9968 0.0802 0.0415; 0.5980 -0.1150 -0.0318 0; -3.0500 0.3880 -0.4650 0; 0 0.0805 1 0];
B = [0.0729 0; -4.7500 0.00775; 0.153 0.143; 0 0];
C = [1 0 0 0; 0 0 0 1];
D = 0;

P = ss(A,B,C,D);
% figure, impulse(P,20)

% G = [1 0 0; 0 gamma*1 0];
% H = [0 0]';
Q = C'* C; 
R = rho;

Ccal = ctrb(A,B);
Ocal = obsv(A,C);

if length(A) == rank(Ccal) && length(A) == rank(Ocal)
    fprintf("Il sitema è contr e oss completamente \n");
end 

Kc = lqr(A,B,Q,R);
LssFs = ss(A,B,Kc,0);


C

