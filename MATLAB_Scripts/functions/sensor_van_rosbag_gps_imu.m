%==========================================================================
%                               Rhett Huston
%
%                      FILE CREATION DATE: 09/15/2021
%
%                        ROSBAG HANDLER: GPS IMU
%
%This is a quick set of programs that will extract gps positional 
%information from a rosbag generated by the van The primary purpose of 
%this is to begin work on creating a road surface detection algorithm for 
%use in my thesis.
%==========================================================================

function gps_imu_quat = sensor_van_rosbag_gps_imu(bag_init, bag_file,imu_cvs_export_bool)

    disp('Entered the sensor_van_rosbag_gps_imu.m script')

    %% INITIATION
    
    %Timing
    tic

    % Topics
    gps_imu_topic	= '/gps/imu';

    % Selecting the bag
    gps_imu_bag         = select(bag_init, 'Topic', gps_imu_topic);

    % Creating Structure
    gps_imu_struct      = readMessages(gps_imu_bag,'DataFormat','struct');
        
    %Timing 
    toc
    
    disp('GPS IMU Struct Initilization Complete')
    
    tic
    
    %% GPS IMU GRAB
    
    % Initilizing
    init_length         = zeros(1,length(gps_imu_struct));
    
    gps_imu_w           = init_length;
    gps_imu_x           = init_length;
    gps_imu_y           = init_length;
    gps_imu_z           = init_length;
%     gps_imu_time        = init_length;

    for i = 1:length(gps_imu_struct)
        
        % Orientation
        gps_imu_w(i)        = gps_imu_struct{i}.Orientation.W;
        gps_imu_x(i)        = gps_imu_struct{i}.Orientation.X;
        gps_imu_y(i)        = gps_imu_struct{i}.Orientation.Y;
        gps_imu_z(i)        = gps_imu_struct{i}.Orientation.Z;
        
        % Time
%         gps_imu_time(i)     = gps_imu_struct{i}.Header.Stamp.Sec + gps_imu_struct{i}.Header.Stamp.Nsec * 10E-9;
                
    end

    % Creating the Quaternion Matrix for export
    gps_imu_quat        = [gps_imu_w' gps_imu_x' gps_imu_y' gps_imu_z'];

     %% CVS EXPORT
    if imu_cvs_export_bool == 1

        imu_file_name       = append('gps_imu_topic_', bag_file);
        imu_file_type       = '.csv';

        gps_full_out_name   = append(imu_file_name, imu_file_type);
        
        %GPS Export
        GPS_IMU_OUT             = [gps_imu_w' gps_imu_x' gps_imu_y' gps_imu_z'];
        writematrix(GPS_IMU_OUT,gps_full_out_name)
        
    end % CVS Export
    
    
    %Timing
    toc
    disp('END OF GPS IMU- YAY')
    
end
