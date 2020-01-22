clear;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Onur Can Ozkaya %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PART 1
T = 0.6;
Fs = 1000;
t = 0 : 1/Fs : T;
f1 = 56;
f2 = 66;

x = cos(2*pi*f1*t) + cos(2*pi*f2*t);
h = t .^2;

figure(1);
subplot(311);
plot(t, x);
title("Input signal x(t)");
xlabel("Time (sec.)");

subplot(312);
plot(t, h);
title("Impulse response h(t)");
xlabel("Time (sec.)");


% Convolving signals.
y = conv(x, h, 'same');

subplot(313);
plot(t, y);
title("Output signal y(t)");
xlabel("Time (sec.)");


%% PART 2

c = sin(600*pi*t);
z = rand(1, length(c));
N = length(x);

g1 = x .* c;
g2 = g1 + z;
g3 = g2 .* c;


figure(2);
subplot(311);
plot(t, g1);
title("g_1(t)");

subplot(312);
plot(t, g2);
title("g_2(t)");

subplot(313);
plot(t, g3);
title("g_3(t)");

fvect = linspace(-Fs/2, Fs/2, N);

g1fft = fft(g1, N);
g1fft = fftshift(g1fft);
g1fft = abs(g1fft) / N;

g2fft = fft(g2, N);
g2fft = fftshift(g2fft);
g2fft = abs(g2fft) / N;

g3fft = fft(g3, N);
g3fft = fftshift(g3fft);
g3fft = abs(g3fft) / N;

xfft = fft(x, N);
xfft = fftshift(xfft);
xfft = abs(xfft) / N;

figure(3);
subplot(411);
plot(fvect, xfft);
title("X(f)");
xlabel("Frequency (Hz)");

subplot(412);
plot(fvect, g1fft);
title("G_1(f)");
xlabel("Frequency (Hz)");

subplot(413);
plot(fvect, g2fft);
title("G_2(f)");
xlabel("Frequency (Hz)");

subplot(414);
plot(fvect, g3fft);
title("G_3(f)");
xlabel("Frequency (Hz)");


% low-pass filter with order of 6    
fco = 61;
[blp ,alp] = butter(6, fco / (Fs / 2), 'low');
hlp = freqz(blp, alp, N);

figure(4);
plot(abs(hlp));
title("Frequency response of low-pass filter with order of 6");
xlabel("Frequency(Hz)");

y1 = filter(blp, alp, g3);

y1fft = fft(y1, N);
y1fft = fftshift(y1fft);
y1fft = abs(y1fft) / N;

figure(5);
plot(fvect, y1fft);
title("Y_1(jw)");
xlabel("Frequency(Hz)");

fco2 = 61;

% ideal low pass
fvectlp = linspace(-Fs/2, Fs/2, N);
Hlp2 = heaviside(fvectlp + 61) - heaviside(fvectlp - 61);


figure(6);
plot(fvectlp, Hlp2);
title("Frequency response of ideal low-pass filter");
xlabel("Frequency(Hz)");

Y2 = g3fft .* Hlp2;

figure(7);
plot(fvect, Y2);
title("Y_2(jw)");
xlabel("Frequency(Hz)");


