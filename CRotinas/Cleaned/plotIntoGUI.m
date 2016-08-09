user = handles.timeData.timeResponse(:,1);
ref = handles.timeData.timeResponse(:,2);

time = (handles.timeData.timeResponse(:,3) - ...
    handles.timeData.timeResponse(1,3))/1000;

idx = find(ref>150);
ref(idx)= ref(idx-1);
idx = find(user>150);
user(idx)= user(idx-1);

plot(handles.timePlot,time,user,'b','LineWidth',2);hold on
plot(handles.timePlot,time,ref,'r--','LineWidth',2);hold off

biceps = handles.timeData.timeResponse(:,5);
triceps = handles.timeData.timeResponse(:,6);

plot(handles.controlPlot,time,biceps,'b','LineWidth',2);hold on
plot(handles.controlPlot,time,triceps,'r--','LineWidth',2);hold off
