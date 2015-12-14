addpath('quaternion_library');
close all; clear all; clc;

%USB connection
PC_IP = '192.168.8.1';
BEAGLEBONE_IP = 'http://192.168.8.2';

%WIFI connection
%PC_IP = '172.20.10.2';
%BEAGLEBONE_IP = 'http://172.20.10.3';

%Initialize ROS on remote master
setenv('ROS_MASTER_URI', strcat(BEAGLEBONE_IP, ':11311'))
setenv('ROS_IP', PC_IP)
rosinit

%%

%Subscribe to IMU data
imu_sub = rossubscriber('imu_readings', rostype.sensor_msgs_Imu);
mag_sub = rossubscriber('mag_readings', rostype.sensor_msgs_MagneticField);

%Initialize variables
cnt = 0; T = [];
accX = []; accY = []; accZ = [];
gyroX = []; gyroY = []; gyroZ = [];
magX = []; magY = []; magZ = [];
euler = [];

acc = zeros(3,1);
gyro = zeros(3,1);
mag = zeros(3,1);

%Stops the bike when any key is pressed
global stop_bike
stop_bike = 0;
gcf;
set(gcf, 'KeyPressFcn', @myKeyPressFcn);

%Define control loop period
loop_p = 0.100;
t_run = 0;
t = 0;
deltat = 0;
computation_time = 0;

t_imu=0;


while ~stop_bike
    tic;
    drawnow
    
    %Receive imu data
    imu_reading = receive(imu_sub);
    %mag_reading = receive(mag_sub);
    

    
    t_imu = [t_imu t];
    
    %Get time elapsed in current loop
    loop_t = toc;
    computation_time = [computation_time loop_t];
    if loop_t > loop_p
        fprintf('%.4f(s) instead of %1.4f(s)\n', loop_t, loop_p);
    end
    
    %Wait until total loop time is elapsed
    while toc < loop_p
        %
    end
    
    deltat = [deltat toc];
    t_run = t_run + toc;
    t = [t t_run];
    
end

        
    %     acctemp = [imu_reading.LinearAcceleration.X;
%                imu_reading.LinearAcceleration.Y;
%                imu_reading.LinearAcceleration.Z];
%     
%     gyrotemp= [imu_reading.AngularVelocity.X;
%                imu_reading.AngularVelocity.Y;
%                imu_reading.AngularVelocity.Z];
%            
%     magtemp= [mag_reading.MagneticField_.X;
%               mag_reading.MagneticField_.Y;
%               mag_reading.MagneticField_.Z];
%     
%     acc = [acc acctemp];
%     gyro = [gyro gyrotemp];
%     mag = [mag magtemp];
    
    %accX = [accX imu_reading.LinearAcceleration.X];
    %accY = [accY imu_reading.LinearAcceleration.Y];
    %accZ = [accZ imu_reading.LinearAcceleration.Z];
    %acc = [imu_reading.LinearAcceleration.X imu_reading.LinearAcceleration.Y imu_reading.LinearAcceleration.Z];
    
    %gyroX = [gyroX imu_reading.AngularVelocity.X];
    %gyroY = [gyroY imu_reading.AngularVelocity.Y];
    %gyroZ = [gyroZ imu_reading.AngularVelocity.Z];
    %gyro = [imu_reading.AngularVelocity.X imu_reading.AngularVelocity.Y imu_reading.AngularVelocity.Z];
    
    %magX = [magX mag_reading.MagneticField_.X];
    %magY = [magY mag_reading.MagneticField_.Y];
    %magZ = [magZ mag_reading.MagneticField_.Z];
    %mag = [mag_reading.MagneticField_.X mag_reading.MagneticField_.Y mag_reading.MagneticField_.Z];
    

