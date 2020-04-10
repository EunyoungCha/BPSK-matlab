%BPSK Signal
bit_num = 100000;
buf = 1;
SNRdB = -10:1:10;
BER = zeros(length(SNRdB),1);
for SNR_buf = SNRdB
    %binary data stream
    bit = randi([0,1],bit_num,1);
    
    %BPSK mapping
    bit_map = complex(-2*bit + 1);  
    tx = bit_map;
    %Channel 'AWGN'
    rx = awgn(tx,SNR_buf);
    %rx_buf = zeros(bit_num, 1);
    demo = rx<0;   
    demo_rx = demo;
    err = bit - demo_rx;
    err_sum = sum(abs(err),'all'); %Summation of absolute value of err
    BER(buf,1) = err_sum/bit_num;
    buf = buf+1;
end

% Constellation
figure(1);clf; %Clear figure
plot(real(rx),imag(rx),'.')
grid on
xlabel('Real')
ylabel('Imag')
axis([-1.5 1.5 -1.5 1.5])

% BER Curve
figure(2);clf;
semilogy(SNRdB,BER,'ro--')
grid on
xlabel('SNR [dB]')
ylabel('BER')
title('BPSK BER')
legend('BPSK')
axis([-11 11 1e-6 1])

