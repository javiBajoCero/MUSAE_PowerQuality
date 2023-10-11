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

Zeq= (Zeq_line.*Zeq_filter)./(Zeq_line+Zeq_filter); %both previous Zeq-... in pararell

Ksr =sqrt(XCF/XLF); %series resonance

fprintf('Ksr3 resonance series (relative to fundamental harmonic) : %.2f \n', Ksr);

hold on;
plot (k,abs(Zeq));
title('Zeq for each harmonic');
ylabel('Z (ohms)');
xlabel('k (harmonic number)');

%% now for value of K right below 5
h=4.95;
XLF=XCF/h^2; % Reactancia de la bobina del filtro.
RF=XLF*h/q; % Resistencia del filtro.

 XL=XLF*0.1; % Reactancia inductiva de la linea.
 R=XL*0.05; % Resistencia de la linea.

k=1:0.1:2*h;


Zeq_line= R + 1j*k*XL;                      %a resistance and inductance

Zeq_filter= RF + 1j*k*XLF -1j*XCF./k;       %resistance inductance and capacitance

Zeq_k5= (Zeq_line.*Zeq_filter)./(Zeq_line+Zeq_filter); %both previous Zeq-... in pararell

Ksr =sqrt(XCF/XLF); %series resonance

fprintf('Ksr5 resonance series (relative to fundamental harmonic) : %.2f \n', Ksr);

plot (k,abs(Zeq_k5));

%% now for value of K right below 7
h=6.95;
XLF=XCF/h^2; % Reactancia de la bobina del filtro.
RF=XLF*h/q; % Resistencia del filtro.

 XL=XLF*0.1; % Reactancia inductiva de la linea.
 R=XL*0.05; % Resistencia de la linea.

k=1:0.1:2*h;


Zeq_line= R + 1j*k*XL;                      %a resistance and inductance

Zeq_filter= RF + 1j*k*XLF -1j*XCF./k;       %resistance inductance and capacitance

Zeq_k7= (Zeq_line.*Zeq_filter)./(Zeq_line+Zeq_filter); %both previous Zeq-... in pararell

Ksr =sqrt(XCF/XLF); %series resonance

fprintf('Ksr7 resonance series (relative to fundamental harmonic) : %.2f \n', Ksr);

plot (k,abs(Zeq_k7));