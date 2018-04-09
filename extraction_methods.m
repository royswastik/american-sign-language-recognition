classdef extraction_methods
   properties
      feature = 0.0
   end
    
    methods
    % Helper methods from Matlab

    % Fast fourier transform
    % Y = fft(X)  ----> . Converts time series data frequency domain data

    % Discrete Fourier Transform
    % [cA,cD] = dwt(X,'wname') ----> approximation coefficients vector cA and detail coefficients vector cD, wname is wavelet name
    % https://www.mathworks.com/help/wavelet/ref/dwt.html https://www.mathworks.com/help/wavelet/ref/wfilters.html

    % Maximum frequency from FFT Output

    function feature = maxFFT(obj,X)
      X = cell2mat(X);
      feature = abs(max(fft(X)));
    end

    % Zero crossing rate
    function obj = zero_crossing_rate(obj,X)
      obj.feature = sum(abs(diff(X>0)))/length(X);
    end

    function obj = waveform_length(obj,X)
      obj.feature = sum(abs(diff(X)));
    end

    % Root mean square
    function obj = root_mean_square(obj,X)
      obj.feature = rms(s);
    end

    % Stats of power in frequency domain TODO - Explain in a better way
    function obj = mean_power_f(obj,X)
      y = fft(X);
      power = abs(y).^2/length(y);
%       mean = mean(power);
      obj.feature = std(power);
    end


    % Spatial Features - Start

    % Reads data for x, y and z vectors and makes combined feature
    function [mean, sd] = vector_mean(x,y,z)
      combined = sqrt(x.^2 + y.^2 + z.^2);
%       mean = mean(combined);
      obj.feature = std(combined);
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
   end
end