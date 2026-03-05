function varargout = FruitDetection(varargin)
% FRUITDETECTION MATLAB code for FruitDetection.fig
%      FRUITDETECTION, by itself, creates a new FRUITDETECTION or raises the existing
%      singleton*.
%
%      H = FRUITDETECTION returns the handle to a new FRUITDETECTION or the handle to
%      the existing singleton*.
%
%      FRUITDETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRUITDETECTION.M with the given input arguments.
%
%      FRUITDETECTION('Property','Value',...) creates a new FRUITDETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FruitDetection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FruitDetection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FruitDetection

% Last Modified by GUIDE v2.5 25-Jun-2021 14:50:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FruitDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @FruitDetection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FruitDetection is made visible.
function FruitDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FruitDetection (see VARARGIN)

% Choose default command line output for FruitDetection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FruitDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FruitDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function timestamp_Callback(hObject, eventdata, handles)
% hObject    handle to timestamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timestamp as text
%        str2double(get(hObject,'String')) returns contents of timestamp as a double


% --- Executes during object creation, after setting all properties.
function timestamp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timestamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartCamera.
function StartCamera_Callback(hObject, eventdata, handles)
% hObject    handle to StartCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

datestr(clock);
cam = ipcam('http://192.168.31.152/video.cgi','admin','');

    a = datestr(clock);
    set(handles.timestamp, 'String', a);
    
    a = snapshot(cam);
    axes(handles.axes1);
    x = imshow(a);
   ImageFolder = 'C:\Users\AdminUser\Documents\PROJECT WORK\FRUIT DETECTION\template\TestImages';
   for i = 1
       x = snapshot(cam);
       file_name = sprintf('snapshot.png', i);
       fullFileName = fullfile(ImageFolder,file_name);
       imwrite(x,file_name,'png')
       pause(1);
       imshow(x)
       imgName = [ImageFolder, '\Image_',num2str(i),'.png'];
       imwrite(x,imgName);
   end
    

if(size(x,3)>1)
    x=rgb2gray(x);
end
x=double(x);
[m,n]=size(x);
x=imresize(x,[m,m]);
new_x=zeros(m,n);

% % %Code for Banana
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
    currentimage=double(currentimage);
    images{ii} = currentimage;
     new_x=corr2(x,currentimage);
    [valu(ii), idx(ii)]=max(max(new_x));
    
end


% 
% % % % code for apple

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
% % % 
% % % % code for watermelon
% % 
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


 banana=max(valu);
 apple=max(valu1);
 watermelon=max(valu2);


if  (watermelon>banana) && (watermelon>apple)
    output='Watermelon';
elseif (banana>apple) && (banana>watermelon)
    output='Banana';
elseif (apple>banana) && (apple>watermelon) 
    output='Apple';
else
    output='sorry,cannot recognize';
end
set(handles.edit2,'string',output);
% --- Executes on button press in StopCamera.
function StopCamera_Callback(hObject, eventdata, handles)
% hObject    handle to StopCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.StopCamera,'reset');


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
