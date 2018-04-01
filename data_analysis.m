

fig_path = '/Users/jaydeep/jaydeep_workstation/ASU/Spring2018/MC_535/project/words/';
fl_nms = {'About.csv'};

for fl_nm_ind = 1:length(fl_nms)
    fl_nm = char(fl_nms(fl_nm_ind));
    fid = fopen(fl_nm, 'rt');

    datatypes = '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
    data = textscan(fid,datatypes,'headerlines', 1, 'delimiter', ',');
    fclose(fid);

    for row = 1:34:647
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
        
        % ALX start
        file_path = strcat(fig_path,extractBefore(alx(1,1),';'),'/',extractAfter(alx(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'AL.png';
        x = linspace(0,45,length(alx(:,2:end)));
        keySet = [1 2 3];
        valueSet = {alx(:,2:end), aly(:,2:end), alz(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'Accelerometer Data Analysis', 'Frequency', 'Accelerometer(L)', file_path, file_nm);
        % ALX end
        
        % ARX start
        file_path = strcat(fig_path,extractBefore(arx(1,1),';'),'/',extractAfter(arx(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'AR.png';
        x = linspace(0,45,length(arx(:,2:end)));
        keySet = [1 2 3];
        valueSet = {arx(:,2:end), ary(:,2:end), arz(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'Accelerometer Data Analysis', 'Frequency', 'Accelerometer(R)', file_path, file_nm);
        % ARX end
        
        
        % EMG - L start
        file_path = strcat(fig_path,extractBefore(emg0l(1,1),';'),'/',extractAfter(emg0l(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'EMGL.png';
        x = linspace(0,45,length(emg0l(:,2:end)));
        keySet = [1 2 3 4 5 6 7 8];
        valueSet = {emg0l(:,2:end), emg1l(:,2:end), emg2l(:,2:end), emg3l(:,2:end), emg4l(:,2:end), emg5l(:,2:end), emg6l(:,2:end), emg7l(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'EMG Data Analysis', 'Frequency', 'EMG(L)', file_path, file_nm);
        % EMG - Lend
        
        % EMG - R start
        file_path = strcat(fig_path,extractBefore(emg0r(1,1),';'),'/',extractAfter(emg0r(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'EMGR.png';
        x = linspace(0,45,length(emg0r(:,2:end)));
        keySet = [1 2 3 4 5 6 7 8];
        valueSet = {emg0r(:,2:end), emg1r(:,2:end), emg2r(:,2:end), emg3r(:,2:end), emg4r(:,2:end), emg5r(:,2:end), emg6r(:,2:end), emg7r(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'EMG Data Analysis', 'Frequency', 'EMG(R)', file_path, file_nm);
        % EMG - R end
        
        
        % GLX start
        file_path = strcat(fig_path,extractBefore(glx(1,1),';'),'/',extractAfter(glx(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'GL.png';
        x = linspace(0,45,length(glx(:,2:end)));
        keySet = [1 2 3];
        valueSet = {glx(:,2:end), gly(:,2:end), glz(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'GyroScope Data Analysis', 'Frequency', 'GyroScope(L)', file_path, file_nm);
        % ALX end
        
        % GRX start
        file_path = strcat(fig_path,extractBefore(grx(1,1),';'),'/',extractAfter(grx(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'GR.png';
        x = linspace(0,45,length(grx(:,2:end)));
        keySet = [1 2 3];
        valueSet = {grx(:,2:end), gry(:,2:end), grz(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'GyroScope Data Analysis', 'Frequency', 'GyroScope(R)', file_path, file_nm);
        % GRX end
        
        
        
        % OL start
        file_path = strcat(fig_path,extractBefore(orl(1,1),';'),'/',extractAfter(orl(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'OL.png';
        x = linspace(0,45,length(orl(:,2:end)));
        keySet = [1 2 3];
        valueSet = {orl(:,2:end), opl(:,2:end), oyl(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'Orientation Data Analysis', 'Frequency', 'Orientation(L)', file_path, file_nm);
        % OL end
        
        % OR start
        file_path = strcat(fig_path,extractBefore(orr(1,1),';'),'/',extractAfter(orr(1,1),';'),'/');
        mkdir(char(file_path));
        file_nm = 'OR.png';
        x = linspace(0,45,length(orr(:,2:end)));
        keySet = [1 2 3];
        valueSet = {orr(:,2:end), opr(:,2:end), oyr(:,2:end)};
        y = containers.Map(keySet,valueSet);
        plotUtil(x,y,'Orientation Data Analysis', 'Frequency', 'Orientation(R)', file_path, file_nm);
        % OR end
    end
end
   


