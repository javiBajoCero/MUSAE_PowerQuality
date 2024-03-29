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
subplot(3,2,1);                     %divide the window to accomodate various plots, select the first division
yyaxis left                         %activate the right axis of the first plot
plot(t(1:size(t)),u(1:size(t)));    %plot data, volts and time
ylabel('[Volts]');                  %name the plot's left vertical axis
title('Fmonof Voltage and Current');%name the plot
yyaxis right;                       %activate the left axis of the first plot
plot(t(1:size(t)),corr(1:size(t))); %plot data, current and time
xlabel('[seconds]');                %name the plot's horizontal axis
ylabel('[Amperes]');                %name the plot's right vertical axis

subplot(3,2,2);                                 %the same all over again bu with different plot data
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
U_HDx_Ldesc=100*Uef_Ldesc./Uef_Ldesc(1);  %the same for Ldesc 

Curr_HDx=100*Ief./Ief(1);                 %entire IRMS array divided by the fundamental harmonic and then times 100.
Curr_HDx_Ldesc=100*Ief_Ldesc./Ief_Ldesc(1);           %the same for Ldesc 

%Calculating Total Harmonic distortions THD:
Uef_squared=Uef.*Uef;                                   % square the Uef array
Ief_squared=Ief.*Ief;                                   % the same with Ief
THD_Uef=100*(sqrt(sum(Uef_squared(2:end))))/Uef(1); % calculate THD, not including the fundamental component (harmonic order 1)
THD_Ief=100*(sqrt(sum(Ief_squared(2:end))))/Ief(1); % the same with Ief
fprintf('THDv Fmonof= %f [percent].\n',THD_Uef);
fprintf('THDi Fmonof= %f [percent].\n',THD_Ief);

Uef_squared_Ldesc=Uef_Ldesc.*Uef_Ldesc;                     %the same for Ldesc 
Ief_squared_Ldesc=Ief_Ldesc.*Ief_Ldesc;
THD_Uef_Ldesc=100*(sqrt(sum(Uef_squared_Ldesc(2:end))))/Uef_Ldesc(1);
THD_Ief_Ldesc=100*(sqrt(sum(Ief_squared_Ldesc(2:end))))/Ief_Ldesc(1);
fprintf('THDv Ldesc= %f [percent].\n',THD_Uef_Ldesc);
fprintf('THDi Ldesc= %f [percent].\n',THD_Ief_Ldesc);

%%RMS values: all signals have a Dc component =0 so we can work with previous arrays.
Urms=sqrt(sum(Uef_squared));
Irms=sqrt(sum(Ief_squared));
fprintf('Urms Fmonof= %f [V].\n',Urms);
fprintf('Irms Fmonof= %f [A].\n',Irms);

Urms_Ldesc=sqrt(sum(Uef_squared_Ldesc));% the same for Ldesc
Irms_Ldesc=sqrt(sum(Ief_squared_Ldesc));
fprintf('Urms Ldesc= %f [V].\n',Urms_Ldesc);
fprintf('Irms Ldesc= %f [A].\n',Irms_Ldesc);

%%active power P [w]
P=sum((Uef.*Ief).*cos(PHIInrad));
P_Ldesc=sum((Uef_Ldesc.*Ief_Ldesc).*cos(PHIInrad_Ldesc));
fprintf('P Fmonof= %f [W].\n',P);
fprintf('P Ldesc= %f [W].\n',P_Ldesc);

%%apparent power S = Urms+Irms [va]
S=Urms*Irms;
S_Ldesc=Urms_Ldesc*Irms_Ldesc;
fprintf('S Fmonof= %f [VA].\n',S);
fprintf('S Ldesc= %f [VA].\n',S_Ldesc);

%power factor
PF=P/S;
PF_Ldesc=P_Ldesc/S_Ldesc;
fprintf('PF, Power factor Fmonof= %f .\n',PF);
fprintf('PF, Power factor Ldesc= %f .\n',PF_Ldesc);

%plot results
subplot(3,2,3);                                 %divide the window to accomodate various plots, select the third division
U_HDx(1)=0;                                     %override to 0 the first harmonic
bar(U_HDx);                                     %bar plot
title('Fmonoff Voltage Harmonic Distortions (1st harmonic forced to 0)');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:5);
grid on;

subplot(3,2,4);                                 %divide the window to accomodate various plots, select the forth division
U_HDx_Ldesc(1)=0;                               %override to 0 the first harmonic
bar(U_HDx_Ldesc);                               %bar plot
title('Ldesc Voltage Harmonic Distortions (1st harmonic forced to 0)');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:5);
grid on;

subplot(3,2,5);                                 %divide the window to accomodate various plots, select the fifth division
Curr_HDx(1)=0;                                  %override to 0 the first harmonic        
bar(Curr_HDx);                                  %bar plot
title('Fmonoff Current Harmonic Distortions (1st harmonic forced to 0)');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:40);
grid on;

subplot(3,2,6);                                 %divide the window to accomodate various plots, select the sixth division
Curr_HDx_Ldesc(1)=0;                            %override to 0 the first harmonic    
bar(Curr_HDx_Ldesc);                            %bar plot
title('Ldesc Current Harmonic Distortions (1st harmonic forced to 0)');
xlabel('[Harmonic number]'); 
ylabel('[%]');
xticks(1:40);
grid on;