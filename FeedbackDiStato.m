clearvars;
clc

gamma = 1;
rho = 1;

A = [0 1 0; 0 -.875 -20; 0 0 -50];
B = [0 0 50]';
C = [1 0 0; 0 1 0; 0 0 1]; %scelta da noi
D = [0 0 0]'; %scelta da noi
x0 = [1 1 1]';


ss = ss(A,B,C,D);
tf = tf(ss);

G = [1 0 0; 0 gamma*1 0];
H = [0 0]';
Q = G'* G; 
R = H'* H + rho;


Ccal = ctrb(A,B);
Ocal = obsv(A,G);

if length(A) == rank(Ccal) && length(A) == rank(Ocal)
    fprintf("Il sitema è contr e oss completamente \n");
end 

Kc = lqr(A,B,Q,R);

poliOl = eig(A);
poliCl = eig(A-B*Kc); % Poli matrice di trasferimeto a ciclo chiuso con feedback di stato

