function load_listbox(path,handles)
% 
cd(char(strtrim(path)))
temp = dir(pwd);
handles.diretorio = pwd;
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
textFiles = dir([pwd  '\' '*Results.txt']);
fileStrings = char(directory_strings);
for i=1:length(textFiles)
    fileStrings = char(fileStrings,textFiles(i).name);
end

guidata(handles.figure1,handles)
set(handles.fileList,'String',fileStrings,...
    'Value',1);
end