clc;
clear;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Onur Can Ozkaya %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fs = 5000;
t = -0.05 : 1/Fs : 0.05;

f1 = 50;
f2 = 200;
f3 = 500;

h = (t == 0);

x1 = 0.1 * sin(2*pi*f1*t);
x2 = 0.5 * cos(2*pi*f2*t);
x3 = -0.9 * sin(2*pi*f3*t);

figure(1);
subplot(711);
plot(t, x1);
title('x_1(t)');
xlabel('Time(sec)');

subplot(712);
plot(t, x2);
title('x_2(t)');
xlabel('Time(sec)');

subplot(713);
plot(t, x3);
title('x_3(t)');
xlabel('Time(sec)');

subplot(714);
plot(t, h);
title('h(t)');
xlabel('Time(sec)');


x4 = conv(x1, h, 'same') + conv(x2, h, 'same') + conv(x3, h, 'same');
size = length(x4) + length(h) - 1;

subplot(715);
plot(t, x4);
title('x_4(t)');
xlabel('Time(sec)');


N = 1024;
x4fft = fft(x4, N);
x4fft = fftshift(x4fft);
x4fft = abs(x4fft)/N;

f = Fs * linspace(-0.5, 0.5, N);
subplot(716);
plot(f, x4fft);
title('X_4(f)');
xlabel('Frequency');


%% Low-pass Filter
Fo1 = 75;
n = 5;
[blp, alp] = butter(n, Fo1 / (Fs / 2), 'low');

%% High-pass Filter with cut-off frequency Fc
Fo2 = 350;
[bhp, ahp] = butter(n , Fo2 / (Fs / 2), 'high');

%% Band-pass filter
Fc = [Fo1 Fo2];
[bbp, abp] = butter(n, Fc ./ (Fs / 2), 'bandpass');

[Hlp, Flp]=freqz(blp, alp, Fs/2);
[Hhp, Fhp]=freqz(bhp, ahp, Fs/2);
[Hbp, Fbp]=freqz(bbp, abp, Fs/2);

figure(2);

subplot(311);
plot(abs(Hlp));
title('Frequency response of low-pass');
xlabel('Frequency');

subplot(312);
plot(abs(Hhp));
title('Frequency response of high-pass');
xlabel('Frequency');

subplot(313);
plot(abs(Hbp));
title('Frequency response of band-pass');
xlabel('Frequency');

y1 = filter(blp, alp, x4);
y1fft = fft(y1, N);

y2 = filter(bbp, abp, x4);
y2fft = fft(y2, N);

y3 = filter(bhp, ahp, x4);
y3fft = fft(y3, N);

fvect = linspace(-Fs / 2, Fs / 2, N);
figure(3);

subplot(811);
plot(f, x4fft);
title('X_4(f) input to filters in frequency spectrum');
xlabel('Frequency');

subplot(812);
plot(fvect, abs(fftshift(y1fft)));
title('Y_1(f)');
xlabel('Frequency');

subplot(813);
plot(fvect, abs(fftshift(y2fft)));
title('Y_2(f)');
xlabel('Frequency');

subplot(814);
plot(fvect, abs(fftshift(y3fft)));
title('Y_3(f)');
xlabel('Frequency');

subplot(815);
plot(t, x4);
title('x_4(t) input to filters')
xlabel('Time(sec)');
subplot(816);
plot(t, y1);
title('y_1(t)');
xlabel('Time(sec)');

subplot(817);
plot(t, y2);
title('y_2(t)');
xlabel('Time(sec)');

subplot(818);
plot(t, y3);
title('y_1(t)');
xlabel('Time(sec)');

