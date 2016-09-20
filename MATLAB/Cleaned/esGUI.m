function varargout = esGUI(varargin)
% ESGUI MATLAB code for esGUI.fig
%      ESGUI, by itself, creates a new ESGUI or raises the existing
%      singleton*.
%
%      H = ESGUI returns the handle to a new ESGUI or the handle to
%      the existing singleton*.
%
%      ESGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESGUI.M with the given input arguments.
%
%      ESGUI('Property','Value',...) creates a new ESGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before esGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to esGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help esGUI

% Last Modified by GUIDE v2.5 31-Aug-2016 16:48:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @esGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @esGUI_OutputFcn, ...
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


% --- Executes just before esGUI is made visible.
function esGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to esGUI (see VARARGIN)

% Choose default command line output for esGUI
handles.legendS = {'K','Ti','Td'};
handles.legendP = {'K','Ki','Kd'};
handles.initial = 99;
handles.final = 99;
handles.initialJ = 99;
handles.finalJ = 99;

handles.output = hObject;

if nargin < 4
    handles = load_listbox('.',handles);
else
    handles = load_listbox(varargin{1}.diretorio,handles);
    if isfield(varargin{1},'file')
      handles.file = file;
      plotintoGUI_ES(handles);
    end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes esGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = esGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in saveTimeFigure.
function saveTimeFigure_Callback(hObject, eventdata, handles)
% hObject    handle to saveTimeFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveIterations.
function saveIterations_Callback(hObject, eventdata, handles)
% hObject    handle to saveIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in fileList.
function fileList_Callback(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fileList
    get(handles.figure1,'SelectionType');
    
    if strcmp(get(handles.figure1,'SelectionType'),'open')
    
        str = get(handles.fileList, 'String');
        val = get(handles.fileList,'Value');
        
        filename = str(val,:);

        if val <= length(handles.is_dir)    %if is directory
           handles = load_listbox(filename,handles);
        else

            handles.file = strtrim(filename);
            
            [timeData, controlData] = openFileMain(handles.diretorio, ...
                                                   handles.file);
            handles.timeData = timeData;
            handles.controlData = controlData;
            
            handles = plotIntoGUI_ES(handles);
        end
    end
    guidata(hObject, handles); 


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
