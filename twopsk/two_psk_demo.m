clc;
clearvars;
close all;

% Known phase (e.g., tracked via PLL)
randomPhase = 0;
% For random phase: uncomment below
% randomPhase = 2 * pi * rand();

% Time vector for one symbol
time = linspace(0, 1, 20000);

% Pulse shape with phase offset
g = sin(pi * time + randomPhase);

% Binary data to transmit
binary_sequence = [1, 0, 1, 0, 1, 1];

% Phase-aligned zero-padding (optional, useful for visualization)
twoPSKModulation = zeros(1, floor(randomPhase * length(g) / pi));

% 2-PSK modulation (1 → g, 0 → -g)
for i = 1:length(binary_sequence)
    if binary_sequence(i) == 0
        twoPSKModulation = [twoPSKModulation, -g];
    else
        twoPSKModulation = [twoPSKModulation, g];
    end
end

% Time vector for modulated signal
t_mod = linspace(0, length(binary_sequence), length(twoPSKModulation));

% Plot modulated signal
figure;
plot(t_mod, twoPSKModulation);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('2-PSK Modulated Signal');

% Matched filter: time-reversed version of g
mf = fliplr(g);

% Convolve modulated signal with matched filter
matched_filter_output = conv(twoPSKModulation, mf, 'full');

% Time vector for matched filter output
t_mf = linspace(0, length(binary_sequence) + 1, length(matched_filter_output));

% Plot matched filter output
figure;
plot(t_mf, matched_filter_output);
grid on;
xlabel('Time');
ylabel('Matched Filter Output');
title('Matched Filter Output (Causal)');
