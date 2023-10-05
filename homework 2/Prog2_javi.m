function Prog2
%
% Dado un generador de tensión sinusoidal (230 V a f = 50 Hz) que alimenta a través
% de una impedancia (Z = R + j·XL = 0.1 + j·1.5 Ω a f = 50 Hz) a una carga no lineal
% cuya corriente consumida es dato (archivo Fmonof.txt) y cuyo espectro armónico
% de dicha corriente también es dato, determinar la tensión uL en bornes de la carga
% y compararla con la tensión u del generador dibujando ambas tensiones. Además,
% calcular la distorsión armónica total y las individuales de la tensión uL. Dibujar
% también la corriente i consumida por la carga no lineal.
%
clear all
close all
clc
f=50;
w=2*pi*f;
%
% Tension del generador (sinusoidal pura a f = 50 Hz).
%
U=230*exp(1j*0);
%
% Impedancia de la instalacion (a f = 50 Hz).
%
R=0.1;
XL=1.5; 
%
% Lectura de la corriente consumida por la carga no lineal.
%
y=load('Fmonof.txt');

t=y(:,1); % Tiempo (de 0 a 20 ms).
N=length(t); % Dimension del vector de datos.
corr=y(:,3); % Corriente.

%
% Desarrollo de Fourier de la corriente (de la onda fundamental hasta el
% armonico 39).
%
k=(1+1):1:40;
fft_compl_0=fft(corr);
fft_parc_0=fft_compl_0(k);
Ief=(1/sqrt(2))*(2/N)*abs(fft_parc_0);
PHIInrad=angle(fft_parc_0);


%% code above this line was not modified

%generating Ug *volts at the generator, pure cosine, supposing U is Vrms
Ug=U*sqrt(2)*cos(t*f*2*pi);

%determine Ul (voltage at the non lineal load), compare it to U (voltage at the
%generator) plotting.
subplot(3,1,1);                     %divide the window to accomodate various plots, select the first division
yyaxis right                        %activate the right axis of the first plot
plot(t(1:size(t)),corr(1:size(t))); %plot data, volts and time
ylabel('[Current]');                %name the plot's left vertical axis
title('i');                         %name the plot
yyaxis left;                        %activate the left axis of the first plot
plot(t(1:size(t)),Ug(1:size(t)));   %plot data, current and time
xlabel('[seconds]');                %name the plot's horizontal axis
ylabel('[Volts]');                  %name the plot's right vertical axis


%Calculate THD and individual HDix for Ul(voltage at the non lineal load)

%plot current i going trought the non lineal load.
