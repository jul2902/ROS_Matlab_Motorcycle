close all; clear all; clc;

PC_IP = '192.168.8.1';
BEAGLEBONE_IP = 'http://192.168.8.2';

%Initialise ROS on remote master
setenv('ROS_MASTER_URI', strcat(BEAGLEBONE_IP, ':11311'))
setenv('ROS_IP', PC_IP)
rosinit
%%

sub = rossubscriber('remote_readings', rostype.std_msgs_Float64MultiArray);
%fig = figure;
%hold on;
cnt = 0;
T = [];
X = [];
Y = [];

while 1
    remote_reading = receive(sub);
    remote_reading.Data
    
    cnt = cnt+1;
    T = [T cnt];
    X = [X remote_reading.Data(1)];
    Y = [Y remote_reading.Data(2)];
    
    %figure(fig);
    %plot_topic(T, X, 'Throttle input',100);
end
