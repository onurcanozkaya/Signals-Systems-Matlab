clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Onur Can Ozkaya %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

lowerBound = 0;
upperBound = 4;
T1 = 1;
T2 = 2;
T3 = 4;
T = 4;
dt = 0.001;

t1 = 0 : dt : T1;
t2 = T1 : dt : T2 - dt;
t3 = T2 : dt: T3;


x1 = sawtooth(2*pi*t1);
x2 = sawtooth(2*pi*t2);
x3 = 0.5 * sin(pi*t3);

t = [t1 t2 t3];
x = [x1 x2 x3];

ck = fsc(x, 1000, T, dt, t);

x_5 = approximation(x, 5, T, dt, t);
x_50 = approximation(x, 50, T, dt, t);
x_500 = approximation(x, 500, T, dt, t);

figure(1)
subplot(411);
plot(t,x,'LineWidth',2);
grid on;
title('Original');
subplot(412);
plot(t,x_5,'LineWidth',2);
grid on;
title('M=5');
subplot(413);
plot(t,x_50,'LineWidth',2);
grid on;
title('M=50');
subplot(414);
plot(t,x_500,'LineWidth',2);
grid on;
title('M=500');

total = 0;
%% Calculating mean squared errors for each approximation
for t = 1 : length(t)
    total = total + ((x_5(t) - x(t))^2);
    mse1 = total / length(x_5);
end

for t = 1 : length(t)
    total = total + ((x_50(t) - x(t))^2);
    mse2 = total / length(x_50);
end

for t = 1 : length(t)
    total = total + ((x_500(t) - x(t))^2);
    mse3 = total / length(x_500);
end

%% Function to calculate Fourier Series coefficients
function [ck] = fsc(x, M, T, dt, t)
    ck = zeros(2 * M, 1);
    for k = 1 : 2 * M + 1
        ck(k) = (1/T) * sum(x.*exp(-1i * (k - M - 1) * 2*pi/T*t)*dt);
    end
end

%% Function to show Gibbs Phenomena
function [out] = approximation(x, M, T, dt, t)
    ck = fliplr(fsc(x, M, T, dt, t));
    out = 0;
    
    for k = 1 : 2 * M
        out = out + ck(k)*exp(-1i * (k - M - 1) * 2*pi/T*t);
    end
end



