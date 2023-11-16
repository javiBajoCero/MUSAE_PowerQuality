clear;
clc;

N = 10000;

for i = 1:N
    data(i,1) = rand*20000;
    data(i,2) = rand*50000;
end

subplot(3,1,1);
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

y_loc = 25000;



for i = 1:1:N
    data(i,1) = rand*20000; % x
    data(i,2) = rand*50000; % y
    data(i,3) = lognrnd(mu,sigma); %random log normal distribution
    data(i,4) = c/(sqrt(1+(500/data(i,3)))); %return stroke

    test(i,1) = log(data(i,3)); % log (I) to calculate
    
    %check if not a direct strike


    d(i,1) = abs(y_loc - data(i,2));

    data(i,5) = 30*(1+(data(i,4)/c)/sqrt(2-(data(i,4)/c)^2))*(h*data(i,3)/d(i,1)); %overvoltage value for each strike
    test(i,2) = log(data(i,5)); 
end

%plot histogram to see log normal distribution


subplot(3,1,2);
plot(d(:,1),data(:,5),'b. ');
xlabel('distance ')
ylabel('overvoltage (m)')

subplot(3,1,3);
plot(data(:,3),data(:,5),'b. '); % doesnt make a lot of sense because also depends of DISTANCE so , if there is a grat induced overvoltage it could be that its just too close to the power line
xlabel('Current lightning')
ylabel('overvoltage (m)')

% subplot(3,1,3);
% plot(data(:,3)./d(:,1),data(:,5),'b. '); % doesnt make a lot of sense because also depends of DISTANCE so , if there is a grat induced overvoltage it could be that its just too close to the power line
% xlabel('Current lightning')
% ylabel('overvoltage (m)')






