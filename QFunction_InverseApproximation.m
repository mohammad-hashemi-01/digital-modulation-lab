% QInverse_Test.m
% Test and implementation of numerical inverse Q-function

clc,clearvars,close all
% Test example
disp(Q_inv(1e-6, 1));
disp(Q_function(Q_inv(1e-6, 1)));

% --- Inverse Q-function (numerical approximation) ---
function y = Q_inv(p, k)
    if p > 1 || p < 0
        y = Inf;
        return;
    end
    guess = 0;
    err = 2;
    while abs(err) > 1e-10
        err = p - Q_function(guess);
        guess = guess - err * k; % approach factor
    end
    y = guess;
end

% --- Q-function ---
function y = Q_function(x)
    y = 0.5 * erfc(x ./ sqrt(2));
end
