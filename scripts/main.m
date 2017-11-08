%% Folder script
clc
clear
close all

%% Param
% Choose the path were WAV files are stored. Put the absolute path and not
% the relative one.
pathIn  = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/audioBank/data_solo';

% Choose were the data produced will be stored. A subfolder named 'data'
% will be created.
pathOut = '/Users/laclouis5/Downloads';

% Choose the number of LPC coeff, the threshold for removing speech blank
% and others. Default: et f_ech = 8000, thresh = '', nb_coeff = 20.
f_ech    = 8000;
thresh   = '';
nb_coeff = 20;

%% Main
currDir = cd;

if isfolder(pathIn) && isfolder(pathOut)
    
    % init
    subFolder = 'data';
    mkdir(pathOut, subFolder);
    cd(pathIn);
    
    myFolderInfo = dir;
    myFileList   = dir('**/*.wav');
    myFolderSize = length(myFolderInfo);
    myFileNumber = length(myFileList);
    
    % read
    if isempty(myFileList)
        error('Files must me in .waw type');
        
    else

        for idx = 1:myFileNumber
           
            % path to read
            cd(pathIn);
            path = strcat(myFileList(idx).folder, '/', myFileList(idx).name);
            
            % function
            fileOut = f_LPC(path, f_ech, 20, thresh, 30, 15);
            
            % file out and disp
            nameOut = replace(myFileList(idx).name, '.wav', '');
            nameOut = strcat(nameOut, '.mat');
            
            cd(strcat(pathOut, '/', subFolder));
            save(nameOut, 'fileOut');
            
            avancement = idx / myFileNumber;
            clc;
            fprintf('Percent achieved: %.2f%%\n', 100*avancement);
        end
        
        clc;
        fprintf('Done!\n');
    end
    
else
    
    error('PathIn or PathOut do no path does not exist');
end

cd(currDir);