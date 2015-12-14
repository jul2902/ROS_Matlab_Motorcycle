close all; clear all; clc;

global stop_bike
stop_bike = 0;
gcf;
set(gcf, 'KeyPressFcn', @myKeyPressFcn);

while ~stop_bike
    
    drawnow
    
    fprintf('TEST');
    
end
