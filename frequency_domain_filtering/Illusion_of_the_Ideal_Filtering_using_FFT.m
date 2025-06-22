%{
    Illusion of the Ideal Filtering using FFT
    ------------------------------------------
    Alan V. Oppenheim described how the speed of FFT tempts us to filter in
    the frequency domain, but this results in circular convolution.

    This script:
    1. Creates a periodic frequency response.
    2. Computes its time-domain version.
    3. Evaluates the DTFT and compares to DFT.
    4. Filters an impulse input over 1, 2, 4, 8 chunks.
%}

clc;
close all;
clearvars;
hold on

%% Frequency-domain definition
subplot(3,1,1)
one_period_frequency = [ones(1,16), zeros(1,20), ones(1,15)];
N = length(one_period_frequency);
h_k = @(k) one_period_frequency(mod(k, N) + 1);
k_axis = 0:N-1;
stem(k_axis, h_k(k_axis), 'LineWidth', 1.2, 'Marker', 'x', 'LineStyle', '--');
title('Periodic Frequency Response H[k]')
xlim([-1, N+2]);
ylim([-0.1, 1.2]);

%% Time-domain impulse response via IFFT
subplot(3,1,2)
one_period_time = ifft(h_k(k_axis));
h_n = @(n) one_period_time(mod(n, N) + 1);
n_axis = 0:N-1;
stem(n_axis, h_n(n_axis), 'LineWidth', 0.7, 'Marker', '*', 'LineStyle', '--');
title('Time-Domain Impulse Response h[n]')
xlim([-1, N+2]);

%% DTFT and DFT samples
subplot(3,1,3)
h_ejw = @(omega) sum( exp(1j * omega(:) .* n_axis) .* h_n(n_axis), 2 );
frequency_axis = linspace(0, 4*pi, 10000);
H_ejw_vals = h_ejw(frequency_axis);
plot(frequency_axis, abs(H_ejw_vals), 'b');
hold on;
omega_k = (2*pi/N) * (0:N-1);
H_ejw_dft = h_ejw(omega_k);
plot(omega_k, abs(H_ejw_dft), 'ro', 'MarkerSize', 5, 'LineWidth', 1.2);
xticks(0:pi:4*pi);
xticklabels({'0','\pi','2\pi','3\pi','4\pi'});
title('DTFT Magnitude and DFT Samples');
hold off;

%% Filter simulation: 1, 2, 4, 8 chunks
chunk_counts = [1, 2, 4, 8];
figure;

for i = 1:length(chunk_counts)
    num_chunks = chunk_counts(i);
    impulse_length = num_chunks * N;
    input_unit_impulse = zeros(1, impulse_length);
    input_unit_impulse(1) = 1;

    % Convolution with one period of h[n]
    one_period_impulse_response = conv(input_unit_impulse, one_period_time);
    output_impulse_response = @(n) one_period_impulse_response(mod(n, length(one_period_impulse_response)) + 1);
    n_axis_out = 0:length(one_period_impulse_response)-1;

    % Time-domain response plot
    subplot(length(chunk_counts), 3, 3*(i-1)+1)
    stem(n_axis_out, output_impulse_response(n_axis_out), 'LineWidth', 0.7, 'Marker', '*', 'LineStyle', '--');
    title(['Chunk Count = ', num2str(num_chunks)])
    xlim([-1, length(n_axis_out)+2]);

    % Frequency-domain amplitude and phase
    h_ejw_out = @(omega) sum(exp(1j * omega(:) .* n_axis_out) .* output_impulse_response(n_axis_out), 2);
    amplitude = @(omega) abs(h_ejw_out(omega));
    phase = @(omega) angle(h_ejw_out(omega));

    % Amplitude
    subplot(length(chunk_counts), 3, 3*(i-1)+2)
    plot(frequency_axis, amplitude(frequency_axis), 'b');
    title(['Amplitude, ', num2str(num_chunks), ' Chunks'])
    xticks(0:pi:4*pi);
    xticklabels({'0','\pi','2\pi','3\pi','4\pi'});

    % Phase
    subplot(length(chunk_counts), 3, 3*(i-1)+3)
    plot(frequency_axis, phase(frequency_axis), 'r');
    title(['Phase, ', num2str(num_chunks), ' Chunks'])
    xticks(0:pi:4*pi);
    xticklabels({'0','\pi','2\pi','3\pi','4\pi'});
end
