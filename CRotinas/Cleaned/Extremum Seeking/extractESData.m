function [ handles ] = extractESData( handles )
%EXTRACTESDATA Summary of this function goes here
%   Detailed explanation goes here+

handles.J = handles.controlData.Values(handles.controlData.Values(:,4) > 0,4);
handles.theta = handles.controlData.PID;

    for k = 1:size(handles.theta,1)
        handles.thetaP(k,:) = ...
            [handles.theta(k,1) ...
            handles.theta(k,1)/handles.theta(k,2)...
            handles.theta(k,1)*handles.theta(k,3)];
    end
    


ind = handles.timeData.timeResponse(:,2) > 0;

ind = find(abs(diff(ind))>0);

[~, minIndex] = min(handles.J);

i = find(handles.timeData.timeResponse(1,:) > 1000);
handles.timeBestResponse = ...
    (handles.timeData.timeResponse(ind(minIndex*2-1):ind(minIndex*2),i) - ...
     handles.timeData.timeResponse(ind(minIndex*2-1),i))/1000;
    

handles.bestResponse(:,1) = ...
		handles.timeData.timeResponse(ind(minIndex*2-1):ind(minIndex*2),1);

handles.bestResponse(:,2) = ...
		handles.timeData.timeResponse(ind(minIndex*2-1):ind(minIndex*2),2);
  
    
    

end

