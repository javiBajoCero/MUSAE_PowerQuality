function Prog2

% Given a sinusoidal voltage generator (230 V at f = 50 Hz) feeding through an impedance (Z = R + j·XL = 0.1 + j·1.5 Ω at f = 50 Hz) to a nonlinear load whose consumed current 
% is provided (file Fmonof.txt), and whose harmonic spectrum of said current is also given, determine the voltage uL across the load terminals and compare it with the generator 
% voltage u by plotting both voltages. Additionally, calculate the total harmonic distortion and individual harmonic distortions of voltage uL. 
% Also, plot the current i consumed by the nonlinear load.

clear all
close all
clc
f = 50;
w = 2 * pi * f;

% Generator voltage (pure sinusoidal at f = 50 Hz).
U = 230 * exp(1j * 0);

% Installation impedance (at f = 50 Hz).
R = 0.1;
XL = 1.5; 

% Reading the current consumed by the nonlinear load.
y = load('Fmonof.txt');

% Time (from 0 to 20 ms).
t = y(:, 1); 
% Data vector size.
N = length(t); 
% Current.
corr = y(:, 3); 

% Fourier series expansion of the current (from the fundamental wave to the 39th harmonic).
k = (1 + 1):1:40;
fft_compl_0 = fft(corr);
fft_parc_0 = fft_compl_0(k);
Ief = (1/sqrt(2)) * (2/N) * abs(fft_parc_0);
PHIInrad = angle(fft_parc_0);

% Constructing a Load Voltage (uL) by converting phasors into time domain. 
uL_final = zeros(size(t));
uL_mag = zeros(1, 39);

for i=1:39
Z(i)= R + 1j*XL*i;
I(i)=Ief(i)*exp(1j * PHIInrad(i));
    if i==1
    uL(i) = U - (I(i)*(Z(i))); % for fundamental component 
    else 
    uL(i) = -(I(i)*(Z(i)));    % for harmonic components 
    end
uL_mag(i)= abs(uL(i)); % magnitude 
uL_angle(i) = angle(uL(i)); % angle 
uL_final=uL_final+(sqrt(2)*uL_mag(i)*cos((2*pi*f*i*t)+uL_angle(i))); % reconstructed waveform  
end 

% Determining the root mean square value of Load Voltage to calculate distortions
uL_eff = (1/sqrt(2))*(2/N)*uL_mag;

% Constructing time domain waveform of Generator Voltage (u)
U_TIME= sqrt(2)*abs(U)*cos(2*pi*f*t);

figure(1)
yyaxis left 
plot(t,uL_final);
hold on;
yyaxis left 
plot(t,U_TIME);
xlabel('Time (ms)');
ylabel('Voltage');
grid on;
yyaxis right 
plot(t, corr);
title('Comparison of Generator Voltage (u) and Load Voltage (uL)');
legend( 'Load Voltage (uL)', 'Generator Voltage (u)', 'Load Current (i)');

%Total Harmonic Distortion (THD) and Individual Harmonic Distortion (IHD) of Load Voltage(uL)%

THD= 100*(sqrt(sum(uL_eff(2:end).^2)))/uL_eff(1);
fprintf('THD: %.2f %%\n', THD);

IHD = 100*uL_eff(1:end)/uL_eff(1); 
%displaying odd harmonics 
for n= 1:2:39  
fprintf('IHD(odd harmonics): %.2f %%\n', IHD(n));
end