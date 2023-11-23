clear;
clc;

N = 10000;

for i = 1:N
    data(i,1) = rand*20000;
    data(i,2) = rand*50000;
end

subplot(6,1,1);
plot(data(:,1),data(:,2),'b. ');
xlabel('Lon (m)')
ylabel('Lat (m)')

%calc stats
mediaX = mean(data(:,1));
medianaX = median(data(:,1));
mediaY = mean(data(:,2));
medianaY = median(data(:,2));

%calc ground flash density

%lightning current dis
mu=log(27.7); %peak current value > for any LLC
sigma=0.461; % standadr deviation

c = 3e8; %sp of light

%calc overvoltages due to near strike

h = 15; %(m)

%power line location in horizontal plane
x_loc = 10000;%now we do an specific point
y_loc = 25000;



for i = 1:1:N
    data(i,1) = rand*20000; % x
    data(i,2) = rand*50000; % y
    data(i,3) = lognrnd(mu,sigma); %random log normal distribution of the lightning peak current
    data(i,4) = c/(sqrt(1+(500/data(i,3)))); %return stroke speed.

    test(i,1) = log(data(i,3)); % log (I) to calculate
    
    %check if not a direct strike


    d(i,1) = sqrt((x_loc-data(i,1))^2 +(y_loc-data(i,2))^2);%distance of the overvoltage, now from a single point

    data(i,5) = 30*(1+(data(i,4)/c)/sqrt(2-(data(i,4)/c)^2))*(h*data(i,3)/d(i,1)); %overvoltage value for each strike
    test(i,2) = log(data(i,5)); 
end


% current statistics
median_I=median(data(:,3));
std_I=std(test(:,1));

%overvoltage stats
median_U=median(data(:,5));
std_U=std(test(:,2));

i=1;
for U=0.0001:0.05:500 %distribution value of the stress curve, we choose 500KW but we could choose more than that, it will chop the infinit""" distribution 
    P_U(i,1)=U;
    z=log(U/median_U)/std_U;
    P_U(i,2)= (1/(std_U*U*sqrt(2*pi)))*exp(-1*(z^2)/2);
    i=i+1;
end

%cumulative distribution function, not used a lot
[fil,col]=size(P_U);%get size of P_U, use the size as index
acc(1,1)=0;
j=2;
for i=2:1:fil
    acc(j,1)=acc(j-1,1)+P_U(i,2)*(P_U(i,1)-P_U(i-1,1));
    j=j+1;
end

%k=1.8 b=10 c=4 parameter of weibull distribution (shape and scale)

i=1;
for U=0.0001:0.05:500 %i believe this is the isulation curve somehow
    Pt_U(i,1)=U;
    Pt_U(i,2)= (1/(1+exp(-1.8*((U/10)-4))));
    i=i+1;
end

%calculation of risk, convolution
[fil,col]=size(P_U);
risk=0;
deltaU= (P_U(2,1)-P_U(1,1));
for i=1:fil
    risk=risk + (P_U(i,2)*Pt_U(i,2))*deltaU;
end

risk

%plot histogram to see log normal distribution
subplot(6,1,2);
plot(d(:,1),data(:,5),'b. ');
xlabel('distance ')
ylabel('overvoltage (m)')

subplot(6,1,3);
plot(data(:,3),data(:,5),'b. '); % doesnt make a lot of sense because also depends of DISTANCE so , if there is a grat induced overvoltage it could be that its just too close to the power line
xlabel('Current lightning')
ylabel('overvoltage (m)')


subplot(6,1,4);%non intuitive
hold on
plot(P_U(:,1),P_U(:,2),'k'); % doesnt make a lot of sense because also depends of DISTANCE so , if there is a grat induced overvoltage it could be that its just too close to the power line
hold on
plot(Pt_U(:,1),Pt_U(:,2),'r'); %insulation curve? he calls it strength
xlabel('impulse voltage (KW)')
ylabel('flashover probability')
legend('stress','strength or isulation level');
hold off

