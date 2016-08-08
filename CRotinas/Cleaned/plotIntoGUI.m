user = handles.timeData.timeResponse(:,1);
ref = handles.timeData.timeResponse(:,2);
time = (handles.timeData.timeResponse(:,4) - ...
    handles.timeData.timeResponse(1,4))/1000;

idx = find(ref>150);
ref(idx)= ref(idx-1);
idx = find(user>150);
user(idx)= user(idx-1);

plot(handles.timePlot,time,user,'b','LineWidth',2);hold on
plot(handles.controlPlot,time,ref,'r--','LineWidth',2);hold off
