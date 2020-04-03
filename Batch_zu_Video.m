Pfad = 'C:\Users\Regis_PC\Desktop\BA\Matlab\Kunal_ConeBeam\Slice Capture\Slice Capture\';%Pfad in dem die Bilder des Detektors liegen
file = dir(fullfile((Pfad),'*.png'));                                       % Array mit x*1 Eintr�gen, wobei x = Anzahl der Dateien(+Unterordner) im Pfad
                                                        %jeder Eintrag ist ein Link zu einem Bild
NF = length(file);                                      % Anzahl der Daten im Ordner erzeugen
images = cell(NF,1);                                    %Matrix anlegen in der Bilddaten eingef�gt werden
outputVideo = VideoWriter(fullfile(Pfad,'neu.avi'));  %Video Container anlegen in den Bilder eingef�gt werden
outputVideo.FrameRate = 18;                             %Framerate angeben
open(outputVideo)
for k = 1 : NF                                          %
   %Beliebige Bearbeitung der Bilddaten
   images{k} = imread(fullfile(Pfad, file(k).name));     %�ffne Einzelbild, lies Pixeldaten in images Matrix
   writeVideo(outputVideo,images{k} )                    %schreibe Frame aus images in Video 
end
%for k = 1 : NF                                          %
   %Beliebige Bearbeitung der Bilddaten
  % images{k} = imread(fullfile(Pfad, file(k).name));     %�ffne Einzelbild, lies Pixeldaten in images Matrix
  % writeVideo(outputVideo,images{k} )                    %schreibe Frame aus images in Video 
%end
close(outputVideo)                                      
disp('Fertig')