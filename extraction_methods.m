
% Helper methods from Matlab

% Fast fourier transform
% Y = fft(X)  ----> . Converts time series data frequency domain data

% Discrete Fourier Transform
% [cA,cD] = dwt(X,'wname') ----> approximation coefficients vector cA and detail coefficients vector cD, wname is wavelet name
% https://www.mathworks.com/help/wavelet/ref/dwt.html https://www.mathworks.com/help/wavelet/ref/wfilters.html

% Maximum frequency from FFT Output
function result = maxFFT(X)
  result = max(fft(X));
end

% Zero crossing rate
function feature = zero_crossing_rate(X)
  feature = sum(abs(diff(X>0)))/length(X);
end

function feature = waveform_length(X)
  feature = sum(abs(diff(X)));
end

% Root mean square
function feature = root_mean_square(X)
  feature = rms(s);
end

% Mean of power in frequency domain TODO - Explain in a better way
function feature = mean_power_f(X)
  y = fft(X);
  power = abs(y).^2/length(y);
  feature = mean(power);
end

% Standard Deviation of power TODO - Explain in a better way
function feature = sd_power_f(X)
  y = fft(X);
  power = abs(y).^2/length(y);
  feature = std(power);
end
