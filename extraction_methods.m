
% Helper methods from Matlab

% Fast fourier transform
% Y = fft(X)  ----> . Converts time series data frequency domain data

% Discrete Fourier Transform
% [cA,cD] = dwt(X,'wname') ----> approximation coefficients vector cA and detail coefficients vector cD, wname is wavelet name
% https://www.mathworks.com/help/wavelet/ref/dwt.html https://www.mathworks.com/help/wavelet/ref/wfilters.html

function result = maxFFT(X)
  result = max(fft(X));
end
