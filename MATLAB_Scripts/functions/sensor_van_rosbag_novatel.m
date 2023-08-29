function novatel_return = sensor_van_rosbag_novatel(bag_init, bag_file, novatel_csv_export_bool)
        
    disp('Entered the sensor_van_rosbag_novatel.m script')
    
    %% Novatel Topics
    novatel_bestpos_topic                           = '/novatel/oem7/bestpos';
    novatel_corrimu_topic                           = '/novatel/oem7/corrimu';
    novatel_driver_bond_topic                       = '/novatel/oem7/driver/bond';
    novatel_inspva_topic                            = '/novatel/oem7/inspva';
    novatel_inspvax_topic                           = '/novatel/oem7/inspvax';
    novatel_insstdev_topic                          = '/novatel/oem7/insstdev';
    novatel_odom_topic                              = '/novatel/oem7/odom';
    novatel_oem7raw_topic                           = '/novatel/oem7/oem7raw';
    novatel_time_topic                              = '/novatel/oem7/time';
    
    %% INITIATION
    
    % Timing
%     tic

    % Topics
    novatel_bestpos_topic                           = '/novatel/oem7/bestpos';
    novatel_corrimu_topic                           = '/novatel/oem7/corrimu';
    novatel_driver_bond_topic                       = '/novatel/oem7/driver/bond';
    novatel_inspva_topic                            = '/novatel/oem7/inspva';
    novatel_inspvax_topic                           = '/novatel/oem7/inspvax';
    novatel_insstdev_topic                          = '/novatel/oem7/insstdev';
    novatel_odom_topic                              = '/novatel/oem7/odom';
    novatel_oem7raw_topic                           = '/novatel/oem7/oem7raw';
    novatel_time_topic                              = '/novatel/oem7/time';

    % Selecting the bag
    novatel_bestpos_bag                             = select(bag_init, 'Topic', novatel_bestpos_topic);
%     novatel_corrimu_bag                             = select(bag_init, 'Topic', novatel_corrimu_topic);
%     novatel_driver_bond_bag                         = select(bag_init, 'Topic', novatel_driver_bond_topic);
%     novatel_inspva_bag                              = select(bag_init, 'Topic', novatel_inspva_topic);
%     novatel_inspvax_bag                             = select(bag_init, 'Topic', novatel_inspvax_topic);
%     novatel_insstdev_bag                            = select(bag_init, 'Topic', novatel_insstdev_topic);
%     novatel_odom_bag                                = select(bag_init, 'Topic', novatel_odom_topic);
%     novatel_oem7raw_bag                             = select(bag_init, 'Topic', novatel_oem7raw_topic);
%     novatel_time_bag                                = select(bag_init, 'Topic', novatel_time_topic);
    
    disp('novatel init complete')
    
    %% Creating Structure
    novatel_bestpos_struct                          = readMessages(novatel_bestpos_bag,'DataFormat','struct');
%     novatel_corrimu_struct                          = readMessages(novatel_corrimu_bag,'DataFormat','struct');
%     novatel_driver_bond_struct                      = readMessages(novatel_driver_bond_bag,'DataFormat','struct');
%     novatel_inspva_struct                           = readMessages(novatel_inspva_bag,'DataFormat','struct');
%     novatel_inspvax_struct                          = readMessages(novatel_inspvax_bag,'DataFormat','struct');
%     novatel_insstdev_bag                            = readMessages(novatel_insstdev_bag,'DataFormat','struct');
%     novatel_odom_struct                             = readMessages(novatel_odom_bag,'DataFormat','struct');
%     novatel_oem7raw_struct                          = readMessages(novatel_oem7raw_bag,'DataFormat','struct');
%     novatel_time_struct                             = readMessages(novatel_time_bag,'DataFormat','struct');
    
    disp('novatel struct complete')
    
    % Timing
%     toc
    
    novatel_return = 0;
    
    %% Export the stuff to csv
    if novatel_csv_export_bool
        
        novatel_bestpos_csv(novatel_bestpos_struct, bag_file);
%         novatel_corrimu_csv(novatel_corrimu_struct,bag_file);
%         novatel_inspva_csv(novatel_driver_bond_struct,bag_file);
%         novatel_oem7raw_csv(novatel_oem7raw_struct, bag_file);
%         novatel_inspva_csv(novatel_inspva_struct, bag_file);
        % To-Do: Rest of topics.........
        
        disp('novatel csv complete')
        
    end
    
end