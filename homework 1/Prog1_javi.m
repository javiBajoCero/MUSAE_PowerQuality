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
clear
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
subplot(4,2,1);                     %divide the window to accomodate various plots, select the first division
yyaxis left                         %activate the right axis of the first plot
plot(t(1:size(t)),u(1:size(t)));    %plot data, volts and time
ylabel('[Volts]');                  %name the plot's left vertical axis
title('Fmonof Voltage and Current');%name the plot
yyaxis right;                       %activate the left axis of the first plot
plot(t(1:size(t)),corr(1:size(t))); %plot data, current and time
xlabel('[seconds]');                %name the plot's horizontal axis
ylabel('[Amperes]');                %name the plot's right vertical axis

subplot(4,2,2);                                 %the same all over again bu with different plot data
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
    fft_parc_0_Ldesc=fft_compl_0_Ldesc(k_Ldesc);
    %
    % Determinacion del valor eficaz y la fase.
    %
    Uef_Ldesc=(1/sqrt(2))*(2/N_Ldesc)*abs(fft_parc_0_Ldesc);
    PHIUrad_Ldesc=angle(fft_parc_0_Ldesc);
    %
    % INTENSIDAD
    %
    fft_compl_0_Ldesc=fft(corr_Ldesc);
    fft_parc_0_Ldesc=fft_compl_0_Ldesc(k_Ldesc);
    Ief_Ldesc=(1/sqrt(2))*(2/N_Ldesc)*abs(fft_parc_0_Ldesc);
    PHIInrad_Ldesc=angle(fft_parc_0_Ldesc);

%calculating individual Harmonic distortions HDx:
U_HDx=100*Uef./Uef(1);                    %entire VRMS array divided by the fundamental harmonic and then times 100.
Curr_HDx=100*Ief./Ief(1);                 %entire IRMS array divided by the fundamental harmonic and then times 100.
U_HDx_Ldesc=100*Uef_Ldesc./Uef_Ldesc(1);  %the same for Ldesc 
Curr_HDx_Ldesc=100*Ief./Ief(1);

%Calculating Total Harmonic distortions THD:
Uef_squared=Uef(1:end).*Uef(1:end);                     % square the Uef array
Ief_squared=Ief(1:end).*Ief(1:end);                     % the same with Ief
THD_Uef=100*sqrt(sqrt(sum(Uef_squared(2:end))))/Uef(1); %calculate THD, mind the fundamental component
THD_Ief=100*sqrt(sqrt(sum(Ief_squared(2:end))))/Ief(1); % the same with Ief

Uef_squared_Ldesc=Uef_Ldesc(1:end).*Uef_Ldesc(1:end);                     %the same for Ldesc 
Ief_squared_Ldesc=Ief_Ldesc(1:end).*Ief_Ldesc(1:end);
THD_Uef_Ldesc=100*sqrt(sqrt(sum(Uef_squared_Ldesc(2:end))))/Uef_Ldesc(1);
THD_Ief_Ldesc=100*sqrt(sqrt(sum(Ief_squared_Ldesc(2:end))))/Ief_Ldesc(1);


%plot results
subplot(4,2,3);                                 %divide the window to accomodate various plots, select the third division
bar(U_HDx(1:end));                              %bar plot
title('Fmonoff Voltage Harmonic Distortions');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:5);
grid on;

subplot(4,2,4);                                 %divide the window to accomodate various plots, select the forth division
bar(U_HDx_Ldesc(1:end));                        %bar plot
title('Ldesc Voltage Harmonic Distortions');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:5);
grid on;

subplot(4,2,5);                                 %divide the window to accomodate various plots, select the fifth division
bar(Curr_HDx(1:end));                           %bar plot
title('Fmonoff Current Harmonic Distortions');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:40);
grid on;

subplot(4,2,6);                                 %divide the window to accomodate various plots, select the sixth division
bar(Curr_HDx_Ldesc(1:end));                     %bar plot
title('Ldesc Current Harmonic Distortions');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:40);
grid on;