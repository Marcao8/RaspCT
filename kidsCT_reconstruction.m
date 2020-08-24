clear all; clc

%Pfad in dem die nachbearbeiteten Bilder liegen
Pfad = 'C:\Users\***';
newfolder = '\slices';

newfolder_path = [Pfad,newfolder];
theta = linspace(0,358.2,199);

if ~exist(newfolder_path, 'dir')
    mkdir(newfolder_path)
end

file = dir(fullfile(Pfad,'*.png'));
NF = length(file);
sample_im = imread(fullfile(Pfad, file(1).name));
[height, width, dim] = size(sample_im);
s = max([height width]);

slices_vec=1:10:height;
% slices_vec=400;
final_slice=slices_vec(end);
jj=length(slices_vec);
ind=0;

% h=waitbar(0,'in progress...');
for j=slices_vec
    str = sprintf('...calculating slice %d of %d ...',j,final_slice);
    disp(str)
    sinogram = zeros(width,NF);
%     waitbar(ind/jj,h,'in progress...');
    
    for k = 1 : NF
        img = imread(fullfile(Pfad, file(k).name));
        sinogram(:,k) = img(j,:);
    end
    
    %     figure(2)
    %     imagesc(imcomplement(sinogram))
    %     colormap(gray)

    slice = iradon(sinogram,theta,'linear','Hamming',1,s);
%     slice =  ifanbeam(sinogram,D,'FanRotationIncrement',3.6,'FanSensorGeometry','line');
%     slice(slice<0)=0;
    slice = slice-min(min(slice));
    slice = slice./max(max(slice));
    
%     figure(3)
%     imagesc(slice)
%     colormap(gray)
%     axis square

    filename = sprintf('slice_%04d.png',j);
    imwrite(slice,[newfolder_path,'\',filename])
    ind=ind+1;
end
% delete(h)
