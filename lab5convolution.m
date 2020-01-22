clearvars
clc;
clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Onur Can Ozkaya %
%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Part 1

% Defining discrete-time signals
n = -5:1:5; 
x = 3 * (n == -2) - (n == 1) + 2 * (n == 3);
h1 = heaviside(n + 3.5) - heaviside(n - 4.5);
h2 = heaviside(n + 0.5) - heaviside(n - 3.5);

% Plotting x[n], h1[n] and h2[n]
figure(1);
subplot(221);
stem(n, x);
title('x[n]');
xlabel('n');
grid on;
ylabel('Amplitude');

subplot(222);
stem(n, h1)
title('h_1[n]');
xlabel('n');
grid on;
ylabel('Amplitude');

subplot(223);
stem(n, h2);
title('h_2[n]');
xlabel('n');
grid on;
ylabel('Amplitude');

subplot(224);
stem(n, h1 + h2);
title('h_1[n] + h_2[n]');
xlabel('n');
grid on;
ylabel('Amplitude');


%% Part 2 Convolving input signal and impulse response by using custom created function and built-in conv() function

% Convolving input signal and impulse response
out = customConv1D(x,h1);
out2 = conv(x, h1);
n2 = -(length(x) + length(h1) - 2) / 2 : 1 : (length(x) + length(h1) - 2) / 2;
figure(2);
% Plotting output signals
subplot(211);
stem(n2, out);
title('Custom convolution function y[n] = x[n] * h_1[n]');
grid on;
ylabel('Amplitude');
xlabel('n');

subplot(212);
stem(n2, out2);
title('conv() function y[n] = x[n] * h_1[n]');
grid on;
ylabel('Amplitude');
xlabel('n');


%% PART 3 Checking the distributive property of convolution sum for discrete-time signals.

% y3[n] output
out3 = customConv1D(x,h1) + customConv1D(x, h2);
out4 = conv(x, h1) + conv(x, h2);

% y4[n] output
out5 = customConv1D(x,( h1 + h2 ));
out6 = conv(x, (h1 + h2));

figure(3);

subplot(411);
stem(n2, out3);
title('Distributive property y_3[n]=x[n]*h_1[n]+x[n]*h_2[n] using custom conv function');
ylabel('Amplitude');
xlabel('n');

subplot(412);
stem(n2, out4);
title('Distributive property y_3[n]=x[n]*h_1[n]+x[n]*h_2[n] using built-in conv() function');
ylabel('Amplitude');
xlabel('n');

subplot(413);
stem(n2, out5);
title('Distributive property y_4[n]=x[n]*(h_1[n]+h_2[n]) custom conv function');
ylabel('Amplitude');

subplot(414);
stem(n2, out6);
title('Distributive property y_4[n]=x[n]*(h_1[n]+h_2[n]) using built-in conv() function');
ylabel('Amplitude');


%% Convolution function
function[Y, n]=customConv1D(x,h)
    xLength = length(x);
    hLength = length(h);
    
    % Filling with zeros with respect to impulse response
    X = [zeros(1, hLength - 1), x];
    % Flipping impulse response and filling with zeros with respect to
    % input signal
    H = [flip(h), zeros(1, xLength - 1)];
    n =  xLength + hLength - 1;
    Y = zeros(1, n);

    for n = 0 : xLength + hLength - 2
        % Sliding the impulse response to calculate the convolution
        Y(n + 1) = Y(n + 1) + dot([X zeros(1,n)], [zeros(1, n) H]);
    end
end







