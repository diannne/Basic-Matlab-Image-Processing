function varargout = tryimage1(varargin)
% TRYIMAGE1 MATLAB code for tryimage1.fig
%      TRYIMAGE1, by itself, creates a new TRYIMAGE1 or raises the existing
%      singleton*.
%
%      H = TRYIMAGE1 returns the handle to a new TRYIMAGE1 or the handle to
%      the existing singleton*.
%
%      TRYIMAGE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRYIMAGE1.M with the given input arguments.
%
%      TRYIMAGE1('Property','Value',...) creates a new TRYIMAGE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tryimage1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tryimage1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tryimage1

% Last Modified by GUIDE v2.5 29-Jun-2014 20:34:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tryimage1_OpeningFcn, ...
                   'gui_OutputFcn',  @tryimage1_OutputFcn, ...
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


% --- Executes just before tryimage1 is made visible.
function tryimage1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tryimage1 (see VARARGIN)

% Choose default command line output for tryimage1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tryimage1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
I0 = double(imread('question.jpg'))/255;
axes(handles.axes1);
imshow(I0);
axes(handles.axes2);
imshow(I0);
axes(handles.axes3);
imshow(I0);
global path;
path = '';
global target_path;
target_path='';





% --- Outputs from this function are returned to the command line.
function varargout = tryimage1_OutputFcn(hObject, eventdata, handles) 
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

%----------> here we load image

global im im2 path
[path,user_cance]=imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
im=imread(path);
im=im2double(im); %converts to double
im2=im; %for backup process :)
axes(handles.axes1);
imshow(im);
name = get(handles.radiobutton1,'String');
answ = strcmp( name , 'Color2Gray');
if ( answ == 1 )
    set(handles.edit1,'enable','on');
    set(handles.edit2,'enable','on');
    set(handles.edit3,'enable','on');
    set(handles.text1,'enable','on');
    set(handles.text2,'enable','on');
    set(handles.text3,'enable','on');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%------------>here we reset the image to original

global im2
axes(handles.axes1);
imshow(im2);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%------------>this is for black and white image

global im path target target_path
ans = strcmp(path,'');
if ( ans == 1 )
    errordlg('Please load source image ','Logic Error');
    return;
end
ans = strcmp(target_path,'');
if ( ans == 1 )
    errordlg('Please load target image ','Logic Error');
    return;
end

cur_path = getenv('PATH');
k = strfind(cur_path, ';C:\Users\Diana\Documents\Licenta\framework\Direct_Access_Image_Sample\Debug;');

if ( size(k) == 0 )
    setenv('PATH',[getenv('PATH') ';C:\Users\Diana\Documents\Licenta\framework\Direct_Access_Image_Sample\Debug;']);
end

cmd = sprintf('Direct_Access_Image_Sample.exe %s %s', path,target_path );
system(cmd);
path2 = sprintf('%s_Pitie.png',path);
impitie=imread(path2);
axes(handles.axes3);
imshow(impitie);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%----------->here we convert image to grayscale using r=g=b=(r+g+b)/3

global im path
ans = strcmp(path,'');
if ( ans == 1 )
    errordlg('Please load source image ','Logic Error');
    return;
end
theta = get(handles.edit1,'String');
alpha = get(handles.edit2,'String');
radius = get(handles.edit3,'String');
cur_path = getenv('PATH');
k = strfind(cur_path, ';C:\Users\Diana\Documents\Licenta\framework\Direct_Access_Image_Sample\Debug;');

if ( size(k) == 0 )
    setenv('PATH',[getenv('PATH') ';C:\Users\Diana\Documents\Licenta\framework\Direct_Access_Image_Sample\Debug;']);
end

cmd = sprintf('Direct_Access_Image_Sample.exe %s theta=%s alpha=%s radius=%s', path,theta,alpha,radius );
system(cmd);
path2 = sprintf('%s_GoochGray_theta=%s_alpha=%s_radius=%s.png',path,theta,alpha,radius);
path3 = sprintf('%s_BasicGray.png',path);
imgray=imread(path2);
axes(handles.axes2);
imshow(imgray);
imgray=imread(path3);
axes(handles.axes3);
imshow(imgray);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%---------------->here we implement simple brightness

global im2
val=0.5*get(hObject,'Value')-0.5;
imbright=im2+val;
axes(handles.axes1);
imshow(imbright);



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
%these are the runnning buttons
set(handles.pushbutton4,'enable','on');

set(handles.pushbutton3,'enable','off');

set(handles.radiobutton2,'Value',0);
set(handles.edit1,'Visible','on');
set(handles.edit2,'Visible','on');
set(handles.edit3,'Visible','on');
set(handles.text1,'Visible','on');
set(handles.text2,'Visible','on');
set(handles.text3,'Visible','on');
set(handles.pushbutton5,'Visible','off');
set(handles.pushbutton6,'Visible','off');



% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.pushbutton4,'enable','off');
set(handles.pushbutton3,'enable','on');
set(handles.pushbutton5,'Visible','on');
set(handles.pushbutton6,'Visible','on');
set(handles.radiobutton1,'Value',0);
set(handles.edit1,'Visible','off');
set(handles.edit2,'Visible','off');
set(handles.edit3,'Visible','off');
set(handles.text1,'Visible','off');
set(handles.text2,'Visible','off');
set(handles.text3,'Visible','off');





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
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


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1




% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3




% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%set(handles.radiobutton2,'Value',0);
set(hObject,'Value',1);


% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'enable','off');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

global target target2 target_path
[target_path,user_cance]=imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
target=imread(target_path);
target=im2double(target); %converts to double
target2=target; %for backup process :)
axes(handles.axes2);
imshow(target);
set(handles.pushbutton3,'enable','on');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'visible','off');


% --- Executes during object creation, after setting all properties.
function pushbutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'visible','off');
