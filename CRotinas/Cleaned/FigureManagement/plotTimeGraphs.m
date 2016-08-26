function [ time, Data ] = plotTimeGraphs( timeData, output_mode )
%PLOT Summary of this function goes here
%   Detailed explanation goes here
FONTSIZE = 18;
time = (timeData.timeResponse(:,4) - timeData.timeResponse(1,4))/1000;

% dtSum = cumsum(timeData.timeResponse(:,4));       %
% time = (dtSum- dtSum(1))/1000;                    %alternative way
%                                                   %

Data(:,1) = timeData.timeResponse(:,1);          %   Arm Angle
Data(:,2) = timeData.timeResponse(:,2);          %   Reference
Data(:,3) = timeData.timeResponse(:,5);          %   AmpCH1
Data(:,4) = timeData.timeResponse(:,6);          %   AmpCH2

if output_mode == 1
    figure;
    subplot(3,1,[1 2]);
    hold on
    axArmAngle = plot(time,Data(:,1),'b-');
    axReference = plot(time,Data(:,2),'r--');
    ylabel('Angle (º)')
    set(gca, 'FontSize', FONTSIZE)
    axis([0, inf, -inf, 70])
    hold off;
    
    subplot(3,1,3);
    hold on
    biceps = Data(:,3);
    triceps = Data(:,4);
    minB = min(biceps(biceps>0));
    minT = min(triceps(triceps>0));
    
    min1 = min(minB,minT);
    axBicepsOutput = plot(time,Data(:,3),'r');
    axTricepsOutput = plot(time,Data(:,4),'g');
    xlabel('Time (s)')
    ylabel('Current (mA)')
    set(gca, 'FontSize', FONTSIZE)
    axis([0, inf, min1,inf])
    hold off
    
    configAxes(axArmAngle, axReference, axBicepsOutput, axTricepsOutput)
end



end

