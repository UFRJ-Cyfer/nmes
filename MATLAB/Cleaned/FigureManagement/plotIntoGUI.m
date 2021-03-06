function plotIntoGUI(handles)
guidata(handles.figure1,handles)

user = handles.timeData.timeResponse(:,1);
ref = handles.timeData.timeResponse(:,2);

i = find(handles.timeData.timeResponse(1,:) > 10000);
time = (handles.timeData.timeResponse(:,i) - ...
    handles.timeData.timeResponse(1,i))/1000;

idx = find(ref>150);
ref(idx)= ref(idx-1);
idx = find(user>150);
user(idx)= user(idx-1);


axes(handles.timePlot);
plot(time,user,'b','LineWidth',2);
hold on;
plot(time,ref,'r--','LineWidth',2);
axis([0,inf,-5,70]);
legend('Arm Angle', 'Reference');
ylabel('Angle (Degrees)');
grid on;
hold off;

biceps = handles.timeData.timeResponse(:,5);
triceps = handles.timeData.timeResponse(:,6);

axes(handles.controlPlot);
plot(time,biceps,'b','LineWidth',2);
hold on
plot(time,triceps,'g','LineWidth',2);
minimum = min(min(biceps(biceps>0)), min(triceps(triceps>0)));
maximum = max(max(biceps),max(triceps));
if ~isempty(minimum)
    axis([0,inf,minimum,maximum]);
end
legend('Biceps','Triceps');
xlabel('Time (s)');
ylabel('Current(mA)');
grid on;
hold off;

end