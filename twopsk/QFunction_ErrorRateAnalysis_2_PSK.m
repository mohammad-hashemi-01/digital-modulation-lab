% QFunction_ErrorRateAnalysis.m
% Log-log plots of error probability vs. bit energy and SNR using the Q-function (2-PSK case)

clc,clearvars,close all

% Parameters
Eb = logspace(log10(1e-20), log10(1e-7), 1000);  % Bit energy values
N0 = 2e-9;                                       % Noise spectral density
SNR = Eb / N0;                                   % Signal-to-noise ratio
Dmin = 2 * sqrt(Eb);                             % Minimum distance for 2-PSK

% Compute probability of error using Q-function
prob_error = Q_function(Dmin ./ sqrt(2 * N0));

% Plot: Error probability vs. bit energy
figure;
loglog(Eb, prob_error, 'b', 'LineWidth', 1.5);
grid on;
xlabel('E_b (Bit Energy)');
ylabel('Probability of Error');
title('Error Probability vs. Bit Energy using Q-function');
set(gca, 'FontName', 'Courier', 'FontSize', 10);

% Plot: Error probability vs. SNR
figure;
loglog(SNR, prob_error, 'r', 'LineWidth', 1.5);
grid on;
xlabel('SNR (E_b/N_0)');
ylabel('Probability of Error');
title('Error Probability vs. SNR in 2-PSK Modulation');
set(gca, 'FontName', 'Courier', 'FontSize', 10);

% --- Q-function definition ---
function y = Q_function(x)
    y = 0.5 * erfc(x ./ sqrt(2));
end
