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
        X = cell2mat(X);
        feature = sum(abs(diff(X>0)))/length(X);
    end

    function feature = waveform_length(obj,X)
        X = cell2mat(X);
        feature = sum(abs(diff(X)));
    end

    % Root mean square
    function feature = root_mean_square(obj,X)
        X = cell2mat(X);
        feature = rms(X);
    end

    % Stats of power in frequency domain TODO - Explain in a better way
    function res = mean_power_f(obj,X)
      X = cell2mat(X);
      y = fft(X);
      power = abs(y).^2/length(y);
      res = mean(power);
    end
    
    function sd = sd_power_f(obj,X)
      X = cell2mat(X);
      y = fft(X);
      power = abs(y).^2/length(y);
      sd = std(power);
    end


    % Spatial Features - Start

    % Reads data for x, y and z vectors and makes combined feature
    function res = vector_mean(obj,x,y,z)
      x = cell2mat(x);
      y = cell2mat(y);
      z = cell2mat(z);
      combined = sqrt(x.^2 + y.^2 + z.^2);
      res = mean(combined);
    end
    
    function sd = vector_sd(obj,x,y,z)
      x = cell2mat(x);
      y = cell2mat(y);
      z = cell2mat(z);
      combined = sqrt(x.^2 + y.^2 + z.^2);
      sd = std(combined);
    end
    % Spatial Features - End

       %by Bharath
	%Energy consumption - start
	function feature=energy_consumption(obj,x)
        x = cell2mat(x);
        m=fft(x);
        feature=sum(abs(m).^2) / length(m);
	end
	%Energy consumption - end

	%Hamming window - start
	function feature=hamming_window(obj,x)
        x = cell2mat(x);
        feature=hamming(x);
	end
	%hamming window - end
	
	%Cumulative sum - start
	function feature=cumulative_sum(x)
	   x=cell2mat(x);
	   feature=cumsum(x);
	end
	
	%variance - start
	function feature= variancee(x)
		x=cell2mat(x);
		feature=vairance(x);
	end
    
    %Gyroscore mean - start
	function feature = gyroscope_mean(obj,gx, gy, gz)
        gx = cell2mat(gx);
        gy = cell2mat(gy);
        gz = cell2mat(gz);
	  combined = sqrt(gx.^2 + gy.^2 + gz.^2);
      feature = mean(combined);
    end
    
    function feature = gyroscope_sd(obj,gx, gy, gz)
        gx = cell2mat(gx);
        gy = cell2mat(gy);
        gz = cell2mat(gz);
	  combined = sqrt(gx.^2 + gy.^2 + gz.^2);
      feature = std(combined);
	end
	%Gyroscope mean - end
    
    % Skewness - start
    function feature = skew(obj, X)
        X = cell2mat(X);
      feature = skewness(X)
    end
    % Skewness - end
    
    % Assuming heading direction has maximum variance
    function feature = average_in_heading_direction(obj, X, Y, Z)
        X = cell2mat(X);
        Y = cell2mat(Y);
        Z = cell2mat(Z);
      var_x = var(X);
      var_y = var(Y);
      var_z = var(Z);
      max_variance = [var_x var_y var_z];
      if max_variance == var_x
          feature = mean(X);
      elseif max_variance == var_y
          feature = mean(Y);
      else
          feature = mean(Z);
      end     
    end
    
   end
end
