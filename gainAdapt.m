% This script uses a Gain factor on the input sequence 
% G = G0/sqrt(sigma[n]^2)
function gA = gainAdapt(input,input_Fs,div,B)
L = length(input(:,1)); % Get the length of the file
input = transpose(input); % Lets deal wirh a row vector
%div = 100; % Choose how many divisions of L and ultimately M, see below
M = L/div; % The value of G(s) is calculated every M samples
s_cnt = 1; %This will just increment evertime a new sigma^2 value is calc'd
G0 = .8; % Arbitrary
sigma_2 = zeros(1,div); %Placeholder
G = zeros(1,div); % Placeholder
% Next we will calculate sigma every M samples
for n = 1:L % flip through the entire signal
    if mod(n,M)==0 % Check to see if M samples have passed
        m = n-M+1; % Set up the sum limits
        for k = m:n % Calcute the sum from m to n of x(n)^2
            sigma_2(s_cnt) = input(k)^2 + sigma_2(s_cnt);
        end
        sigma_2(s_cnt) = (1/M)*sigma_2(s_cnt); % Normalize by M
        G(s_cnt) =  G0/sqrt(sigma_2(s_cnt)); %Calculate G(n)         
        s_cnt = s_cnt + 1; % Increment to the next spot
    end
end

input_final = transpose(input);

for i = 1:div-1
    for k = 1:M
        input_final(k+M*i,1) = G(i)*input(1,k+M*i); % Multiply everything by G(n)
        % remember this starts after the first M samples, this is a warm-up
        % period
    end
end

input_quant = quantize(input_final, B);
gA = zeros(L,1);
for i = 1:div-1
    for k = 1:M
        gA(k+M*i,1) = input_quant(k+M*i,1)/G(i); % As a final step
        % We must divide the resulting quantized signal by the gain.
    end
end
end