%==========================================================================
%                               Rhett Huston
%
%                      FILE CREATION DATE: 09/15/2021
%
%                           PCD MEGA MAP CREATOR
%
%This is a chonker of a program that will bring your pc to it's knees,
%begging for mercy. This takes the gps, imu, and lidar data to create a
%giant pcd map. At least it's not doing ndt matching lol.
%==========================================================================

function sensor_van_rosbag_pcd_creator(bag_init, bag_file, RPM, device_model, num_channels, pcd_export_file_path)
    
    disp('Building Map')
    
    %% Grab gps data
    gps_return = sensor_van_rosbag_gps(bag_init, bag_file, 0, 0);
    
    %% Convert to meters - Needed?
%     gps_meter_return = sensor_van_rosbag_gps_meter_return(gps_return);
    
    %% Grab imu data
    gps_imu_quat = sensor_van_rosbag_gps_imu(bag_init, bag_file, 0);
    
    %% Initilizing the Velodyne Topic
    velodyne_packets_topic	= '/velodyne_packets';
%     velodyne_points_topic	= '/velodyne_points';
    
    % Selecting the bag
    velodyne_packets_bag    = select(bag_init, 'Topic', velodyne_packets_topic);
%     velodyne_points_bag     = select(bag_init, 'Topic', velodyne_points_topic);
    
    % Creating Structure
    velodyne_packets_struct = readMessages(velodyne_packets_bag,'DataFormat','struct');
%     velodyne_points_struct  = readMessages(velodyne_points_bag,'DataFormat','struct');
            
    % Warning for length of process
    if length(velodyne_packets_struct) > 10
        
        fprintf("\n WARNING: %i point clouds will be created (takes time)\n", length(velodyne_packets_struct))
        
    end
    
    %% Velodyne Revolution Timing
    % Converting the RPM into Hz then finding dT for each revolution. This
    % will hopefully make a point cloud with one full revolution.
    dT                      = 1 / (RPM / 60);
    
    %% Allocating memory for the matrices: Needs length of each sweep.
    
    % Reading the velodyne stuffs
    veloReader_packets      = velodyneROSMessageReader(velodyne_packets_struct,device_model);
    
    % Extracting Point Clouds
    timeDuration_packets    = veloReader_packets.StartTime;
                   
    % Read first point cloud recorded
    ptCloudObj_packets      = readFrame(veloReader_packets, timeDuration_packets);
            
    % Access Location Data
    ptCloudLoc_packets      = ptCloudObj_packets.Location;
    
    % Checking Length
    memory_array_xyzi       = double(zeros(1, length(ptCloudLoc_packets(:,:,1)) * num_channels));
    memory_array_pt_pack    = double(zeros(32, length(ptCloudLoc_packets(:,:,1)) * num_channels));
    memory_array_XYZI_TOT   = double(zeros(length(velodyne_packets_struct),4));
    
    % Allocation
    x_append                = memory_array_xyzi;
    y_append                = memory_array_xyzi;
    z_append                = memory_array_xyzi;
    int_append              = memory_array_xyzi;
    ptCloudLoc_packets      = memory_array_pt_pack;
    XYZI_TOT                = memory_array_XYZI_TOT;
    
    %% Extracting xyzi data & compiling into single array
    
    for i = 1:5 %length(velodyne_packets_struct)
        
            
%         veloReader_packets      = velodyneROSMessageReader(velodyne_packets_struct,device_model);
        % Timing
        tic
            
        dT_loop                 = dT * i;
            
        % Extracting Point Clouds
%       timeDuration_points      = veloReader_points.StartTime + seconds(dT);
        timeDuration_packets    = veloReader_packets.StartTime + seconds(dT_loop);
                   
        % Read first point cloud recorded
%       ptCloudObj_points        = readFrame(veloReader_points, timeDuration_packets);
        ptCloudObj_packets      = readFrame(veloReader_packets, timeDuration_packets);
            
        % Access Location Data
    %     ptCloudLoc_points        = ptCloudObj_points.Location;
        ptCloudLoc_packets      = ptCloudObj_packets.Location;
        
        % Access Intensity Data
        ptCloudInt_packets      = ptCloudObj_packets.Intensity;
        
        % Extracting data
        for j = 1:32
            
            %Get the Bias
%             bias_x                  = 0;
%             bias_y                  = 0;
%             bias_z                  = 0;
            
            x                       = ptCloudLoc_packets(j,:,1);% + bias_x;
            y                       = ptCloudLoc_packets(j,:,2);% + bias_y;
            z                       = ptCloudLoc_packets(j,:,3);% + bias_z;
            int                     = ptCloudInt_packets(j,:);
            
            x_append                = [x_append x];
            y_append                = [y_append y];
            z_append                = [z_append z];
            int_append              = [int_append int];
            
        end % Extracting data
        
        XYZI_TOT                = [x_append' y_append' z_append' double(int_append')];
        
        fprintf("\n %i / %i \n", i, 5)
        
    end % Extracting the files
    
    %% Eliminating the 0's and NaNs

    xyzi_trim                   = nan_zero_trimmer(XYZI_TOT);
    
    %% Preparing for exporting to PCD
    
    xyz_export                  = [xyzi_trim(:,1) xyzi_trim(:,2) xyzi_trim(:,3)];
    i_export                    = [xyzi_trim(:,4)];
    
    %% Creating the PCD
    
    ptCloud                     = pointCloud(xyz_export,'Intensity',i_export);
    pcshow(ptCloud)
    
end



