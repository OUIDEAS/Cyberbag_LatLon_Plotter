%==========================================================================
%                               Rhett Huston
%
%                      FILE CREATION DATE: 09/15/2021
%
%                           ROSBAG HANDLER: GPS
%
% This program will extract image data from a rosbag and export it to a 
% video file 
%==========================================================================


function sensor_van_rosbag_left_camera(bag_init, bag_file, frame_rate)

    disp('Entered the sensor_van_rosbag_left_camera.m script')

    %% INITIATION
    
    %Timing
    tic

    % Topics
    fl_image_raw_topic = '/camera_fl/image_raw';
    fl_image_raw_topic = '/leo_camera_fl/image_raw';

    % Selecting the bag
    left_camera_bag         = select(bag_init, 'Topic', fl_image_raw_topic);

    % Creating Structure - Needed? YES! Maybe? idk...
    left_camera_struct      = readMessages(left_camera_bag,'DataFormat','struct');
%     emptyimg = rosmessage("sensor_msgs/Image",DataFormat="struct")
    
    %% READING IMAGE - RAW
    
    video_export_loc        = uigetdir('/media/autobuntu/chonk/data','Select Temporary Image Storage');
        
    disp('Reading the RAW Images')
    
    video = VideoWriter(append(video_export_loc + "/" + string(bag_file) + "_left_camera_RAW.avi"));
    video.FrameRate = frame_rate;
    open(video);
    
    tic
    for i = 1:length(left_camera_struct)
    
        imgFormatted = rosReadImage(left_camera_struct{i});
        writeVideo(video,imgFormatted);
        
        fprintf('\n%i / %i\n', i, length(left_camera_struct))
               
    end
    toc
    
    close(video);
    
    disp('End of sensor_van_rosbag_left_camera')
    
end