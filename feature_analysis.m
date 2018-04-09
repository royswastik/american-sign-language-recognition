ext_obj = extraction_methods;

fl_nms = {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Goout', 'Hearing'};

file_path_separator = '/';
file_path = '/Users/jaydeep/jaydeep_workstation/ASU/Spring2018/MC_535/project/';

% if feature.csv is present before hand then delete 
delete(strcat(file_path,'features.csv'))


for fl_nm_ind = 1:length(fl_nms)
    fig_path = strcat(file_path,fl_nms(fl_nm_ind),file_path_separator);
    fl_nm = char(strcat('actions/', fl_nms(fl_nm_ind),'.csv'));
    fid = fopen(fl_nm, 'rt');

    datatypes = '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
    data = textscan(fid,datatypes,'headerlines', 1, 'delimiter', ',');
    fclose(fid); 
    height = length(data{1}) - 34 +1;
    
    for row = 1:34:height
%     for row = 1:34:67
        alx =[];aly =[];alz =[];arx =[];ary =[];arz =[];
        glx =[];gly =[];glz =[];grx =[];gry =[];grz =[];
        orl =[];opl =[];oyl =[];orr =[];opr =[];oyr =[];
        emg0l = [];emg1l = [];emg2l = [];emg3l = [];emg4l = [];emg5l = [];emg6l = [];emg7l = [];
        emg0r = [];emg1r = [];emg2r = [];emg3r = [];emg4r = [];emg5r = [];emg6r = [];emg7r = [];
        for col = 1:46
            
%             Gettings sensors values for each action
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
        
        
%         Setting features for classification task
        tmp_feature = [ext_obj.maxFFT(alx(:,2:end)), ext_obj.maxFFT(aly(:,2:end)), ext_obj.maxFFT(alz(:,2:end))];
        tmp_feature = [tmp_feature, ext_obj.maxFFT(arx(:,2:end)) ext_obj.maxFFT(ary(:,2:end)) ext_obj.maxFFT(arz(:,2:end))];
        tmp_feature = [tmp_feature, ext_obj.maxFFT(emg0l(:,2:end)) ext_obj.maxFFT(emg1l(:,2:end)) ext_obj.maxFFT(emg2l(:,2:end)) ext_obj.maxFFT(emg3l(:,2:end)) ext_obj.maxFFT(emg4l(:,2:end)) ext_obj.maxFFT(emg5l(:,2:end)) ext_obj.maxFFT(emg6l(:,2:end))];
        tmp_feature = [tmp_feature, ext_obj.maxFFT(emg0r(:,2:end)) ext_obj.maxFFT(emg1r(:,2:end)) ext_obj.maxFFT(emg2r(:,2:end)) ext_obj.maxFFT(emg3r(:,2:end)) ext_obj.maxFFT(emg4r(:,2:end)) ext_obj.maxFFT(emg5r(:,2:end)) ext_obj.maxFFT(emg6r(:,2:end))];
        tmp_feature = [tmp_feature, ext_obj.maxFFT(glx(:,2:end)) ext_obj.maxFFT(gly(:,2:end)) ext_obj.maxFFT(glz(:,2:end))];
        tmp_feature = [tmp_feature, ext_obj.maxFFT(grx(:,2:end)) ext_obj.maxFFT(gry(:,2:end)) ext_obj.maxFFT(grz(:,2:end))];
        tmp_feature = [tmp_feature, ext_obj.maxFFT(orl(:,2:end)) ext_obj.maxFFT(opl(:,2:end)) ext_obj.maxFFT(oyl(:,2:end))];
        tmp_feature = [tmp_feature, ext_obj.maxFFT(orr(:,2:end)) ext_obj.maxFFT(opr(:,2:end)) ext_obj.maxFFT(oyr(:,2:end))];
        
        
        
        feature_row = tmp_feature;
        feature_file = strcat(file_path,'features.csv');
        dlmwrite(feature_file,feature_row,'-append');
   
    end
end