function [] = configAxes(axArmAngle, axReference,...
                                      axBicepsOutput, axTricepsOutput)
%CONFIGAXES Summary of this function goes here
%   Detailed explanation goes here
LINEWIDTH = 2;

set(axArmAngle, 'Color','blue');
set(axReference, 'Color','red');

set(axArmAngle, 'LineStyle','-');
set(axReference, 'LineStyle','--');

set(axArmAngle, 'LineWidth',LINEWIDTH);
set(axReference, 'LineWidth',LINEWIDTH);

legend([axArmAngle axReference],'Arm Angle y(t)','Reference Angle r(t)');
time_L = legend([axArmAngle axReference],'Location',...
	'northoutside','Orientation','horizontal');
time_L.Box = 'off';

legend([axBicepsOutput axTricepsOutput],'Biceps','Triceps');
control_L = legend([axBicepsOutput axTricepsOutput],'Location',...
	'northoutside','Orientation','horizontal');
control_L.Box = 'off';

end

