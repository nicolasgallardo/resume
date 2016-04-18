% DSP Project 1
% 3/18/2016
% This function performs a 1-D FFT

function fft1d = FFT1D(x)
if ~isvector(x) % Check to make sure the input is a vector
    error('Input must be a vector')
else
    N = size(x,2);  % Number of samples
    W = exp(-2*pi*1i/N); % Calculate the base Twiddle Factor
    F_e = 0;
    F_o = 0;
    incr_x = 1;
    incr_y = 1;
    % Seperate the signal into odd/even sets
    for k = 1:N
        if rem(k,2) == 1
            x_even(1,incr_x) = x(k);
            incr_x = incr_x + 1;
        else
            x_odd(1,incr_y) = x(k);
            incr_y = incr_y + 1;
        end
    end
    % Obtain the FFT by summing the DFT of the even set and the DFT of the 
    % odd set multiplied by the Twiddle Factor
    for n = 0:N-1
        for k = 0:(N/2)-1
            J = exp(-2*pi*1i*k*n/(N/2));
            F_e = J*x_even(k+1) + F_e;
            F_o = J*x_odd(k+1) + F_o;

        end
        fft1d(n+1) = F_e + (W^n)*F_o;
        F_e = 0;
        F_o = 0;
    end
end
end