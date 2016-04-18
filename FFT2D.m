% DSP Project 1
% 3/18/2016
% This function performs a 2-D FFT by taking the 1-D FFT of each row resulting
% in matrix P, then the 1-D FFT of each column in P is taken to obtain the
% final 2-D FFT.

function fft2d = FFT2D(x)
if ~ismatrix(x) % Check to make sure the input is a matrix
    error('Input must be a matrix')
else
    N_rows = size(x,1); % Sample length of rows
    N_cols = size(x,2); % Sample length of columns
    P = zeros(N_rows,N_cols); % Placeholder for P
    x_row = zeros(1,N_cols); % Placeholder for the input to the 1-D FFT with N_cols samples
    for i = 1:N_rows % 1-D FFT along the rows
        for k = 1:N_cols
            x_row(1,k) = x(i,k); % Vectorize the current row
        end 
        P(i,:) = FFT1D(x_row); % Take the 1-D FFT of the current row
    end
    fft2d = zeros(N_rows,N_cols);
    x_row = zeros(1,N_rows); % Placeholder for the input to the 1-D FFT with N_rows samples
    for i = 1:N_cols % 1-D FFT along the columns
        for k = 1:N_rows 
            x_row(1,k) = P(k,i); % Vectorize the current column
        end 
        fft2d(:,i) = FFT1D(x_row); % Take the 1-FFT of the current column
    end
end
end