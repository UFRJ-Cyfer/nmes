function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 09-Aug-2016 18:59:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

handles.initial = 99;
handles.final = 99;


% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load_listbox('./',handles);




% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in fileList.
function fileList_Callback(hObject, eventdata, handles)
% hObject    handle to fileList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fileList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fileList
    guidata(hObject, handles); 

    get(handles.figure1,'SelectionType');

    Param=0;Results=0;Old=0;
    
    if strcmp(get(handles.figure1,'SelectionType'),'open')
    
        str = get(handles.fileList, 'String');
        val = get(handles.fileList,'Value');
        
        filename = str(val,:);

        if val <= length(handles.is_dir)    %if is directory
           load_listbox(filename,handles)
        else

            handles.file = strtrim(filename);
            handles.diretorio = [strtrim(pwd) '\'];

            if strcmp(handles.diretorio,[handles.diretorio(1:end-7) 'Antigo\'])
                Old = 1;
            end
            if Old == 0
                if exist([handles.diretorio handles.file], 'file') == 0
                    % File does not exist.  Do stuff....
                    set(handles.status,'String','ERROR');
                    drawnow;
                    errordlg('Could not find Data file.');
            %         uiwait(msgbox('Please Indicate the correct folder'));
            %         pathname = uigetdir();
            %         handles.diretorio = [pathname '\'];
                    Result = 0;

                else
                    Result=1;
                end

                if exist([handles.diretorio handles.file(1:end-4-7) 'Param.txt'],...
                        'file') == 0
                    set(handles.status,'String','ERROR');
                    drawnow;
                    errordlg('Could not find Parameters file.');
            %         uiwait(msgbox('Please Indicate the correct folder'));
            %         pathname = uigetdir();
            %         handles.diretorio = [pathname '\'];
                    Param=0;
                else
                    Param =1;
                end

                if Param && Result
                    [timeData, controlData] = openFileMain...
                                        (handles.diretorio,handles.file);
                     handles.timeData = timeData;
                     handles.controlData = controlData;
                end
            end

            if Old
               timeData = openOldFiles(handles.diretorio,handles.file); 
               handles.timeData = timeData;
            end
            plotIntoGUI(handles);

        end
    end
    


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


% --- Executes on button press in esCaller.
function esCaller_Callback(hObject, eventdata, handles)
% hObject    handle to esCaller (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui;

% --------------------------------------------------------------------
function folderMenu_Callback(hObject, eventdata, handles)
% hObject    handle to folderMenu (see GCBO)
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


% --- Executes on button press in saveTimeFigure.
function saveTimeFigure_Callback(hObject, eventdata, handles)
% hObject    handle to saveTimeFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
userInputScript;
