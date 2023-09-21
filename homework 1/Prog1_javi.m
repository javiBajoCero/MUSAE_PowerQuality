%
% Dada la tensión u en bornes de una carga no lineal, la intensidad i que consume
% y sus respectivos desarrollos de Fourier,
%
% 1) Reconstruir las formas de onda de dicha tensión e intensidad y compararlas
% con las de origen (es decir con las proporcionadas como dato).
%
% 2) Calcular sus distorsiones armónicas individuales y totales, su valor eficaz,
% la potencia activa y la potencia aparente que consume la carga no lineal,
% así como su factor de potencia.
%
clear all
close all
clc
f=50;
w=2*pi*f;
%
% Lectura de tension e intensidad.
%
y=load('Fmonof.txt');

t=y(:,1); % Tiempo (de 0 a 20ms).
N=length(t); % Dimension del vector de datos.
u=y(:,2); % Tension.
corr=y(:,3); % Intensidad.

%
% Desarrollo de Fourier de la tension y de la intensidad.
%
% TENSION
%
% Rutina de MATLAB para hacer el desarrollo.
%
fft_compl_0=fft(u);
% 
% Seleccion de los 40 primeros armonicos empezando por la posicion 2 que
% corresponde a la onda fundamental (la posicion 1 es el valor de continua)
% y hasta la posicion 40 que corresponde al armonico 39.
%
k=(1+1):1:40;
fft_parc_0=fft_compl_0(k);
%
% Determinacion del valor eficaz y la fase.
%
Uef=(1/sqrt(2))*(2/N)*abs(fft_parc_0);
PHIUrad=angle(fft_parc_0);
%
% INTENSIDAD
%
fft_compl_0=fft(corr);
fft_parc_0=fft_compl_0(k);
Ief=(1/sqrt(2))*(2/N)*abs(fft_parc_0);
PHIInrad=angle(fft_parc_0);


%% ALL CODE HIGHER THAN THIS MARK REMAINS UNCHANGED

    %%the same way we loaded Fmonof.txt now we load Ldesc.txt, code copypasted
    %%from above with different variable names.
    y_Ldesc=load('Ldesc.txt');      % load txt file into a matlab variable
    t_Ldesc=y_Ldesc(:,1);           % Tiempo (de 0 a 20ms).
    N_Ldesc=length(t);              % Dimension del vector de datos.
    u_Ldesc=y_Ldesc(:,2);           % Tension.
    corr_Ldesc=y_Ldesc(:,3);        % Intensidad.

%% 1)Plotting waves
subplot(1,2,1);                     %divide the window to accomodate various plots, select the first division
yyaxis left                         %activate the right axis of the first plot
plot(t(1:size(t)),u(1:size(t)));    %plot data, volts and time
ylabel('[Volts]');                  %name the plot's left vertical axis
title('Fmonof Voltage and Current');%name the plot
yyaxis right;                       %activate the left axis of the first plot
plot(t(1:size(t)),corr(1:size(t))); %plot data, current and time
xlabel('[seconds]');                %name the plot's horizontal axis
ylabel('[Amperes]');                %name the plot's right vertical axis

subplot(1,2,2);                                 %the same all over again bu with different plot data
yyaxis left                                    
plot(t_Ldesc(1:size(t)),u_Ldesc(1:size(t)));    
ylabel('[Volts]');                              
title('Ldesc Voltage and Current');
yyaxis right
plot(t_Ldesc(1:size(t)),corr_Ldesc(1:size(t)));
xlabel('[seconds]'); 
ylabel('[Amperes]');

%%  2)Individual Harmonic distortions, total Harmonic distortion, RMS value, Active Power, apparent Power and Power factor.

%fourier calculations for Ldesc, copied from above with different variable names

    %
    % Desarrollo de Fourier de la tension y de la intensidad.
    %
    % TENSION
    %
    % Rutina de MATLAB para hacer el desarrollo.
    %
    fft_compl_0_Ldesc=fft(u_Ldesc);
    % 
    % Seleccion de los 40 primeros armonicos empezando por la posicion 2 que
    % corresponde a la onda fundamental (la posicion 1 es el valor de continua)
    % y hasta la posicion 40 que corresponde al armonico 39.
    %
    k_Ldesc=(1+1):1:40;
    fft_parc_0_Ldesc=fft_compl_0(k_Ldesc);
    %
    % Determinacion del valor eficaz y la fase.
    %
    Uef_Ldesc=(1/sqrt(2))*(2/N)*abs(fft_parc_0_Ldesc);
    PHIUrad_Ldesc=angle(fft_parc_0_Ldesc);
    %
    % INTENSIDAD
    %
    fft_compl_0_Ldesc=fft(corr_Ldesc);
    fft_parc_0_Ldesc=fft_compl_0(k_Ldesc);
    Ief=(1/sqrt(2))*(2/N)*abs(fft_parc_0_Ldesc);
    PHIInrad_Ldesc=angle(fft_parc_0_Ldesc);
