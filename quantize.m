function yq = quantize(in_seq,B)

% Quantize signal to B bits

% -------------------------

% [yq] = quantize(y,B)

%    yq = quantized signal in integers: 0 <= yq <= 2^B-1
        % this distributes the signal to a range determined by bit size
%     y = input signal
%     B = bits/sample

%following is a uniform quantization, results are similar to below
%swing = (2^B-1)/2;
%yq = y*swing+swing;
%yq = round(yq);


%following is my uniform quantization
in_max=1; % all uniform quantizers need max
in_min=-1; %do i need to change to diff? if not, remove
step = (in_max(1)) / (2^B); %definition, uniform
in_seq= round((in_seq-in_min)/step); %change to round
delta=step/2; %definition
L= length(in_seq);
yq = zeros(size(in_seq), 'double');
for y=1:L
yq(y) = ((double(in_seq(y)) * step)+delta);
end
end