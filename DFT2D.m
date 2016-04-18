% DSP Project 1
% 3/18/2016
% This function performs a 2-D DFT

function dft = DFT2D(x)
if ~ismatrix(x) % Check to make sure the input is a matrix
    error('Input must be a matrix')
else
% The DFT is split into two steps, first along the columns:
N_rows = size(x,1);  % Number samples (# of rows in x)
N_cols = size(x,2);  % Number samples (# of cols in x)
P = zeros(size(x,1),size(x,2)); % Create a placeholder P
for k = 1:N_rows
    for b = 1:N_cols
        for a = 1:N_rows 
% Notice we are traversing along each col by holding b and indexing a in
% x(a,b)
            P(k,b) = x(a,b)*exp(-1i*2*pi*(k-1)*(a-1)/N_rows)+P(k,b); %
        end
    end
end
% Next take the DFT along the rows:
N2_rows = size(P,1);  % Number samples (# of rows in x)
N2_cols = size(P,2);  % Number samples (# of cols in x)
dft = zeros(size(P,1),size(P,2));
for k = 1:N2_rows
    for l = 1:N2_cols
        for b = 1:N2_cols
% Notice we are traversing along each row by holding the row and indexing
% the column in P(k,b)
            dft(k,l) = P(k,b)*exp(-1i*2*pi*(l-1)*(b-1)/N2_cols)+dft(k,l);
        end
    end
end
end
end