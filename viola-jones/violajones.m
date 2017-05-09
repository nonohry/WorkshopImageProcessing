function varargout = violajones(varargin)
% VIOLAJONES MATLAB code for violajones.fig
%      VIOLAJONES, by itself, creates a new VIOLAJONES or raises the existing
%      singleton*.
%
%      H = VIOLAJONES returns the handle to a new VIOLAJONES or the handle to
%      the existing singleton*.
%
%      VIOLAJONES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIOLAJONES.M with the given input arguments.
%
%      VIOLAJONES('Property','Value',...) creates a new VIOLAJONES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before violajones_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to violajones_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help violajones

% Last Modified by GUIDE v2.5 08-May-2017 18:13:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @violajones_OpeningFcn, ...
                   'gui_OutputFcn',  @violajones_OutputFcn, ...
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


% --- Executes just before violajones is made visible.
function violajones_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to violajones (see VARARGIN)

% Choose default command line output for violajones
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes violajones wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = violajones_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.*');
if ~isequal(filename,0)
    handles.data1 = imread(fullfile(pathname,filename));
    guidata(hObject,handles);
    axes(handles.axes1)
    cla reset
    imshow(handles.data1);
else
    return
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = handles.data1;
%To detect Mouth
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);

BB=step(MouthDetect,X);


axes(handles.axes2)
imshow(handles.data1); hold on
for i = 1:size(BB,1)
 rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
%title('Mouth Detection');
hold off;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = handles.data1;

%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');

BB=step(EyeDetect,X);

axes(handles.axes2)
imshow(handles.data1);
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
%title('Eyes Detection');
Eyes=imcrop(X,BB);
figure,imshow(Eyes);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = handles.data1;
%To detect Nose
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);

BB=step(NoseDetect,X);

axes(handles.axes2)
imshow(handles.data1);
hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','b');
end
%title('Nose Detection');
hold off;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X = handles.data1;
%To detect Face
FDetect = vision.CascadeObjectDetector;

%Returns Bounding Box values based on number of objects
BB = step(FDetect,X);

axes(handles.axes2)
imshow(handles.data1);
hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
%title('Face Detection');
hold off;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close()

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getframe(gca);
[filename2,pathname2] = uiputfile(...
    {'*.bmp','bitmap image (*.bmp)';
    '*.jpg','jpeg image(*.jpg)';
    '*.*','All file(*.*)'},...
    'Save Image');
if ~isequal(filename2,0)
    imwrite(img.cdata,fullfile(pathname2,filename2));
else
    return
end
