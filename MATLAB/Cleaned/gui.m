function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 24-Jun-2016 00:45:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
if nargin>=4 
    handles.diretorio = varargin{1}.diretorio;
    handles.defined = 0;
    if isfield(varargin{1},'file')
        handles.file = varargin{1}.file;
        handles.defined = 1;
        fileList_Callback(hObject,eventdata,handles);        
    end
    
else
    diretorio = './';
    handles.diretorio = diretorio;
end
x = dir([handles.diretorio '*.txt']);
string = [];
for i=1:length(x)
    string = char(string,x(i).name);
end
set(handles.fileList,'string',string);


handles.legendS = {'K','Ti','Td'};
handles.legendP = {'K','Ki','Kd'};
handles.param = [];

handles.initial = 99;
handles.final = 99;

handles.initialJ = 99;
handles.finalJ = 99;
% Choose default command line output for gui
handles.output = hObject;
setappdata(handles.figure1,'slidervalue',0);

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in buttonTime.
function buttonTime_Callback(hObject, eventdata, handles)
% hObject    handle to buttonTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig = figure();

alpha = handles.M(1:3,1);
gamma = handles.M(1:3,2);
omega = handles.M(1:3,3);
PID0 =  handles.M(1:3,4);

[~,~,~,~,user,ref,control,tempo] = rotinaReconstrucaoJ(alpha,...
    gamma,omega,1/2,PID0,handles.file,handles.diretorio);
subplot(3,1,[1 2]);
plot(tempo,user,'b','LineWidth',3);hold on
plot(tempo,ref,'r--','LineWidth',3);hold off
axis([0, inf, -inf,70])
subplot(3,1,3);
plot(tempo,control(:,1),'r',tempo,control(:,2),'g')
axis([0 inf -inf inf])


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


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
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function paramTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paramTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% data = get(handles.paramTable,'data')



% --- Executes on button press in updateParam.
function updateParam_Callback(hObject, eventdata, handles)
% hObject    handle to updateParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in fileList.
function fileList_Callback(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.defined ==0
str = get(hObject, 'String');
val = get(hObject,'Value');

handles.file = str{val};

handles.file = strtrim(handles.file);    
handles.defined = 0;
end

found = 0;

handles.initialJ = 99;
handles.finalJ = 99;
handles.initial = 99;
handles.final = 99;



if exist([handles.diretorio handles.file], 'file') == 0
    % File does not exist.  Do stuff....
    set(handles.status,'String','ERROR');
    drawnow;
    uiwait(msgbox('Please Indicate the correct folder'));
    pathname = uigetdir();
    handles.diretorio = [pathname '\'];
end

if exist([handles.diretorio handles.file(1:end-4) 'Param.txt'], 'file') == 0
    data = get(handles.paramTable,'data');
    M = cell2mat(data(1:3,:));
else
    Param = NMESAbreParam([handles.file(1:end-4) 'Param.txt'],handles.diretorio);
    data = reshape(Param.ESParamValues,[3 3]);
    data = cat(2,data,(Param.PIDValue(1,:))');
    set(handles.paramTable,'data',data);
    found = 1;
    M = data;
    drawnow;
end

handles.M=M;

alpha = M(1:3,1);
gamma = M(1:3,2);
omega = M(1:3,3);
PID0 =  M(1:3,4);

set(handles.status,'String','Loading...');
drawnow;

if found == 0
    [J, theta, thetaP, bestResponse,user,ref,tempo,ind] = ...
        rotinaReconstrucaoJ(alpha,gamma,omega,1/2,PID0,handles.file,handles.diretorio);
else
    theta = Param.PIDValue;
    [J, ~, ~, bestResponse,user,ref,tempo,ind] = ...
        rotinaReconstrucaoJ(alpha,gamma,omega,1/2,PID0,handles.file,handles.diretorio);
    thetaP = theta;
    for k = 1:size(theta,1)
        thetaP(k,:) = [theta(k,1) theta(k,1)/theta(k,2) theta(k,1)*theta(k,3)];
    end
end

handles.theta = theta;
handles.thetaP = thetaP;
handles.bestResponse = bestResponse;
handles.user = user;
handles.ref = ref;
handles.tempo = tempo;
handles.ind = ind;
handles.J = J;

X = 0:1:length(J);

plot(handles.axes1,X,theta)
axes(handles.axes1);
grid on;
legend(handles.legendS);

plot(handles.axes3,X,thetaP)
axes(handles.axes3);
grid on;
legend(handles.legendP);

plot(handles.axes2,X(1:end-1),J)
axes(handles.axes2);
grid on;
legend('J(k)');

axes(handles.axes4);
plot(handles.axes4,bestResponse(:,1),bestResponse(:,2),'b'); hold on
plot(handles.axes4,bestResponse(:,1),bestResponse(:,3),'r-.');hold off

axis([0 20 0 70]);
grid on;
guidata(hObject, handles);
set(handles.status,'String','Done...');


% Hints: contents = cellstr(get(hObject,'String')) returns fileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fileList


% --- Executes during object creation, after setting all properties.
function fileList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Folder_Callback(hObject, eventdata, handles)
% hObject    handle to Folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

folder = uigetdir();
handles.diretorio = [folder '\'];

x = dir([handles.diretorio '*.txt']);
fileStrings = [];

for i=1:length(x)
    if isempty(strfind(x(i).name,'Param'))
        fileStrings{end+1}= x(i).name;
    end
end

handles.fileStringList = fileStrings;

set(handles.fileList,'string',fileStrings);

guidata(hObject, handles);


% --- Executes on button press in saveTimeResponse.
function saveTimeResponse_Callback(hObject, eventdata, handles)
% hObject    handle to saveTimeResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig = figure();

alpha = handles.M(1:3,1);
gamma = handles.M(1:3,2);
omega = handles.M(1:3,3);
PID0 =  handles.M(1:3,4);

[~,~,~,~,user,ref,control,tempo,ind] = rotinaReconstrucaoJ(alpha,...
    gamma,omega,1/2,PID0,handles.file,handles.diretorio);

if handles.initial == 99 && handles.final ==99
    plot(user,'b','LineWidth',3);hold on
    plot(ref,'r--','LineWidth',3);hold off
    
    [X,Y] = ginput(2);
    if X(1)<0;
        X(1)=1;
    end
    if X(2)>length(ref)
        X(2)=length(ref);
    end
    
    if(X(1) > 0)
        temp = ind(ind < X(1));
        initial = temp(end);
    end
    
    if(X(2) > 0)
        temp = ind(ind > X(2));
        final = temp(2);
    end
    
    initialJ = (find(~(ind-initial))+1)/2;
    finalJ = find(~(ind-final))/2;
    
    handles.initialJ = initialJ;
    handles.finalJ = finalJ;
    handles.final = final;
    handles.initial = initial;
end

timeResponseFig(tempo,user,ref,control,handles.initial,handles.final,handles.file,handles.diretorio)
guidata(hObject, handles);


% --- Executes on button press in saveIT.
function saveIT_Callback(hObject, eventdata, handles)
% hObject    handle to saveIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta = handles.theta;
thetaP = handles.thetaP;
J = handles.J;
bestResponse = handles.bestResponse;
tempo = handles.tempo;


arquivo = handles.file;
diretorio = handles.diretorio;

figure();
K = 0:1:length(J)-1;
plot(K,J,'k','LineWidth',1); hold on
xlim([0 length(J)])
notChosen = 1;

if handles.initialJ == 99 && handles.finalJ == 99;
    
    while(notChosen)
        [X,~] = ginput(2);
        if X(1)<0;
            X(1)=1;
        end
        if X(2)>length(J)
            X(2)=length(J);
        end
        
        initial = floor(X(1))+1;
        
        if initial == 0;
            initial = 1;
        end
        
        final = floor(X(2))+1;
        p1 = plot(K(initial:final),J(initial:final),'g','LineWidth',3);
        button = questdlg('Is This OK ?','Question');
        
        if strcmp(button,'Yes')==1
            notChosen = 0;
            handles.initialJ = initial;
            handles.finalJ = final;
        end
        
        if strcmp(button,'No') == 1
            delete(p1);
            uiwait(msgbox('Please Choose Again'));
        end
        
    end
    
else
    initial = handles.initialJ;
    final = handles.finalJ;
end
% 	hold off;
% 	figure;
%
% 	plot(K(initial:final),theta(initial:final,1)); hold on;
% 	plot(K(initial:final),theta(initial:final,2));
% 	plot(K(initial:final),theta(initial:final,3));
% 	xlim([0 final]);
%
% 	hold off;
guidata(hObject, handles);
saveIterations(theta(initial:final,:),thetaP(initial:final,:),J(initial:final),bestResponse,tempo,...
    arquivo,diretorio)


% --------------------------------------------------------------------
function closeFigures_Callback(hObject, eventdata, handles)
% hObject    handle to closeFigures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gui, 'HandleVisibility', 'off');
close all;
set(gui, 'HandleVisibility', 'on');
set(handles.fileList,'string',handles.fileStringList);
