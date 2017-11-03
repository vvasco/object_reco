%% script to create a file of labels in the format accepted by caffe %%
% output format: folder/img_0000.jpg LABEL

clc;
clear;

%input folder
folder = './data/neuro_iCub/test/';
subfolder = dir(fullfile([folder '*']));
nobjects = length(subfolder);

%output
outfile = './data/neuro_iCub/test/test_list.txt';
fid = fopen(outfile,'wt');

ifile = 1;
for i = 1 : nobjects
    
    %the name of the folder is the label of the object
    currobj = subfolder(i).name;
    folderobj = dir(fullfile([folder currobj '/*.ppm']));
    nimages = length(folderobj);
    
    %for every instance of this object
    for j = 1 : nimages
    
        %convert ppm to jpg
        disp(['Converting image ' num2str(j) ' for object ' currobj]);
        currimgname = folderobj(j).name;
        currimg = [folder currobj '/' currimgname];
        I = imread(currimg);
        k = find(currimg == '.');
        if(length(k) > 1)
            k = k(end);
        end
        imwrite(I, [currimg(1:k-1) '.jpg']);
        
        %extract label and write it as output
        m = find(currimgname == '.');
        label = currobj;
        string = ['/' currobj '/' currimgname(1:m-1) '.jpg' ' ' label];
        fprintf(fid, '%s\n', string);

    end
    clc;
    
end

fclose(fid);