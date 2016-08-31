function [ controlData ] = openFileES( pathname, filename )
%OPENFILEES Summary of this function goes here
%   Detailed explanation goes here
temp = importdata([pathname,filename], '\t', 2);

controlData.ParamValues = temp.data;
if sum(strcmp(fieldnames(temp), 'colheaders')) == 1
controlData.ParamNames =temp.colheaders;
end
temp = importdata([pathname,filename], '\t', 4);

controlData.Values = temp.data;
if sum(strcmp(fieldnames(temp), 'colheaders')) == 1
controlData.Names = temp.colheaders;
end
controlData.PIDValue = unique(controlData.Values(:,5:end),'rows','stable');

controlData.Path=pathname;
controlData.File=filename;

end

