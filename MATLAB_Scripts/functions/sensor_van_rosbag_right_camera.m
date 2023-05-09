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

function sensor_van_rosbag_right_camera(bag_init, bag_file, frame_rate)

    disp('Entered the sensor_van_rosbag_right_camera.m script')

    
    %% INITIATION
    
    %Timing
    tic

    % Topics
%     fr_image_raw_topic = '/camera_fr/image_raw'
    fr_image_raw_topic = '/leo_camera_fl/image_raw'

    % Selecting the bag
    right_camera_bag         = select(bag_init, 'Topic', fr_image_raw_topic);

    % Creating Structure - Needed? YES! Maybe? idk...
    right_camera_struct      = readMessages(right_camera_bag,'DataFormat','struct');
%     emptyimg = rosmessage("sensor_msgs/Image",DataFormat="struct")
    
       %% READING IMAGE - RAW
    
    disp('Reading the RAW Images')
    
    video_export_loc        = uigetdir('/media/autobuntu/chonk/data','Select Temporary Image Storage');
    
    im_save                 = 1;
    
    if im_save
        
        image_export_loc        = uigetdir('/media/autobuntu/chonk/data','Select Image Storage');
        
    end
    
    %%
    
    video = VideoWriter(append(video_export_loc + "/" + string(bag_file) + "_right_camera_RAW.avi"));
    video.FrameRate = frame_rate;
    open(video);
    
    tic
    for i = 1:length(right_camera_struct)
    
        imgFormatted = rosReadImage(right_camera_struct{i});
        writeVideo(video,imgFormatted);
        
        if im_save
            
            Filename = fullfile(image_export_loc,string(i) + '.png');
            
            imwrite(imgFormatted, Filename)
            
        end
        
        fprintf('\n%i / %i\n', i, length(right_camera_struct))
               
    end
    toc
    
    close(video);
    
    disp('End of sensor_van_rosbag_right_camera')
    
end