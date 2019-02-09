function [Images, imNames] = load_all_images(folderPath, extention)
%Stores in memory all images of a folder.
%Note: it may also work with files that are not images, but the code was
%not tested for that.
%Imput:
% folderPath: string idicating the folder where the imagers are stored.
% extention: string indicating the extention of the image. 'jpg', 'png',
% 'gif', etc.
%Output:
% Images: An array with all images stored.
% imNames: the name of each image.

%error message if the path does not exist.
if ~isfolder(folderPath)
    errorMessage = sprintf('The selected folders was not found: ');
    uiwait(warnlg(errorMessage));
    return;
end

f = waitbar(0, 'Loading Images'); %progress bar

ext = "*." + extention;
filePattern = fullfile(folderPath, ext);
files = dir(filePattern); %contain the details of all images.
num_files = length(files);
imNames = strings(num_files);

%load all images and file names.
for k = 1:num_files
    %store image name
    imNames(k) = files(k).name;
    
    %store image
    filePath = fullfile(folderPath, imNames(k));
    Images{k} = imread(filePath); 
    
    waitbar(k/num_files, f); 
end
close(f)
end