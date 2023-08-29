function sensor_van_ouster_export(bag_init, bag_file)
    
    %% VAR INIT
    
    % Topics 
    
    ouster_imu_topic                = '/ouster/imu';
    ouster_imu_packets_topic        = '/ouster/imu_packets';
    ouster_lidar_packets_topic      = '/ouster/lidar_packets';
    ouster_metadata_topic           = '/ouster/metadata';
    ouster_nearir_image_topic       = '/ouster/nearir_image';
    ouster_os_nodelet_mgr_topic     = '/ouster/os_nodelet_mgr';
    ouster_points_topic             = '/ouster/points';
    ouster_range_image_topic        = '/ouster/range_image';
    ouster_reflec_image_topic       = '/ouster/reflec_image';
    ouster_signal_image_topic       = '/ouster/signal_image';
    
    % Video Save Names
    ouster_nearir_image_filename       = string(bag_file(1:end-4)) + "_nearir.mp4";
    ouster_range_image_filename        = string(bag_file(1:end-4)) + "_range.mp4";
    ouster_reflec_image_filename       = string(bag_file(1:end-4)) + "_reflec.mp4";
    ouster_signal_image_filename       = string(bag_file(1:end-4)) + "_signal.mp4";
    
    %% Into Select Topic
    
    disp('Topics defined, initilizing bag topics...')
    
%     ouster_imu_bag                = select(bag_init, 'Topic', ouster_imu_topic);
%     ouster_imu_packets_bag        = select(bag_init, 'Topic', ouster_imu_packets_topic);
%     ouster_lidar_packets_bag      = select(bag_init, 'Topic', ouster_lidar_packets_topic);
%     ouster_metadata_bag           = select(bag_init, 'Topic', ouster_metadata_topic);
%     ouster_os_nodelet_mgr_bag     = select(bag_init, 'Topic', ouster_os_nodelet_mgr_topic);
%     ouster_points_bag             = select(bag_init, 'Topic', ouster_points_topic);

    % Image Topics
    ouster_nearir_image_bag       = select(bag_init, 'Topic', ouster_nearir_image_topic);
    ouster_range_image_bag        = select(bag_init, 'Topic', ouster_range_image_topic);
    ouster_reflec_image_bag       = select(bag_init, 'Topic', ouster_reflec_image_topic);
    ouster_signal_image_bag       = select(bag_init, 'Topic', ouster_signal_image_topic);
    

    %% Convert into Struct
    
    disp('Bag topics initilized, Getting Structures...')
    
%     ouster_imu_struct                = readMessages(ouster_imu_bag, 'DataFormat', 'struct');
%     ouster_imu_packets_struct        = readMessages(ouster_imu_packets_bag, 'DataFormat', 'struct');
%     ouster_lidar_packets_struct      = readMessages(ouster_lidar_packets_bag, 'DataFormat', 'struct');
%     ouster_metadata_struct           = readMessages(ouster_metadata_bag, 'DataFormat', 'struct');
%     ouster_os_nodelet_mgr_struct     = readMessages(ouster_os_nodelet_mgr_bag, 'DataFormat', 'struct');
%     ouster_points_struct             = readMessages(ouster_points_bag, 'DataFormat', 'struct');

    % Image Structs
    ouster_nearir_image_struct       = readMessages(ouster_nearir_image_bag, 'DataFormat', 'struct');
    ouster_range_image_struct        = readMessages(ouster_range_image_bag, 'DataFormat', 'struct');
    ouster_reflec_image_struct       = readMessages(ouster_reflec_image_bag, 'DataFormat', 'struct');
    ouster_signal_image_struct       = readMessages(ouster_signal_image_bag, 'DataFormat', 'struct'); 

    disp('Structures initilized!')


    %% Video Out
    
    disp('Exporting video')
    
    ouster_video_out(ouster_nearir_image_filename, ouster_nearir_image_struct);
    ouster_video_out(ouster_range_image_filename, ouster_range_image_struct);
    ouster_video_out(ouster_reflec_image_filename, ouster_reflec_image_struct);
    ouster_video_out(ouster_signal_image_filename, ouster_signal_image_struct);
    

    %% PCD Out
    
    
    
    
end