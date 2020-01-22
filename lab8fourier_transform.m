clc 
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Onur Can Ozkaya %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

fc = 100;
T = 0.1;
Fs = 1000;
t = 0: 1/Fs : 0.5;
N = 1024;
f = Fs * linspace(-0.5, 0.5, N);
x1 = sin(2*pi*fc*t);

for i = 101 : 500
    x1(i)=0;
end

figure(1);
subplot(411);
plot(t, x1);
title('x_1(t)');
xlabel('t (sec)');

%% Finding Fourier Transform with fft()
X1fft = fft(x1, N);
X1fft = fftshift(X1fft);
X1fft = abs(X1fft) / N;

%% Finding Fourier Transform with custom function
X1 = FourierTransform(x1, N/2, t);
X1 = abs(X1);

%% Plotting X1(f) found with built-in fft() function
subplot(412);
plot(f, X1fft);
title('X_1(f) with fft()');
xlabel('f (Hz)');

%% Plotting X1(f) found with custom Fourier Transform function
subplot(413);
plot(f, X1);
title('X_1(f)');
xlabel('f (Hz)');

%% Constructing x2(t) and y(t) signals.
Ts_2 = 0.001;
t2_1 = 0 : Ts_2 : 0.1;
t2_2 = 0.101 : Ts_2 : 0.2;
t2_3 = 0.201 : Ts_2 : 0.5;
x2_1 = 10 * t2_1;
x2_3 = zeros(1,300);
x2_2 = fliplr(x2_1);
x2_2(1) = [];
y_4 = zeros(1,100);
y_3 = x2_1;
y_3(1) = [];
x2 = [x2_1 x2_2 x2_3];
t2 = [t2_1 t2_2 t2_3];
y = [x2_1 x2_2 y_3 x2_2 y_4];

%% Plotting input signal
figure(2);
subplot(311);
plot(t2, x2);
title('Input x_2(t) ');
xlabel('t (sec)');

%% Plotting output signal
subplot(312);
plot(t2, y);
title('Output y(t) ');
xlabel('t (sec)');

%% Fourier Transform of x2(t) and y(t)
X2 = fft(x2, length(t2));
Y = fft(y, length(t2));

%% Finding impulse response
H = Y ./ (X2);

%% Inverse Fourier Transform of H(f)
h = ifft(H, length(t2));

%% Input Signal
subplot(313);
plot(t2, h);
title('Impulse Response h(t)');
xlabel('t (sec)');

%% Fourier Transform
function [out] = FourierTransform(x, f, t)
    out = zeros(1, f);
    for i = -f : f - 1
        out(1,i+1+f) = sum(dot(x, exp(-2j*pi*i*t)))*0.001;
    end
end

