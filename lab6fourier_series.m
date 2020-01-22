clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Onur Can Ozkaya %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Checking Parseval's Relation

% Period
T = 5;
% Lower and upper bounds of integral
lowerBound = 0;
upperBound = lowerBound + T;
% Sampling rate
dt = 0.001;
t = 0 : dt : T;
% Input
x = 5*exp(-0.5*t);

% Plotting the signal
figure(1)
subplot(111);
plot(t, x);
title('x(t) = 5e^-^0^.^5^t');
xlabel('t (sec.)');
ylabel('x(t)');

% Fourier Series between (-1000 - 1000)
k = 1000;
c = fsc(x, k, T, dt, t);

% Left-hand side of Parseval's Relation
leftHandSide = sum(abs(c).^2)
% Right hand-side of Parseval's Relation
rightHandSide = parseval(x, T, dt, lowerBound, upperBound)

%% Function to calculate Fourier Series coefficients
function [ck] = fsc(x, M, T, dt, t)
    ck = zeros(2 * M + 1, 1);
    for k = 1 : 2 * M + 1
        ck(k) = (1/T) * sum(x .* exp(-1i * (k - M - 1) * 2*pi/T*t)*dt);
    end
end

%% Function to calculate Parseval's Relation
function [parseval] = parseval(x, T, dt, lowerBound, upperBound) 
    intervalArea = zeros(T * 1/dt, 1);
    j = 0;
    for i = lowerBound : dt : upperBound
        j = j + 1;
        intervalArea(j) = (abs(x(j)) ^ 2) * dt;
    end
    parseval = sum(intervalArea) / T;
end



