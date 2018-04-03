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

% Last Modified by GUIDE v2.5 15-Feb-2018 18:05:23

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

global samples;
samples = [];

global imagesNumber;
imagesNumber = 0;

global currentImageIndex;
currentImageIndex = 0;

global currentImage;
currentImage = 0;

global currentImageSize;
currentImageSize = 0;

global zonePointSize;
zonePointSize = 16;

global classes;
classes = [];

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


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
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
     
        set(findobj('Tag','text2'), 'Enable', 'on');
        set(findobj('Tag','pushbutton2'), 'Enable', 'on');
        set(findobj('Tag','pushbutton3'), 'Enable', 'on');
        set(findobj('Tag','pushbutton4'), 'Enable', 'on');
        set(findobj('Tag','uitable2'), 'Enable', 'on');
        set(findobj('Tag','popupmenu1'), 'Enable', 'on');
        set(findobj('Tag','StartSelectionBtn'), 'Enable', 'on');
        set(findobj('Tag','pushbutton9'), 'Enable', 'on');
    end

    

function showNextImage()
    global images;
    global currentImageIndex;
    global imagesNumber;
    global currentImageSize;
    global currentImage;
 
    currentImageIndex = currentImageIndex+1;
    if currentImageIndex <= imagesNumber
        %Mascaras (como deberia quedar la imagen al ser 'recortada')
        %imshow(images.mascaras(:,:,n),[])

        %Imagenes originales
        currentImage = imrotate(images.imagenes(:,:,currentImageIndex),90);
        currentImageSize = size(currentImage);
        imshow(currentImage,[]);
    end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    [file,path] = uiputfile('*.mat','Save file name');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
    global net;
    [FileName,PathName] = uigetfile('*.mat','Select network file');
    if FileName
        data=load(strcat(PathName,"\",FileName));
        net=data.net;
        set(findobj('Tag','pushbutton9'), 'Enable', 'on');
        set(findobj('Tag','pushbutton10'), 'Enable', 'on');
        set(findobj('Tag','text7'), 'Visible', 'on' );
        set(findobj('Tag','text7'), 'String', 'Network ' + string(FileName) + ' loaded!' );
    end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    global net;
    [file,path] = uiputfile('*.mat','Save network');
    save(strcat(path,"\",file),'net');

% --- Executes on button press in pushbutton9.%TrainBTN
function pushbutton9_Callback(hObject, eventdata, handles)
    global samples;
    global classes;
    global net;

    [samples2,classes2]=shuffleRand4D(samples,classes);
    
    [myNet,traininfo] = trainCNN(samples2,classes2);
    net = myNet;
    set(findobj('Tag','pushbutton4'), 'Enable', 'on');
    set(findobj('Tag','pushbutton10'), 'Enable', 'on');
    
%TODO: Cambiar de sitio esto no debe ocurrir cuando se entrene a la red.
%global IControlPoints;
%IControlPoints = [];%Remove points of prev. images.
%set(findobj('Tag','uitable2'), 'Data', {})%Clear UI Table uitable2



% --- Executes on button press in StartSelectionBtn.
function StartSelectionBtn_Callback(hObject, eventdata, handles)
    global IControlPoints
    global currentImageSize;
    global samples;
    global classes;
    if get(hObject,'Value')
        set(findobj('Tag','SelectionText1'), 'Visible', 'on')
        set(findobj('Tag','SelectionText2'), 'Visible', 'on') 
        [x,y] = getpts();
        set(findobj('Tag','SelectionText1'), 'Visible', 'off')
        set(findobj('Tag','SelectionText2'), 'Visible', 'off')
        sizeX = size(x);
        numberPoints = sizeX(1);
        %coger la clase del comboBox
        selectedClass = get(handles.popupmenu1,'Value');
        if numberPoints
            for i =1:numberPoints
               if (x(i) >= 0) && (x(i) <= currentImageSize(2)) && (0 <= y(i)) && (y(i) <= currentImageSize(1))
                IControlPoints = [IControlPoints;x(i),y(i),selectedClass];
                samples = cat(4,samples,getPointsArround(x(i),y(i)));
                classes = [classes;selectedClass];
               end
            end
            set(handles.uitable2,'data',IControlPoints);
        end
        showPoints();
    end

function currentSample = getPointsArround(x,y)
    global images;
    global currentImage;
    global zonePointSize;
    
    currentSample = zeros(zonePointSize,zonePointSize);
    radiusArea = zonePointSize/2;
    n= 1;
    for i=y-radiusArea:y+radiusArea-1
        m = 1;
        for j=x-radiusArea:x+radiusArea-1
            try
                currentSample(n,m)= currentImage(round(i),round(j));
            end
            m=m+1;
        end
        n=n+1; 
        assignin('base','samp',currentSample);
    end
 

        
function showPoints()
    global IControlPoints;
    if not(isempty(IControlPoints))
       n = size(IControlPoints(:,1));
       axis on
       hold on;
       color = ['r','b'];
       for i = 1:n
         plot(IControlPoints(i,1),IControlPoints(i,2), strcat(color(IControlPoints(i,3)),'+'), 'MarkerSize', 7, 'LineWidth', 1);
       end
    end
 
    
    % --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
    tic
    test();
    t = toc
    minitest();



function test()
    global currentImageIndex;
    global currentImage;
    global images;
    points = segment();
    [imageOv] =  showOverlapPoints(points,currentImage,5);
    imshow(imageOv,[]);


function [points] = segment()
    global zonePointSize;
    global currentImageSize;
    global currentImage;
    global net;
    global IControlPoints;
    
    sampleSet = [];
    points = [];
    radius = zonePointSize/2;
    jstart = radius+1;
    f = waitbar(0,'Tessting');
    firstOfTheRow = getPointsArround(1 , 1);
  
    for i=1:currentImageSize(1)
        currentSample= firstOfTheRow;
        sampleRow=[currentSample];
        s = 1;
        points = [points;i s];
        s= s+1;
        for j=jstart:currentImageSize(2)+radius -1
            currentSample(:,1) = [];
            nextColumn = zeros(zonePointSize,1);
            points = [points;i s];
            s= s+1;
            n=1;
            for z=i-radius :i+(radius )-1
                try
                    nextColumn(n) = currentImage(z,j+1);
                end
                n = n+1;
            end
            currentSample = [currentSample nextColumn];
            sampleRow = cat(4,sampleRow,currentSample);
        end
        sampleSet =  cat(4,sampleSet,sampleRow);
        
        firstOfTheRow(1,:) = [];
        nextRow= zeros(1,zonePointSize);
        n=1;
        for z=1-radius :1+(radius )-1
            try
                nextRow(n) = currentImage(i+1,z);
            end
            n = n+1;
        end
        firstOfTheRow = [firstOfTheRow; nextRow];
        
        waitbar(i/currentImageSize(1));
    end
    
    labels = grp2idx(classify(net,sampleSet));
    points =[points labels];
    close(f);
    
  
    

function minitest()
    global net;
    global IControlPoints;
    sizeControlPoints = size(IControlPoints);
    points = [];
    for i=1:sizeControlPoints(1)
        points=[points;IControlPoints(i,1) IControlPoints(i,2) grp2idx(classify(net,getPointsArround(IControlPoints(i,1),IControlPoints(i,2))))];
        %points = cat(4,points,getPointsArround(IControlPoints(i,1),IControlPoints(i,2)));
    end
    B = points == IControlPoints;
    errors = sum(B(:,3) == 0)



