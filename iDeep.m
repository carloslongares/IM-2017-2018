function varargout = iDeep(varargin)
% IDEEP MATLAB code for iDeep.fig
%      IDEEP, by itself, creates a new IDEEP or raises the existing
%      singleton*.
%
%      H = IDEEP returns the handle to a new IDEEP or the handle to
%      the existing singleton*.
%
%      IDEEP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IDEEP.M with the given input arguments.
%
%      IDEEP('Property','Value',...) creates a new IDEEP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iDeep_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iDeep_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iDeep

% Last Modified by GUIDE v2.5 09-Feb-2018 21:54:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iDeep_OpeningFcn, ...
                   'gui_OutputFcn',  @iDeep_OutputFcn, ...
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


% --- Executes just before iDeep is made visible.
function iDeep_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for iDeep
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% INICIALIZACION VARIABLE GLOBALES
global IControlPoints;
IControlPoints = [];
global imagesNumber;
imagesNumber = 0;
global currentImage;
currentImage = 0;

%CONFIGURACIONES INICIALES DE LOS ELEMENTOS DE LA GUI
set(handles.uitable2,'Data',cell(0,3));


% --- Outputs from this function are returned to the command line.
function varargout = iDeep_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on load image button.
function pushbutton1_Callback(hObject, eventdata, handles)
global images;
global imagesNumber;
[FileName,PathName] = uigetfile('*.mat','Select image');
if FileName
    images = load(strcat(PathName,"\",FileName));
    n = size(images.imagenes);
    imagesNumber = n(3);
    showNextImage();
end

    
%shows the number imgNumber image of the images loaded if the images loaded
%are only one then imgNumber havea to be 1.
function showNextImage()
global images
global currentImage
global imagesNumber;
currentImage = currentImage+1;
if currentImage <= imagesNumber
    %Mascaras (como deberia quedar la imagen al ser 'recortada')
    %imshow(images.mascaras(:,:,n),[])

    %Imagenes originales
    imshow(images.imagenes(:,:,currentImage),[])
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
    global IControlPoints
    %Obtencion de los pixeles clicados (de momento 4)posicion TODO: que hacer con estos puntos
    if get(hObject,'Value')
        [x,y] = getpts();
        sizeX = size(x);
        numberPoints = sizeX(1);
    
        %coger la clase del comboBox
        selectedClass = get(handles.popupmenu1,'Value');
        if numberPoints
            for i =1:numberPoints
               IControlPoints = [IControlPoints;x(i),y(i),selectedClass];
            end
            set(handles.uitable2,'data',IControlPoints);
        end
        showPoints();
    end
    set(hObject,'Value',0) 
% Hint: get(hObject,'Value') returns toggle state of checkbox1


function showPoints()
    global IControlPoints;
    n = size(IControlPoints(:,1));
    axis on
    hold on;
    color = ['r','b'];
    for i = 1:n
        plot(IControlPoints(i,1),IControlPoints(i,2), strcat(color(IControlPoints(i,3)),'+'), 'MarkerSize', 7, 'LineWidth', 1);
    end

    
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[file,path] = uiputfile('*.mat','Save file name');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.mat','Select network file');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
[file,path] = uiputfile('*.mat','Save network');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
showNextImage()

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)



% UIWAIT makes iDeep wait for user response (see UIRESUME)
% uiwait(handles.figure1);


