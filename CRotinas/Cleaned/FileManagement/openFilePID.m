function [ controlData ] = openFilePID( pathname,filename )
%OPENFILEPID Summary of this function goes here
%   Detailed explanation goes here

temp = importdata([pathname,filename], '\t', 2);

controlData.ParamValues = temp.data;
controlData.ParamNames = temp.colheaders;

temp = importdata([pathname,filename], '\t', 4);

controlData.Values = temp.data;
controlData.Names = temp.colheaders;

controlData.Path=pathname;
controlData.File=filename;
end

