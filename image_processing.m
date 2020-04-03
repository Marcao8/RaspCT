clear all; clc

%Pfad in dem die Bilder des Detektors liegen
Pfad = 'D:\Research\kids CT - Marcus\2020_01_30 - neueFolie';
newfolder = '\processed';

newfolder_path = [Pfad,newfolder];
mkdir(newfolder_path)
file = dir(fullfile(Pfad,'*.jpeg'));
NF = length(file);


%%
h=waitbar(0,'in progress...');
for k = 1 : NF
    waitbar(k/NF,h,'in progress...');

    img = imread(fullfile(Pfad, file(k).name));
    img = rgb2gray(img);
%     img = imcomplement(img);
    img = medfilt2(img,[9 9]);
%     img = imsharpen(img,'Amount',1.9);
    filename = sprintf('projection_%03d.png',k);
    imwrite(img,[newfolder_path,'\',filename])
end
delete(h)