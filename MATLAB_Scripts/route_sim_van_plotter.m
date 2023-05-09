%% routing_map_txt_read_export


%% Setting up workspace

clear all
close all
clc
format compact

%% Options

% lat lon or projection to x-y
xy_proj = 0;

% Route & sim : Load .txt % ohio_athens_blue_v1 % ohio_ridges_v2
import_route    = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_ridges_v2/routing_map.txt';
import_sim      = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_ridges_v2/sim_map.txt';

% Van gps data: Load .csv file
% import_gps      = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/blue_route_02_23_15.bag_bestpos_AAAAAAAAAAAAAAAAAAAAAAAAA.csv';

% blue route
% import_gps = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/blue_route_03_06_2023/blue_route_03_06_2023_p1_bestpos.csv';
% import_gps = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/blue_route_03_06_2023/blue_route_csv.csv';

% ridges_outer
import_gps_1 = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/ridges_03_06_2023/outer_loop/2023-03-06-13-18-53_bestpos.csv';
% import_gps_2 = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/ridges_03_06_2023/outer_loop/2023-03-06-13-21-57_bestpos.csv';
% import_gps_3 = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/ridges_03_06_2023/outer_loop/2023-03-06-13-24-50_bestpos.csv';

% ridges_inner
% import_gps_1 = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/ridges_03_06_2023/inner_loop/2023-03-06-13-28-17_bestpos.csv';
% import_gps_2 = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/ridges_03_06_2023/inner_loop/2023-03-06-13-31-06_bestpos.csv';
% import_gps_3 = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/ridges_03_06_2023/inner_loop/2023-03-06-13-33-48_bestpos.csv';

% Export dir
export_dir = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/03_06_2023_ROSBAGS/03_06_2023_figs/Ridges_All_Drives';

% Export Name
export_name = 'Ridges_All_OUTER';

% Save stuffs? 1 = yes, 0 = no
save_data       = 0;
save_figs       = 1;

% Reading from csv generated from a rosbag or cyberbag?
cyberbag_bool   = 0;
rosbag_bool     = 1;

%% Var Init

% Initilizing counts for scanning the routing & sim .txt files line by line
zero_count = 0; 
one_count = 0;
route_count  = 1;
sim_count   = 1;
lane_count  = 1;

% Array inits...
x_route           = [];
y_route           = [];
x_sim       = [];
y_sim       = [];
lat_all     = [];
lon_all     = [];

% Projections for the x,y to lat,lon
% proj        = projcrs(6346);
% proj        = projcrs(26917);
% proj = projcrs(3747);
proj = projcrs(3724);
% proj = projcrs();

% Export location
% [~,export_name,~] = fileparts(export_dir);
mkdir(export_dir)
addpath(export_dir)

% Sim map list to export. Probably don't change this, mmhmm?
no_no_list = ["bottom:" "left_boundary" "right_boundary" "boundary" "boundary_type" "central_curve" "crosswalk" "crosswalk_overlap_info" "curve" "date:" "direction:" "district:" "edge" "end_s:" "header" "id" "id:" "is_merge:" "junction" "junction_id" "junction_overlap_info" "lane" "lane_id" "lane_overlap_info" "left:" "left_neighbor_forward_lane_id" "left_neighbor_reverse_lane_id" "length:""location" "object" "outer_polygon" "overlap" "overlap_id" "polygon" "predecessor_id" "proj:" "projection" "rev_major:" "rev_minor:" "right:" "right_neighbor_forward_lane_id" "right_neighbor_reverse_lane_id" "road" "s:" "section" "segment" "signal" "signal_overlap_info" "speed_limit:" "start_position" "start_s:" "stop_line" "stop_sign" "stop_sign_overlap_info" "subsignal" "successor_id" "top:" "turn:" "type:" "types:" "vendor:" "version:" "virtual:" "yield" "yield_sign_overlap_info" "z:" "}"];
yes_yes_list = [ "line_segment" ];

%% Opening sim/route files and importing into workspace

routingmap  = import_routing_map_txt(import_route);
simmap      = import_routing_map_txt(import_sim);
route_size  = size(routingmap);
sim_size    = size(simmap);

van_gps_1         = readtable(import_gps_1);
% van_gps_2         = readtable(import_gps_2);
% van_gps_3         = readtable(import_gps_3);


%% Opening van files and importing into workspace

if cyberbag_bool % Using cyberbags
    
    lat_van_1         = table2array(van_gps_1(:,9));
    lon_van_1         = table2array(van_gps_1(:,10));
    alt_van_1         = table2array(van_gps_1(:,11));
    sat_van_1         = table2array(van_gps_1(:,20));

elseif rosbag_bool % Using rosbags
    
    lat_van_1         = table2array(van_gps_1(:,3));
    lon_van_1         = table2array(van_gps_1(:,4));
    alt_van_1         = table2array(van_gps_1(:,5));
    sat_van_1         = table2array(van_gps_1(:,12));
%     
%     lat_van_2         = table2array(van_gps_2(:,3));
%     lon_van_2         = table2array(van_gps_2(:,4));
%     alt_van_2         = table2array(van_gps_2(:,5));
%     sat_van_2         = table2array(van_gps_2(:,12));
%     
%     lat_van_3         = table2array(van_gps_3(:,3));
%     lon_van_3         = table2array(van_gps_3(:,4));
%     alt_van_3         = table2array(van_gps_3(:,5));
%     sat_van_3         = table2array(van_gps_3(:,12));
%     
end

if xy_proj
    
    [x_van, y_van] = projfwd(proj, lat_van_1, lon_van_1);
    
end



%% Scanning for Sim Map Data

% LONGITUDE = UP/DOWN == Y; LATITUDE = LEFT/RIGHT = X

for sim_line = 1:1:sim_size(1)
    
    if contains(simmap(sim_line,1), no_no_list)
        
        zero_count = zero_count + 1;
        
    end
        
    if contains(simmap(sim_line,1), yes_yes_list)
        
        while true
            
            sim_line = sim_line + 1;
            
            if contains(simmap(sim_line,1), 'x:') == 1

                x_sim = [x_sim; str2double(simmap(sim_line,2))];
                
            elseif contains(simmap(sim_line,1), 'y:') == 1
                
                y_sim = [y_sim; str2double(simmap(sim_line,2))];

            end
            
            if simmap(sim_line - 1, 1) == simmap(sim_line, 1)
                
                if ~xy_proj
                   
                    [lat_sim, lon_sim] = projinv(proj, x_sim, y_sim);
                    sim_segment_latlon{sim_count} = [lat_sim, lon_sim];
                    
                else
                    
                    sim_segment_xy{sim_count} = [x_sim, y_sim];
                    
                end % if we are using latlon or xy proj
                
                sim_count = sim_count + 1;
            
                x_sim = []; y_sim = []; 
                
                break
                
            end % the next line == the previous line
        
        end % until the next line == the previous line
        
    end % if the line contains something that we want to keep
    
end % for each line in the sim file

%% Scanning for data

for line = 1:1:route_size(1)

    % If line contains x
    if contains(routingmap(line,1), 'x:')
        
        x_route = [x_route; str2double(routingmap(line,2))];
        
    elseif contains(routingmap(line,1), 'y:') % If line contains y
        
        y_route = [y_route; str2double(routingmap(line,2))];
        
    elseif contains(routingmap(line,1), 'start_position')
        
        line = line + 3;
    
    elseif contains(routingmap(line,1), 'node') % If line contains node
        
        if ~xy_proj
        
            [lat, lon] = projinv(proj, x_route, y_route);
            
            segment_latlon{lane_count} = [lat,lon];
            
        else
            
            segment_xy{lane_count} = [x_route y_route];
            
        end

        lane_count = lane_count + 1;
        
        x_route = [];
        y_route = [];
        
    end
    
end

%% Plotting JUST the sim/route

simroute_fig = figure('DefaultAxesFontSize', 14)
hold all

if xy_proj % XY PROJECTION
    
    % Plots all segments as lines
    for seg_idx = 1:1:length(segment_xy)

        if ~isempty(segment_xy{seg_idx})

            plot(segment_xy{seg_idx}(1:end-1,1), segment_xy{seg_idx}(1:end-1,2), 'r--', 'LineWidth', 2.5)   

        end

    end

    hold all

    % Plots all sim map segments as blue solid lines
    for seg_idx = 1:1:length(sim_segment_xy)

        plot(sim_segment_xy{seg_idx}(1:end-1,1), sim_segment_xy{seg_idx}(1:end-1,2), 'b', 'LineWidth', 1)

    end
    
    xlabel('Meters')
    ylabel('Meters')
    
else % LAT LON

    % Plots all segments as lines
    for seg_idx = 1:1:length(segment_latlon)

        if ~isempty(segment_latlon{seg_idx})

            plot(segment_latlon{seg_idx}(1:end-1,2), segment_latlon{seg_idx}(1:end-1,1), 'r--', 'LineWidth', 2.5)   

        end

    end

    hold all

    % Plots all sim map segments as blue solid lines
    for seg_idx = 1:1:length(sim_segment_latlon)

        plot(sim_segment_latlon{seg_idx}(1:end-1,2), sim_segment_latlon{seg_idx}(1:end-1,1), 'b', 'LineWidth', 1)

    end
    
    xlabel('Lon')
    ylabel('Lat')

end
% formatting
% Setting up legend
h = zeros(2, 1);
h(1) = plot(NaN,NaN,'r--', 'LineWidth', 3); hold on;
h(2) = plot(NaN,NaN,'b', 'LineWidth', 3); hold on;
legend(h, {'Routing Map', 'Sim Map'});
axis equal

%% Plotting sim/route/van gps

simroutevan_fig = figure('DefaultAxesFontSize', 14)
hold all

if xy_proj
    
     % Plots all segments as lines
    for seg_idx = 1:1:length(segment_xy)

        if ~isempty(segment_xy{seg_idx})

            plot(segment_xy{seg_idx}(1:end-1,1), segment_xy{seg_idx}(1:end-1,2), 'r--', 'LineWidth', 2.5)   

        end

    end

    hold all

    % Plots all sim map segments as blue solid lines
    for seg_idx = 1:1:length(sim_segment_xy)

        plot(sim_segment_xy{seg_idx}(1:end-1,1), sim_segment_xy{seg_idx}(1:end-1,2), 'b', 'LineWidth', 1)

    end
    
    hold all

    plot(x_van, y_van, 'k', 'LineWidth', 3)

    hold all
    
    xlabel('Meters')
    ylabel('Meters')
    
else
    
    % Plots all segments as red dashed lines
    for seg_idx = 1:1:length(segment_latlon)

        if ~isempty(segment_latlon{seg_idx})

            plot(segment_latlon{seg_idx}(1:end-1,2), segment_latlon{seg_idx}(1:end-1,1), 'r--', 'LineWidth', 2.5)   

        end

    end

    hold all

    % Plots all sim map segments as blue solid lines
    for seg_idx = 1:1:length(sim_segment_latlon)

        plot(sim_segment_latlon{seg_idx}(1:end-1,2), sim_segment_latlon{seg_idx}(1:end-1,1), 'b', 'LineWidth', 1)

    end

     hold all

    plot(lon_van_1, lat_van_1, 'k', 'LineWidth', 3)
    plot(lon_van_2, lat_van_2, 'm', 'LineWidth', 3)
    plot(lon_van_3, lat_van_3, 'Color', [0.4940 0.1840 0.5560] , 'LineWidth', 3)


    hold all
    
    xlabel('Lon')
    ylabel('Lat')

end

% formatting
% Setting up legend
h = zeros(5, 1);
h(1) = plot(NaN,NaN,'r--', 'LineWidth', 3); hold on;
h(2) = plot(NaN,NaN,'b', 'LineWidth', 3); hold on;
h(3) = plot(NaN,NaN,'k', 'LineWidth', 3); hold on;
h(4) = plot(NaN,NaN,'m', 'LineWidth', 3); hold on;
h(5) = plot(NaN,NaN,'Color', [0.4940 0.1840 0.5560], 'LineWidth', 3); hold on;
legend(h, {'Routing Map', 'Sim Map', 'Van Drive 1', 'Van Drive 2', 'Van Drive 3'});
axis equal

hold off

%% Plotting route/van gps

routevan_fig = figure('DefaultAxesFontSize', 14)
hold all

if xy_proj
    
    % Plots all segments as lines
    for seg_idx = 1:1:length(segment_xy)

        if ~isempty(segment_xy{seg_idx})

            plot(segment_xy{seg_idx}(1:end-1,1), segment_xy{seg_idx}(1:end-1,2), 'r--', 'LineWidth', 2.5)   

        end

    end
    
    plot(x_van, y_van, 'k', 'LineWidth', 3)

    hold all
    
    xlabel('Meters')
    ylabel('Meters')
    
else

    % Plots all segments as red dashed lines
    for seg_idx = 1:1:length(segment_latlon)

        if ~isempty(segment_latlon{seg_idx})

            plot(segment_latlon{seg_idx}(1:end-1,2), segment_latlon{seg_idx}(1:end-1,1), 'r--', 'LineWidth', 2.5)   

        end

    end

     hold all

    plot(lon_van_1, lat_van_1, 'k', 'LineWidth', 3)
    
    hold on
    plot(lon_van_2, lat_van_2, 'm', 'LineWidth', 3)
    
    hold on
    plot(lon_van_3, lat_van_3, 'Color', [0.4940 0.1840 0.5560] , 'LineWidth', 3)
    
    hold all
    
    xlabel('Lon')
    ylabel('Lat')
    
end

% formatting
% Setting up legend
h = zeros(4, 1);
h(1) = plot(NaN,NaN,'r--', 'LineWidth', 3); hold on;
h(2) = plot(NaN,NaN,'k', 'LineWidth', 3); hold on;
h(3) = plot(NaN,NaN,'m', 'LineWidth', 3); hold on;
h(4) = plot(NaN,NaN,'Color', [0.4940 0.1840 0.5560], 'LineWidth', 3); hold on;
legend(h, {'Routing Map', 'Van Drive 1', 'Van Drive 2', 'Van Drive 3'});
axis equal

hold off

%% Save pngs

if save_figs
    
    disp('Re-size figures as needed then unpause')
    
    pause
    
    routevan_fig_fn = '/' + string(export_name) + '_routevan_fig.fig';
    simroutevan_fig_fn = '/' + string(export_name) + '_simroutevan_fig.fig';
    simroute_fig_fn = '/' + string(export_name) + '_simroute_fig.fig';

    routevan_fig_fn_name = string(export_dir) + string(routevan_fig_fn);
    simroutevan_fig_fn_name = string(export_dir) + string(simroutevan_fig_fn);
    simroute_fig_fn_name = string(export_dir) + string(simroute_fig_fn);

    saveas(routevan_fig, string(routevan_fig_fn_name), 'fig');
    saveas(simroutevan_fig, string(simroutevan_fig_fn_name), 'fig');
    saveas(simroute_fig, string(simroute_fig_fn_name), 'fig');
    
    routevan_png_fn = '/' + string(export_name) + '_routevan_fig.png';
    simroutevan_png_fn = '/' + string(export_name) + '_simroutevan_fig.png';
    simroute_png_fn = '/' + string(export_name) + '_simroute_fig.png';

    routevan_png_fn_name = string(export_dir) + string(routevan_png_fn);
    simroutevan_png_fn_name = string(export_dir) + string(simroutevan_png_fn);
    simroute_png_fn_name = string(export_dir) + string(simroute_png_fn);

    saveas(routevan_fig, string(routevan_png_fn_name), 'png');
    saveas(simroutevan_fig, string(simroutevan_png_fn_name), 'png');
    saveas(simroute_fig, string(simroute_png_fn_name), 'png');

    
end

%% Notes

% proj: "+proj=utm +zone=17 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"




