function Prog3
%
% Dada la impedancia de una linea y de un filtro de sintonia, 
% calcular y representar el modulo de la impedancia equivalente del conjunto.
% 
clear all
close all
clc
f=50;
w=2*pi*f;
h=2.95;
q=50;
%
% Datos del circuito.
%
XCF=1.5; % Reactancia del condensador del filtro.
XLF=XCF/h^2; % Reactancia de la bobina del filtro.
RF=XLF*h/q; % Resistencia del filtro.

XL=XLF*0.1; % Reactancia inductiva de la linea.
R=XL*0.05; % Resistencia de la linea.

%
% Espectro armonico a analizar.
%
k=1:0.1:2*h;

%% code above here was not touched

Zeq_line= R + 1j*k*XL;                      %a resistance and inductance

Zeq_filter= RF + 1j*k*XLF -1j*XCF./k;       %resistance inductance and capacitance

Zeq= (Zeq_line+Zeq_filter)./(Zeq_line.*Zeq_filter); %both previous Zeq-... in pararell

plot (k,abs(Zeq))