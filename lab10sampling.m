clc
close all;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Onur Can Ozkaya %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sampling Frequencies (Fs, Fs1, Fs2)
Fs = 10000;
Fs1 = Fs / 5;
Fs2 = Fs / 50;

% Frequency of the signal
f = 200;
% Duration of the signal
duration = 0.05;
% Original signal
t = -duration : 1/Fs : duration;
% Sampled signals
t1 = -duration : 1/Fs1 : duration;
t2 = -duration : 1/Fs2 : duration;

x = 4 + 3 * cos(2*pi*f*t);
x1 = 4 + 3 * cos(2*pi*f*t1);
x2 =  4 + 3 * cos(2*pi*f*t2);
impulse1 = heaviside(t + 0.055) - heaviside(t - 0.055);
impulse2 = heaviside(t + 0.055) - heaviside(t - 0.055);

for i = 1 : 1001
    if rem(i, 5) ~= 1
        impulse1(i) = nan;
    end

end

for i = 1 : 1001
    if rem(i, 50) ~= 1
        impulse2(i) = nan;
    end

end

figure(1);

subplot(311);
plot(t, x);
xlabel('Time');
title('Sinusoidal Signal');
xlabel('Time(sec.)');

subplot(312);
stem(t, impulse1);
xlabel('Time');
title('First impulse train');
xlabel('Time(sec.)');

subplot(313);
stem(t, impulse2);
xlabel('Time');
title('Second impulse train');
xlabel('Time(sec.)');

% Sampling
sampled1 = x .* impulse1;
sampled2 = x .* impulse2;

figure(2);

subplot(411);
stem(t, sampled1);
title('Sampled version of x(t) with first impulse train');
xlabel('Time(sec.)');

subplot(412);
stem(t, sampled2);
title('Sampled version of x(t) with second impulse train');
xlabel('Time(sec.)');

sampled1 = interp1(t, sampled1, t1, 'spline');
sampled2 = interp1(t, sampled2, t2, 'spline');

subplot(413);
stem(t1, sampled1);
hold on;
plot(t1, sampled1);
title('x_5_R(t)');
xlabel('Time(sec.)');

subplot(414);
stem(t2, sampled2);
hold on;
plot(t2, sampled2);
title('x_5_0_R(t)');
xlabel('Time(sec.)');


