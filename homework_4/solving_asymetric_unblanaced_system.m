clc;
close all;
clear;  
f=50; 
w=2*pi*f;
% Tensiones sinusoidales asimetricas y desequilibradas. 
Ua=230*exp(1j*0);
Ub=0.8*230*exp(1j*(-110*pi/180)); 
Uc=0.9*230*exp(1j*(100*pi/180));
%%
%What to do:
% draw this sin functions
% Time (from 0 to 20 ms).
t = 0:0.02/100:0.02; 
U_a_TIME= sqrt(2)*abs(Ua)*cos(2*pi*f*t +angle(Ua));
U_b_TIME= sqrt(2)*abs(Ub)*cos(2*pi*f*t +angle(Ub));
U_c_TIME= sqrt(2)*abs(Uc)*cos(2*pi*f*t +angle(Uc));
hold on;
plot(U_a_TIME);plot(U_b_TIME);plot(U_c_TIME);
hold off;

% fortesqueu decomposition
a=exp(1j*(2*pi/3));
F           =[1 1 1; 1 a*a a; 1 a a*a];
Finversed   =(1/3).*[1 1 1; 1 a a*a; 1 a*a a];
Uabc=[Ua ;Ub ;Uc];

U012=Finversed*Uabc;

U0=U012(1);%U0 not 0 unbalanced
U1=U012(2);%U1 and U2 not 0 asymetric.
U2=U012(3);

%check if U012 was calculated alright
recalculatedUa=U0+U1       +U2;
recalculatedUb=U0+a*a*U1   +a*U2;
recalculatedUc=U0+a*U1     +a*a*U2;

%check Ka and Ku
ka = abs(U2)/abs(U1)*100%[%]
Ku = abs(U0)/abs(U1)*100%[%]

