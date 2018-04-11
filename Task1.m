folderList = ["DM07","DM08","DM28","DM34","DM34"];
baseDir = 'C:\MyStuff\ASU\Spring_2018\DM\Project\Phase2';
gestureList = ["ABOUT","CAN","AND","COP","DEAF","DECIDE","FATHER","FIND","GO OUT","HEARING"];
sensorList = ["ALX","ALY","ALZ","ARX","ARY","ARZ","EMG0L","EMG1L","EMG2L","EMG3L","EMG4L","EMG5L","EMG6L","EMG7L","EMG0R","EMG1R","EMG2R","EMG3R","EMG4R","EMG5R","EMG6R","EMG7R","GLX","GLY","GLZ","GRX","GRY","GRZ","ORL","OPL","OYL","ORR","OPR","OYR"];
finalFileNames = ["About.csv","Can.csv","And.csv","Cop.csv","Deaf.csv","Decide.csv","Father.csv","Find.csv","Goout.csv","Hearing.csv"];
for m=1:length(folderList)
    wrkDir = char(folderList(m));
    baseDir = fullfile(baseDir,wrkDir);
    mkdir('Output');
    chdir('Output');
    files = dir(baseDir);
    for i=1:length(gestureList)
       dataMat = [];
       count = 0;
       for k=3:length(files)
           filename = fullfile(baseDir,files(k).name);
           if contains(filename,gestureList(i),'IgnoreCase',true)
               count = count + 1;
               disp(filename)
               M = readtable(filename);
               M = table2array(M(1:end,1:34));
               [r,c] = size(M);
               if (r < 45 )
                   diff = 45-r;
                   paddArr = zeros(diff,34);
                   M = cat(1,M,paddArr);
               elseif (r > 45)
                   M = M(1:45,:);
               end
               M = transpose(M);
               action = gestureList(i) + count;
               header = strcat(action,",",sensorList.');
               M = cat(2,header,M);
               dataMat = cat(1,dataMat,M);
           end
       end
       fprintf('Writing file About.csv')
       writetable(array2table(dataMat),finalFileNames(i));
    end
end
%yourpath = pwd;
%filename = fullfile(pwd,'D')
%M = xlsread(filename,'A:AH');