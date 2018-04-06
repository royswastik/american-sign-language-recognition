
% Helper methods from Matlab

% Fast fourier transform
% Y = fft(X)  ----> . Converts time series data frequency domain data

% Discrete Fourier Transform
% [cA,cD] = dwt(X,'wname') ----> approximation coefficients vector cA and detail coefficients vector cD, wname is wavelet name
% https://www.mathworks.com/help/wavelet/ref/dwt.html https://www.mathworks.com/help/wavelet/ref/wfilters.html

% Maximum frequency from FFT Output
function feature = maxFFT(X)
  feature = max(fft(X));
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

% Stats of power in frequency domain TODO - Explain in a better way
function [ mean, sd] = mean_power_f(X)
  y = fft(X);
  power = abs(y).^2/length(y);
  mean = mean(power);
  sd = std(power);
end


% Spatial Features - Start

% Reads data for x, y and z vectors and makes combined feature
function [mean, sd] = vector_mean(x,y,z)
  combined = sqrt(x.^2 + y.^2 + z.^2);
  mean = mean(combined);
  sd = std(combined);
end
% Spatial Features - End

%by Bharath
%Energy consumption - start
function feature=energy_consumption(x)
  m=fft(x);
  feature=sum(abs(m).^2) / length(m);
end
%Energy consumption - end

%Hamming window - start
function feature=hamming_window(x)
  feature=hamming(x)
end
%hamming window - end

%
