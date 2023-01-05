%% area_marker.m

% This program loads a .fig file, and allows you to mark areas on the map.

%% Workspace Init

clear all
close all
clc

%% Var Init

red_ind = 1;
yel_ind = 1;
gre_ind = 1;
mag_ind = 1;

time_now = convertTo(datetime, 'epochtime');

%% Import .fig

% Grab fig file
[import_fig import_fig_path] = uigetfile();
% import_fig = '/media/autobuntu/chonk/chonk/DATA/cyber_bags_gps_export/record_files_all_test/record_files_all_test_route_figure.fig';

% Open and display fig file
map_figure = openfig(import_fig)

%% Create areas


while true
    
    %% Initilization
    % Select desired type
    disp('Select desired color')
    dlg_list                            = {'Red', 'Yellow', 'Green', 'Magenta'};
    [indx_dlg_list,~]                   = listdlg('ListString', dlg_list,'SelectionMode','single');

    % Selecting the zoom tool by default
    disp('Zoom to where you want, Sahib')
    zoom(map_figure)

    % Pausing until ready for ROI selection
    disp('Pausing until you are ready, Sahib')
    pause
    
    %% Selecting ROI and grabbing points
    
    % Grab User Defined Area
    disp('Selecting ROI')
    roi = drawpolygon;

    % ROI points, this is the X,Y of each point made in making the Polygon
    x_roi = roi.Position(:,1);
    y_roi = roi.Position(:,2);
    xy_roi = [x_roi y_roi];
    
    %% Save or discard
    save_ans = questdlg('Save the data?','Save the data?','Yes','No','Yes');

    hold on
    
    switch save_ans
        
        case 'Yes'

            switch indx_dlg_list

                case 1

                    disp('Red')

                    % Save the x y of the polygon points
                    red_roi{red_ind} = xy_roi;

                    % increase the index counter
                    red_ind = red_ind + 1;

                    % Plot the shape unto the point cloud for easy
                    % identification
                    roi_data = [xy_roi(:,1),xy_roi(:,2); xy_roi(1:2,1),xy_roi(1:2,2)];
                    geoplot(roi_data(:,1), roi_data(:,2), 'r', 'LineWidth', 10)

                case 2

                    disp('Yellow')

                    % Save the x y of the polygon points
                    yel_roi{yel_ind} = xy_roi;

                    % increase the index counter
                    yel_ind = yel_ind + 1;

                    % Plot the shape unto the point cloud for easy
                    % identification
                    roi_data = [xy_roi(:,1),xy_roi(:,2); xy_roi(1:2,1),xy_roi(1:2,2)];
                    geoplot(roi_data(:,1), roi_data(:,2), 'y', 'LineWidth', 10)

                case 3

                    disp('Green')

                    % Save the x y of the polygon points
                    gre_roi{gre_ind} = xy_roi;

                    % increase the index counter
                    gre_ind = gre_ind + 1;

                    % Plot the shape unto the point cloud for easy
                    % identification
                    roi_data = [xy_roi(:,1),xy_roi(:,2); xy_roi(1:2,1),xy_roi(1:2,2)];
                    geoplot(roi_data(:,1), roi_data(:,2), 'g', 'LineWidth', 10)

                case 4

                    disp('Magenta')

                    % Save the x y of the polygon points
                    mag_roi{mag_ind} = xy_roi;

                    % increase the index counter
                    mag_ind = mag_ind + 1;

                    % Plot the shape unto the point cloud for easy
                    % identification
                    roi_data = [xy_roi(:,1),xy_roi(:,2); xy_roi(1:2,1),xy_roi(1:2,2)];
                    geoplot(roi_data(:,1), roi_data(:,2), 'm', 'LineWidth', 10)

            end % Plot Roi case

        % Clear the workspace for safety
        clear xq yq xv yv in indx_in pgon roi_data
        delete(roi)

        case 'No'

            % Clear the workspace for safety
            delete(roi)
            clear xq yq xv yv in indx_in pgon roi_data
            
    end % Save Answer case
    
    cont_ans = questdlg('Continue?','Continue?','Yes','No','Yes');
    
    switch cont_ans
        
        case 'Yes'
            
        case 'No'
            
            break
            
    end


end

%% Saving the image to disk

save_img_ans = questdlg('Save Image?', 'Save Image?', 'Yes', 'No', 'Yes');

switch save_img_ans
    
    case 'Yes'
        
        warning('WILL SAVE CURRENT VIEW! RESET VIEW TO DESIRED ZOOM LEVEL AND WINDOW SIZE! PAUSING UNTIL READY!')
        
        pause
        
        saveas(map_figure, string(import_fig_path) + "/" + string(time_now) + "map_with_things.png", 'png');
        
    case 'No'
        
        warning('Not saving image to disk')
        
end


%% Saving the regions to disk

save_roi_ans = questdlg('Save ROIs?', 'Save ROIs??', 'Yes', 'No', 'Yes');

switch save_roi_ans

    case 'Yes'
        
        if red_ind ~= 1
            Manual_Classfied_Areas.red = red_roi;
        end

        if yel_ind ~= 1
            Manual_Classfied_Areas.yel = yel_roi;
        end

        if gre_ind ~= 1
            Manual_Classfied_Areas.gre = gre_roi;
        end

        if mag_ind ~= 1
            Manual_Classfied_Areas.mag = mag_roi;
        end
        
        disp('Saving File')
        Filename = string(import_fig_path) + "/polygon_regions.mat";
        save(Filename, 'Manual_Classfied_Areas')
        
    case 'No'

        warning('Not saving rois to disk')

end

disp('End Program!')


