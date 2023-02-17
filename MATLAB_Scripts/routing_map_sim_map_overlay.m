%% routing_map_txt_read_export

% This exports each node's gps coordinates 

clear all
close all
clc

%% Options

save_data = 0;
save_png = 0;
save_fig = 0;

export_dir = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Route_Export_Results/ohio_athens_blue_v1';

mkdir(export_dir)
addpath(export_dir)


%% Var Init

route_count  = 1;
sim_count   = 1;

x_route           = [];
y_route           = [];
x_sim       = [];
y_sim       = [];
lat_all     = [];
lon_all     = [];

% proj        = projcrs(6346);
% proj        = projcrs(26917);
% proj = projcrs(3747);
proj = projcrs(3724);
% proj = projcrs();

[~,export_name,~] = fileparts(export_dir);

no_no_list = ["bottom:" "left_boundary" "right_boundary" "boundary" "boundary_type" "central_curve" "crosswalk" "crosswalk_overlap_info" "curve" "date:" "direction:" "district:" "edge" "end_s:" "header" "id" "id:" "is_merge:" "junction" "junction_id" "junction_overlap_info" "lane" "lane_id" "lane_overlap_info" "left:" "left_neighbor_forward_lane_id" "left_neighbor_reverse_lane_id" "length:""location" "object" "outer_polygon" "overlap" "overlap_id" "polygon" "predecessor_id" "proj:" "projection" "rev_major:" "rev_minor:" "right:" "right_neighbor_forward_lane_id" "right_neighbor_reverse_lane_id" "road" "s:" "section" "segment" "signal" "signal_overlap_info" "speed_limit:" "start_position" "start_s:" "stop_line" "stop_sign" "stop_sign_overlap_info" "subsignal" "successor_id" "top:" "turn:" "type:" "types:" "vendor:" "version:" "virtual:" "yield" "yield_sign_overlap_info" "z:" "}"];
yes_yes_list = [ "line_segment" ];

%% Opening file and importing into workspace
import_route = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_athens_blue_v1/routing_map.txt';
import_sim = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_athens_blue_v1/sim_map.txt';

routingmap  = import_routing_map_txt(import_route);
simmap      = import_routing_map_txt(import_sim);

route_size  = size(routingmap);
sim_size    = size(simmap);

%% Scanning for Sim Map Data
zero_count = 0; one_count = 0;

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
                
                [lat_sim, lon_sim] = projinv(proj, x_sim, y_sim);
            
                sim_segment_latlon{sim_count} = [lat_sim, lon_sim];
                
                sim_count = sim_count + 1;
            
                x_sim = []; y_sim = []; 
                
                break
                
            end
        
        end
        
    end
    
end

%% Plots all routing segments as red dashed lines

route_line_fig = figure('DefaultAxesFontSize', 14, 'Position', [10 10 500 1000]); 

hold all

for seg_idx = 2:1:length(route_segment_latlon)

    plot(route_segment_latlon{seg_idx}(1:end-1,1), route_segment_latlon{seg_idx}(1:end-1,2), '--r', 'LineWidth', 5)
    
end

%% Plots all sim map segments as blue solid lines

for seg_idx = 1:1:length(sim_segment_latlon)

    plot(sim_segment_latlon{seg_idx}(1:end-1,1), sim_segment_latlon{seg_idx}(1:end-1,2), 'b')
    
end

axis equal

%% Save data

for seg_idx = 2:1:length(route_segment_latlon)

    lat_all = [lat_all; route_segment_latlon{seg_idx}(:,1)];
    lon_all = [lon_all; route_segment_latlon{seg_idx}(:,2)];
    
end

if save_data
    
    lat_lon_data = [lat_all lon_all];

    route_data_filename = '/' + string(export_name) + '_sim_route_overlay_lat_lon.csv';

    full_export_name = string(export_dir) + string(route_data_filename);

    writematrix(lat_lon_data, full_export_name)
    
end

%% Save Figure

if save_png
    
    disp('Re-size figures as needed then unpause')
    
    pause
    
    fig_filename = '/' + string(export_name) + '_sim_route_overlay_png.png';

    full_fig_export_name = string(export_dir) + string(fig_filename);
    
    saveas(route_fig, string(full_fig_export_name), 'png');
    
end

%% Notes

% proj: "+proj=utm +zone=17 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"



%  if contains(simmap(sim_line,1), yes_yes_list)
% 
%         sim_case = 2;
%         
%         sim_count = sim_count + 1;
%         
%         if ~isempty(x_sim) && length(x_sim) == length(y_sim)
%             
%             [lat_sim, lon_sim] = projinv(proj, x_sim, y_sim);
%             
%             sim_segment_latlon{sim_count} = [lat_sim, lon_sim];
%             
%             x_sim = []; y_sim = [];
%             
%         end
%         
%     elseif contains(simmap(sim_line,1), no_no_list)
%         
%         sim_case = 1;
%             
%     end
%     
%     % If the data was not on the no-no list
%     if sim_case == 2
%         
%         if contains(simmap(sim_line,1), "x:") % If line contains x
%         
%             x_sim = [x_sim; str2double(simmap(sim_line,2))];
%         
%         elseif contains(simmap(sim_line,1), "y:") % If line contains y
%         
%             y_sim = [y_sim; str2double(simmap(sim_line,2))];
%             
%         end
%                 
%     end





