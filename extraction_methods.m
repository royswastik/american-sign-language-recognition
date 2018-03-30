
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

