PC_IP = '192.168.8.1';
BEAGLEBONE_IP = 'http://192.168.8.2';

% Initialise ROS on remote master
setenv('ROS_MASTER_URI', strcat(BEAGLEBONE_IP, ':11311'))
setenv('ROS_IP', PC_IP)
rosinit

%%

engine_pub = rospublisher('/car/actuator_engine_update',rostype.std_msgs_Float64)
engine_msg = rosmessage(engine_pub);

steering_pub = rospublisher('/car/actuator_steering_update',rostype.std_msgs_Float64)
steering_msg = rosmessage(steering_pub);

while 1
    for k=[0,10]
        engine_msg.Data = k * 1 - 5; %-5 when k=0, 5 when k=10
        steering_msg.Data = k / 5 - 1;%-1 when k=0, 1 when k=10

        send(engine_pub, engine_msg)
        send(steering_pub, steering_msg)
        k
        pause(1)
    end
end

rosshutdown