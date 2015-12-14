addpath('quaternion_library');
close all; clear all; clc;

PC_IP = '192.168.8.1';
BEAGLEBONE_IP = 'http://192.168.8.2';
PLOT_INTERVAL = 500;

% Initialise ROS on remote master
setenv('ROS_MASTER_URI', strcat(BEAGLEBONE_IP, ':11311'))
setenv('ROS_IP', PC_IP)
rosinit

%%
imu_sub = rossubscriber('imu_readings', rostype.sensor_msgs_Imu);
mag_sub = rossubscriber('mag_readings', rostype.sensor_msgs_MagneticField);

fig = figure; hold on;
cnt = 0; T = [];
accX = []; accY = []; accZ = [];
gyroX = []; gyroY = []; gyroZ = [];
magX = []; magY = []; magZ = [];

euler = [];


AHRS = MadgwickAHRS('SamplePeriod', 1/10, 'Beta', 0.1);
quaternion = zeros(1,4);

while 1
    imu_reading = receive(imu_sub);
    mag_reading = receive(mag_sub);
    time = rostime('now');

    cnt = cnt + 1;
    T = [T cnt];
    
    accX = [accX imu_reading.LinearAcceleration.X];
    accY = [accY imu_reading.LinearAcceleration.Y];
    accZ = [accZ imu_reading.LinearAcceleration.Z];
    acc = [imu_reading.LinearAcceleration.X imu_reading.LinearAcceleration.Y imu_reading.LinearAcceleration.Z];
    
    gyroX = [gyroX imu_reading.AngularVelocity.X];
    gyroY = [gyroY imu_reading.AngularVelocity.Y];
    gyroZ = [gyroZ imu_reading.AngularVelocity.Z];
    gyro = [imu_reading.AngularVelocity.X imu_reading.AngularVelocity.Y imu_reading.AngularVelocity.Z];
    
    magX = [magX mag_reading.MagneticField_.X];
    magY = [magY mag_reading.MagneticField_.Y];
    magZ = [magZ mag_reading.MagneticField_.Z];
    mag = [mag_reading.MagneticField_.X mag_reading.MagneticField_.Y mag_reading.MagneticField_.Z];

    AHRS.Update(gyro, acc/9.81, mag/100);
    quaternion = AHRS.Quaternion;
    eulertemp = quatern2euler(quaternConj(quaternion)) * (180/pi);
    
    euler = [euler eulertemp'];
    figure(fig);
    
    subplot(1,3,1)
    plot_topic(T, euler(1,:), 'X acceleration', 100);
    
    subplot(1,3,2)
    plot_topic(T, euler(2,:), 'Y acceleration', 100);
    
    subplot(1,3,3)
    plot_topic(T, euler(3,:), 'Z acceleration', 100);
end