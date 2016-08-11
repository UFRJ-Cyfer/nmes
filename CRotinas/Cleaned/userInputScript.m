
user = handles.timeData.timeResponse(:,1);
ref = handles.timeData.timeResponse(:,2);
time = (handles.timeData.timeResponse(:,3) - ...
        handles.timeData.timeResponse(1,3))/1000;

idx = find(ref>150);
ref(idx)= ref(idx-1);
idx = find(user>150);
user(idx)= user(idx-1);

ind = ref > 0;
ind = find(abs(diff(ind))>0);

if handles.initial == 99 && handles.final ==99
    plot(user,'b','LineWidth',2);hold on
    plot(ref,'r--','LineWidth',2);hold off
    
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
end