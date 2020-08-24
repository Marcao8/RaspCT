Pfad = 'C:\Users\';%Pfad in dem die Bilder des Detektors liegen
file = dir(fullfile((Pfad),'*.png'));                                       % Array mit x*1 Einträgen, wobei x = Anzahl der Dateien(+Unterordner) im Pfad
D = 12002;
Stepsize = 3.6;
NSteps = 100;
theta = Stepsize:Stepsize:NSteps*Stepsize;

tic;                                                        %jeder Eintrag ist ein Link zu einem Bild
NF = length(file);                                      % Anzahl der Daten im Ordner erzeugen
images = cell(NF,1);                                    %Matrix anlegen in der Bilddaten eingefügt werden
Groesse = imread(fullfile(Pfad, file(1).name));
[height, width, dim] = size(Groesse);
sinogram = zeros([NF,width]);
    for k = 1 : NF                                          %
   %Beliebige Bearbeitung der Bilddaten
   images{k} = imread(fullfile(Pfad, file(k).name));     %öffne Einzelbild, lies Pixeldaten in images Matrix
   
   img=images{k};
   %img=rgb2gray(img);
   %img = medfilt2(img,[5 5]);
   %img=rgb2gray(images{k});
   %Kmedian = medfilt2(img,[5 5]); %filtert das Salt'n'pepper Rauschen
   sinogram(k,:) = img(400,:); %(
   
    end

    figure;
    subplot(1,2,1)
    sinogram = permute(sinogram,[2 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%    
%mask = sinogram > 50;          %Threshholding um die Ugebung des Objekts wirklich 0 zu setzen
%sinogram(~mask) = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%

slice = iradon(sinogram,theta);
imagesc(sinogram)
colormap(gray);
h=colorbar;
ylabel(h, 'Absorbtion');
xlabel('Rotationswinkel - \theta (\circ)'); 
xticks([1 25 50 75 100])
xticklabels({'0','90','180','270','360'});
ylabel('Sensor Position - x\prime ');

subplot(1,2,2)
slice = iradon(sinogram,theta,max(size(img)),'pchip','Hamming');%,max(size(img))
%slice=  ifanbeam(sinogram,D,'FanRotationIncrement',3.6,'FanSensorGeometry','line'); 
% D = Distance in pixels from the fan-beam vertex to the center of rotation, specified as a positive number
imagesc(slice)
disp('Fertig')
toc
