acc = zeros(3,1);
gyro = zeros(3,1);
mag = zeros(3,1);


acc = zeros(3,1);
gyro = zeros(3,1);
mag = zeros(3,1);

%Define control loop period
loop_period = 0.100;
t_run = 0;
t = 0;
dt = 0;
computation_time = 0;

t_imu=0;


while 1
    tic;
    
    acctemp = [1;2;3];
    gyrotemp = [4;5;6];
    magtemp = [7;8;9];
    
    acc = [acc acctemp];
    gyro = [gyro gyrotemp];
    mag = [mag magtemp];
    
    t_imu = [t_imu t];
    
    loop_t = toc;
    computation_time = [computation_time loop_t];
    if loop_t > loop_period
        fprintf('/!\\ Warning : Realtime issue \n\t Last loop period : %.4f(s) instead of %1.4f(s)\n', loop_t, loop_period);
    end
    
    while toc < loop_period
        %
    end
    
    dt = [dt toc];
    t_run = t_run + toc;
    t = [t t_run];
    
end
