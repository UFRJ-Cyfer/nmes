
user = handles.timeData.timeResponse(:,1);
ref = handles.timeData.timeResponse(:,2);
time = (handles.timeData.timeResponse(:,4) - ...
        handles.timeData.timeResponse(1,4))/1000;

idx = find(abs(ref)>150);
ref(idx)= ref(idx-1);
idx = find(abs(user)>150);
user(idx)= user(idx-1);

ind = ref > 0;
ind = find(abs(diff(ind))>0);

if handles.initial == 99 && handles.final ==99
    plot(user,'b','LineWidth',2);hold on
    plot(ref,'r--','LineWidth',2);hold off
    
    if handles.timeData.pulseParam(6) == 1   
        [X,Y] = ginput(2);
        if X(1)<1;
            X(1)=1;
        end
        if X(2)>length(ref)
            X(2)=length(ref);
        end
        
    if(ref(floor(X(1))) > min(ref))
        temp = ind(ind < X(1));
        initial = temp(end);
    end
    
    if(ref(floor(X(2))) > min(ref))
        temp = ind(ind > X(2));
        if length(temp) >=2
            final = temp(2);
        else
            final = length(ref);
        end
        
    end
    
    initialJ = (find(~(ind-initial))+1)/2;
    finalJ = find(~(ind-final))/2;
    
    handles.initialJ = initialJ;
    handles.finalJ = finalJ;
    handles.final = final;
    handles.initial = initial;
    
    else
        handles.initial = 1;
        handles.final = length(handles.timeData.timeResponse(:,1));   
    end
    
    
end