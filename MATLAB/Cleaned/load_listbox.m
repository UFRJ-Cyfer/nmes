function handles = load_listbox(path,handles)
% 
if strcmp(strtrim(path),'.') || strcmp(strtrim(path),'.\')
    cd(strtrim(path))
    handles.diretorio = [strtrim(pwd) '\'];
    
else if strcmp(strtrim(path),'..')
        dir_separator = strfind(handles.diretorio,'\');
        if isempty(dir_separator)
            dir_separator = strfind(handles.diretorio,'/');
        end
    handles.diretorio = handles.diretorio(1:dir_separator(end-1));
    else
    handles.diretorio = [handles.diretorio strtrim(path) '\'];
    end
end    
temp = dir(handles.diretorio);


% clean_path = strtrim(path);
% temp = dir(strtrim(path));
% handles.diretorio = strtrim(path);

[sorted_names,sorted_index] = sortrows({temp.name}');
handles.sorted_index = sorted_index;
handles.is_dir = [temp.isdir];

handles.sorted_Names = sorted_names;
directory_strings = sorted_names(handles.is_dir);
handles.is_dir = ones(1,length(directory_strings));

% textFiles inside directory
if strcmp(handles.diretorio,[handles.diretorio(1:end-7) 'Antigo\']) == 1
    textFiles = dir([handles.diretorio '*.txt']);
else
    textFiles = dir([handles.diretorio '*Results.txt']);
end

fileStrings = char(directory_strings);
for i=1:length(textFiles)
    fileStrings = char(fileStrings,textFiles(i).name);
end

guidata(handles.figure1,handles)

set(handles.fileList,'String',fileStrings,...
    'Value',1);

end
