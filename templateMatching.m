 function [output]= templateMatching(MyImage)
[filename,pathname] = uigetfile({'.jpg'});
 image = strcat(pathname,filename);
 x = imread(image);
% cam = ipcam('http://192.168.31.152:80/video.cgi','admin','');
% a = snapshot(cam);
% x = imshow(a);
if(size(x,3)>1)
    x=rgb2gray(x);
end
x=double(x);
[m,n]=size(x);
x=imresize(x,[m,m]);
new_x=zeros(m,n);

%Code for Banana
imagefiles_banana = dir('template\bannana\*.*');
nfilesbanana = length(imagefiles_banana);
outputMatchingResultbanana=zeros(2,nfilesbanana);
valu=[];idx=[];
for ii=3:nfilesbanana
    currentfilename = fullfile(imagefiles_banana(ii).folder,imagefiles_banana(ii).name);
    currentimage = imread(currentfilename);
    if(size(currentimage,3)>1)
        currentimage=rgb2gray(currentimage);
    end
    [p,q]=size(currentimage);
    currentimage=imresize(currentimage,[m,m]);
%     x=padarray(x,[floor(p/2),floor(p/2)]);
    currentimage=double(currentimage);
    images{ii} = currentimage;
     new_x=corr2(x,currentimage);
    [valu(ii), idx(ii)]=max(max(new_x));
    
end



% code for apple

imagefiles_apple = dir('template\apples\*.*');
nfilesapple = length(imagefiles_apple);
outputMatchingResultapple=zeros(2,nfilesapple);
for ii=3:nfilesapple
    currentfilename = fullfile(imagefiles_apple(ii).folder,imagefiles_apple(ii).name);
    currentimage = imread(currentfilename);
    if(size(currentimage,3)>1)
        currentimage=rgb2gray(currentimage);
    end
    [p,q]=size(currentimage);
    currentimage=imresize(currentimage,[m,m]);
    currentimage=double(currentimage);
    images{ii} = currentimage;
    new_x=corr2(x,currentimage);
    [valu1(ii), idx1(ii)]=max(max(new_x));
end

% code for watermelon

imagefiles_watermelon = dir('template\watermelon\*.*');
nfileswatermelon = length(imagefiles_watermelon);
outputMatchingResultwatermelon=zeros(2,nfileswatermelon);
for ii=3:nfileswatermelon
    currentfilename = fullfile(imagefiles_watermelon(ii).folder,imagefiles_watermelon(ii).name);
    currentimage = imread(currentfilename);
    if(size(currentimage,3)>1)
        currentimage=rgb2gray(currentimage);
    end
    [p,q]=size(currentimage);
    currentimage=imresize(currentimage,[m,m]);
    currentimage=double(currentimage);
    images{ii} = currentimage;
    new_x=corr2(x,currentimage);
    [valu2(ii), idx2(ii)]=max(max(new_x));
end


% code for grapes

% imagefiles_grapes = dir('template\grapes\*.*');
% nfilesgrapes = length(imagefiles_grapes);
% outputMatchingResultgrapes=zeros(2,nfilesgrapes);
% for ii=3:nfileswatermelon
%     currentfilename = fullfile(imagefiles_grapes(ii).folder,imagefiles_grapes(ii).name);
%     currentimage = imread(currentfilename);
%     if(size(currentimage,3)>1)
%         currentimage=rgb2gray(currentimage);
%     end
%     [p,q]=size(currentimage);
%     currentimage=imresize(currentimage,[m,m]);
%     currentimage=double(currentimage);
%     images{ii} = currentimage;
%     new_x=corr2(x,currentimage);
%     [val3(ii), idx3(ii)]=max(max(new_x));
% end



banana=max(valu);
apple=max(valu1);
watermelon=max(valu2);
% grapes=max(val3);

if (watermelon>apple)  && (watermelon>banana)
    output='Watermelon';
% elseif (grapes>apple) && (watermelon<grapes) && (grapes>banana)
%     output='Grapes';
elseif (banana>apple) && (banana>watermelon) 
    output='Banana';
elseif (apple>banana) && (apple>watermelon) 
    output='Apple';
else
    output='sorryyy....I could not';
end


