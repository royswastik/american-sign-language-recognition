

fl_nms = {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Goout', 'Hearing'};

file_path_separator = '\';


for fl_nm_ind = 1:length(fl_nms)
    fig_path = strcat('D:\workspace\asu\matlab\mc\time-series-feature-extraction\plots\',fl_nms(fl_nm_ind),'\');
    fl_nm = char(strcat('actions\', fl_nms(fl_nm_ind),'.csv'));
    fid = fopen(fl_nm, 'rt');

    datatypes = '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
    data = textscan(fid,datatypes,'headerlines', 1, 'delimiter', ',');
    fclose(fid);
    height = length(data{1}) - 34 +1;
%     for row = 1:34:647
    for row = 1:34:height
        alx =[];aly =[];alz =[];arx =[];ary =[];arz =[];
        glx =[];gly =[];glz =[];grx =[];gry =[];grz =[];
        orl =[];opl =[];oyl =[];orr =[];opr =[];oyr =[];
        emg0l = [];emg1l = [];emg2l = [];emg3l = [];emg4l = [];emg5l = [];emg6l = [];emg7l = [];
        emg0r = [];emg1r = [];emg2r = [];emg3r = [];emg4r = [];emg5r = [];emg6r = [];emg7r = [];
        for col = 1:46
            alx = [alx data{col}(row,1)];aly = [aly data{col}(row+1,1)];alz = [alz data{col}(row+2,1)];
            arx = [arx data{col}(row+3,1)];ary = [ary data{col}(row+4,1)];arz = [arz data{col}(row+5,1)];

            emg0l = [emg0l data{col}(row+6,1)];emg1l = [emg1l data{col}(row+7,1)];emg2l = [emg2l data{col}(row+8,1)];
            emg3l = [emg3l data{col}(row+9,1)];emg4l = [emg4l data{col}(row+10,1)];emg5l = [emg5l data{col}(row+11,1)];
            emg6l = [emg6l data{col}(row+12,1)];emg7l = [emg7l data{col}(row+13,1)];

            emg0r = [emg0r data{col}(row+14,1)];emg1r = [emg1r data{col}(row+15,1)];emg2r = [emg2r data{col}(row+16,1)];
            emg3r = [emg3r data{col}(row+17,1)];emg4r = [emg4r data{col}(row+18,1)];emg5r = [emg5r data{col}(row+19,1)];
            emg6r = [emg6r data{col}(row+20,1)];emg7r = [emg7r data{col}(row+21,1)];

            glx = [glx data{col}(row+22,1)];gly = [gly data{col}(row+23,1)];glz = [glz data{col}(row+24,1)];
            grx = [grx data{col}(row+25,1)];gry = [gry data{col}(row+26,1)];grz = [grz data{col}(row+27,1)];

            orl = [orl data{col}(row+28,1)];opl = [opl data{col}(row+29,1)];oyl = [oyl data{col}(row+30,1)];
            orr = [orr data{col}(row+31,1)];opr = [opr data{col}(row+32,1)];oyr = [oyr data{col}(row+33,1)];
        end
        
    
        
        plot_helper([alx; aly; alz], 'AL', fig_path,'Accelerometer Data Analysis', 'Time', 'Accelerometer(L)');
        plot_helper([arx; ary; arz], 'AR', fig_path,'Accelerometer Data Analysis', 'Time', 'Accelerometer(R)'); 
        plot_helper([emg0l; emg1l; emg2l; emg3l; emg4l; emg5l; emg6l; emg7l], 'EMGL', fig_path,'EMG Data Analysis', 'Time', 'EMG(L)');   
        plot_helper([emg0r; emg1r; emg2r; emg3r; emg4r; emg5r; emg6r; emg7r], 'EMGR', fig_path,'EMG Data Analysis', 'Time', 'EMG(R)');
        plot_helper([glx; gly; glz], 'GL', fig_path,'GyroScope Data Analysis', 'Time', 'GyroScope(L)');
        plot_helper([grx; gry; grz], 'GR', fig_path,'GyroScope Data Analysis', 'Time', 'GyroScope(R)');
        plot_helper([orl; opl; oyl], 'OL', fig_path,'Orientation Data Analysis', 'Time', 'Orientation(L)');
        plot_helper([orr; opr; oyr], 'OR', fig_path,'Orientation Data Analysis', 'Time', 'Orientation(R)');
        
        plot_FFT([alx; aly; alz], 'AL', fig_path,'Accelerometer Data Analysis', 'Frequency', 'Accelerometer(L)');
        plot_FFT([arx; ary; arz], 'AR', fig_path,'Accelerometer Data Analysis', 'Frequency', 'Accelerometer(R)'); 
        plot_FFT([emg0l; emg1l; emg2l; emg3l; emg4l; emg5l; emg6l; emg7l], 'EMGL', fig_path,'EMG Data Analysis', 'Frequency', 'EMG(L)');   
        plot_FFT([emg0r; emg1r; emg2r; emg3r; emg4r; emg5r; emg6r; emg7r], 'EMGR', fig_path,'EMG Data Analysis', 'Frequency', 'EMG(R)');
        plot_FFT([glx; gly; glz], 'GL', fig_path,'GyroScope Data Analysis', 'Frequency', 'GyroScope(L)');
        plot_FFT([grx; gry; grz], 'GR', fig_path,'GyroScope Data Analysis', 'Frequency', 'GyroScope(R)');
        plot_FFT([orl; opl; oyl], 'OL', fig_path,'Orientation Data Analysis', 'Frequency', 'Orientation(L)');
        plot_FFT([orr; opr; oyr], 'OR', fig_path,'Orientation Data Analysis', 'Frequency', 'Orientation(R)');

    end
end
   

function plot_helper(sensors, file_name, fig_path, title, x_label, y_label)
    first_sensor = sensors(1, :);
    sensor_dir_name = strcat(char(fig_path),file_name, '\');
    mkdir(char(fig_path));
    mkdir(sensor_dir_name);
    file_name = strcat(file_name,'_',extractBefore(first_sensor(1,1),'_'));
    
    
    x = linspace(0,length(first_sensor(:,2:end)),length(first_sensor(:,2:end)));
%     valueSet = {orr(:,2:end), opr(:,2:end), oyr(:,2:end)};
    valueSet = {};
    keySet = {};
    for sensor_index = 1:length(sensors(:, 1))
        sensor = sensors(sensor_index, :);
        valueSet{1, sensor_index} = sensor(:,2:end);
        keySet{1, sensor_index} = sensor_index;
    end
    y = containers.Map(keySet,valueSet);
    file_name = strcat(file_name, '.png');
    plot_util(x,y,title, x_label, y_label, sensor_dir_name, file_name);
end

function plot_FFT(sensors, file_name, fig_path, title, x_label, y_label)
    fig_path = strcat(fig_path, 'FFT', '\');
    x_label = 'Frequency';
    sensors_frequency = [];
    for sensor_index = 1:length(sensors(:, 1))
        sensor = sensors(sensor_index, :);
        time_series_data = sensor(:,2:end);
        frequency_domain_data = fft(cell2mat(time_series_data));
        frequency_domain_data = num2cell(abs(frequency_domain_data));
        
        sensors_frequency = [sensors_frequency; sensor(:, 1:1),frequency_domain_data];
    end
    plot_helper(sensors_frequency, file_name, fig_path, title, x_label, y_label); 
end

