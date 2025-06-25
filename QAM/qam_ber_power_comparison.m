clc , close all
M_list = [4 16 32 64 128 256];
SNR_dB = 0:0.5:30;
BER = zeros(length(M_list), length(SNR_dB));

for k = 1:length(M_list)
    M = M_list(k);
    SNR_linear = 10.^(SNR_dB/10);
    k_bits = log2(M);
    BER(k,:) = 4*(1-1/sqrt(M))/k_bits * qfunc(sqrt(3*k_bits/(M-1).*SNR_linear));
end

figure
semilogy(SNR_dB, BER(1,:), 'o-')
hold on
colors = lines(length(M_list));
for k = 2:length(M_list)
    semilogy(SNR_dB, BER(k,:), 'Color', colors(k,:), 'LineWidth',1.5)
end
grid on
xlabel('SNR (dB)')
ylabel('Bit Error Rate (BER)')
ylim([1e-10,1])
legend(arrayfun(@(m) sprintf('%d-QAM',m), M_list, 'UniformOutput', false))
title('M-QAM BER vs SNR')
