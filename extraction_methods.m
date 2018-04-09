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
    function feature = zero_crossing_rate(obj,X)
      feature = sum(abs(diff(X>0)))/length(X);
    end

    function feature = waveform_length(obj,X)
      feature = sum(abs(diff(X)));
    end

    % Root mean square
    function feature = root_mean_square(obj,X)
      feature = rms(s);
    end

    % Stats of power in frequency domain TODO - Explain in a better way
    function mean = mean_power_f(obj,X)
      y = fft(X);
      power = abs(y).^2/length(y);
      mean = mean(power);
    end
    
    function sd = sd_power_f(obj,X)
      y = fft(X);
      power = abs(y).^2/length(y);
      sd = std(power);
    end


    % Spatial Features - Start

    % Reads data for x, y and z vectors and makes combined feature
    function mean = vector_mean(obj,x,y,z)
      combined = sqrt(x.^2 + y.^2 + z.^2);
      mean = mean(combined);
    end
    
    function sd = vector_sd(obj,x,y,z)
      combined = sqrt(x.^2 + y.^2 + z.^2);
      sd = std(combined);
    end
    % Spatial Features - End

       %by Bharath
	%Energy consumption - start
	function feature=energy_consumption(obj,x)
	  m=fft(x);
	  feature=sum(abs(m).^2) / length(m);
	end
	%Energy consumption - end

	%Hamming window - start
	function feature=hamming_window(obj,x)
	  feature=hamming(x)
	end
	%hamming window - end
    
    %Gyroscore mean - start
	function feature = gyroscope_mean(obj,gx, gy, gz)
	  combined = sqrt(x.^2 + y.^2 + z.^2);
      feature = mean(combined);
    end
    
    function feature = gyroscope_sd(obj,gx, gy, gz)
	  combined = sqrt(x.^2 + y.^2 + z.^2);
      feature = std(combined);
	end
	%Gyroscope mean - end
    
    % Skewness - start
    function feature = skew(obj, X)
      feature = skewness(X)
    end
    % Skewness - end
    
    % Assuming heading direction has maximum variance
    function feature = average_in_heading_direction(obj, X, Y, Z)
      var_x = var(X);
      var_y = var(Y);
      var_z = var(Z);
      max_variance = [var_x var_y var_z];
      if max_variance == var_x
          feature = mean(X)
      elseif max_variance == var_y
          feature = mean(Y)
      else
          feature = mean(Z)
      end     
    end
    
   end
end