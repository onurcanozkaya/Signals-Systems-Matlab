clc       % clearing command window
clear     % clearing workspace
close all % closing all figures

% Sampling period
dt = 25/1000;

time = 0:dt:1;

% Generating causal and symmetric signal x1(t)
a1 = exp(-5*time);
a2 = fliplr(a1);
x1 = a1 + a2;

figure(1)
subplot(411)
plot(time, x1)
grid on;
legend('x_1(t)');
xlabel('Time(sec.)');
ylabel('Amplitude');
title('x_1(t)');

%% Generating 0.5s advanced signal
time_advanced = time - 0.5;
subplot(412)
plot(time_advanced, x1)
grid on;
legend('x_2(t)');
xlabel('Time(sec.)');
ylabel('Amplitude');
title('x_2(t)');

x1_flipped = fliplr(x1);
%% Even Component
xe=0.5*(x1 + x1_flipped);
%% Odd Component
xo=0.5*(x1 - x1_flipped);
%% Plotting
subplot(413);
plot(time_advanced, xe);
grid on;
legend('x_2e(t)');
xlabel('Time(sec.)');
ylabel('Amplitude');
title('Even part of x_2(t)')

subplot(414);
plot(time_advanced,xo);
grid on;
legend('x_2o(t)');
xlabel('Time(sec.)');
ylabel('Amplitude');
title('Odd part of x_2(t)')

%% PART 2
time2=0:dt:0.5;
x3 = exp(-5*time2);
figure(2)
subplot(311)
plot(time2, x3)
grid on;
legend('x_3(t)');
xlabel('Time(sec.)');
ylabel('Amplitude');
title('x_3(t) while x_3(t) = e^-^5^t');

time2_manipulated = (time2) / 2 + 1;
subplot(312)
plot(time2_manipulated, x3);
grid on;
legend('x_4(t)');
xlabel('Time(sec.)');
ylabel('Amplitude');
title('x_4(t) while x_4(t) = x_3(-1+2t)');

%% PART 3 Checking linearity of the system
syms t;
dt3 = 10/1000;
time3 = 0:dt3:1;

f1 = abs(cos(100*pi*time3));
f2 = exp(-5*time3);

o1 = sum(f1);
o2 = sum(f2);

a = 2;
b = 1;

total = a*o1 + b*o2
o3 = sum(a*f1 + b*f2)


f1 = abs(cos(100*pi*t));
f2 = exp(-5*t);

o1 = sum(f1);
o2 = sum(f2);

a = randi(10);
b = randi(10);

% Comparing with symbolic toolbox
total = a*o1 + b*o2
o3 = sum(a*f1 + b*f2)






