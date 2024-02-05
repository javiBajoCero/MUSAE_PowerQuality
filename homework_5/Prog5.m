function Prog5
%
% Identificar el tipo y las caracteristicas (tiempo de inicio, duracion
% y profundidad) del hueco de tension generado por el programa.
% Generar un hueco de tension de tipo E con tiempo de inicio 30 ms,
% duracion 40 ms y profundidad 80 %.
%
clear all
close all
f=50;
w=2*pi*f;
%
% Tensiones sinusoidales sin hueco.
%
Ua=230*exp(1j*0);
Ub=230*exp(1j*(-120*pi/180));
Uc=230*exp(1j*(120*pi/180));
%
% Tensiones sinusoidales con hueco.
%
h=0.7;
Uah=h*230*exp(1j*0);
Ubh=230*exp(1j*(-120*pi/180));
Uch=230*exp(1j*(120*pi/180));
%
% Se dibujan.
%
t = linspace(0, 4*(1/f), 1000);
va=zeros(length(t),1);
vb=zeros(length(t),1);
vc=zeros(length(t),1);

for k=1:length(t)
    if t(k) < (1/f)
        va(k) = sqrt(2)*abs(Ua)*cos((w*t(k))+angle(Ua));
        vb(k) = sqrt(2)*abs(Ub)*cos((w*t(k))+angle(Ub));
        vc(k) = sqrt(2)*abs(Uc)*cos((w*t(k))+angle(Uc));
    end
    if t(k) > (1/f) && t(k) < 2.5*(1/f)    
        va(k) = sqrt(2)*abs(Uah)*cos((w*t(k))+angle(Uah));
        vb(k) = sqrt(2)*abs(Ubh)*cos((w*t(k))+angle(Ubh));
        vc(k) = sqrt(2)*abs(Uch)*cos((w*t(k))+angle(Uch));
    end
    if t(k) > 2.5*(1/f)
        va(k) = sqrt(2)*abs(Ua)*cos((w*t(k))+angle(Ua));
        vb(k) = sqrt(2)*abs(Ub)*cos((w*t(k))+angle(Ub));
        vc(k) = sqrt(2)*abs(Uc)*cos((w*t(k))+angle(Uc));
    end
end

figure(1)
plot(t,va,'k')
hold on
plot(t,vb,'r')
plot(t,vc,'g')
title("type B voltage sag, 1.5cycles long (30ms) , 70% depth");



%
% hueco de tension de tipo E con tiempo de inicio 30 ms,
% duracion 40 ms y profundidad 80 %.%
h=0.8;
Uah=230*exp(1j*0);
Ubh=h*230*exp(1j*(-120*pi/180));
Uch=h*230*exp(1j*(120*pi/180));

initTime=0.030;
sagdurationTime=initTime+0.040;

for k=1:length(t)
    if t(k) < initTime
        va(k) = sqrt(2)*abs(Ua)*cos((w*t(k))+angle(Ua));
        vb(k) = sqrt(2)*abs(Ub)*cos((w*t(k))+angle(Ub));
        vc(k) = sqrt(2)*abs(Uc)*cos((w*t(k))+angle(Uc));
    end
    if t(k) > initTime && t(k) < sagdurationTime  
        va(k) = sqrt(2)*abs(Uah)*cos((w*t(k))+angle(Uah));
        vb(k) = sqrt(2)*abs(Ubh)*cos((w*t(k))+angle(Ubh));
        vc(k) = sqrt(2)*abs(Uch)*cos((w*t(k))+angle(Uch));
    end
    if t(k) > sagdurationTime
        va(k) = sqrt(2)*abs(Ua)*cos((w*t(k))+angle(Ua));
        vb(k) = sqrt(2)*abs(Ub)*cos((w*t(k))+angle(Ub));
        vc(k) = sqrt(2)*abs(Uc)*cos((w*t(k))+angle(Uc));
    end
end

figure(2)
plot(t,va,'k')
hold on
plot(t,vb,'r')
plot(t,vc,'g')
title("type E voltage sag, 40ms long , 80% depth");