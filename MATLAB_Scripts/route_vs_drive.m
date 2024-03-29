%% This script loads up the lat lon of the route plus the van gps

clear all
close all
clc

%% Import Route

[import_route_name, import_route_path] = uigetfile('*.csv','Grab Route Data');

import_file     = string(import_route_path) + string(import_route_name);

route           = readtable(import_file);

lat_route       = table2array(route(:,1));
lon_route       = table2array(route(:,2));

%% Import Van GSP

[import_vangps_name, import_vangps_path]       = uigetfile('*.csv','Grab Route Data');

import_file     = string(import_vangps_path) + string(import_vangps_name);

van_gps         = readtable(import_file);

lat_van         = table2array(van_gps(:,9));
lon_van         = table2array(van_gps(:,10));
alt_van         = table2array(van_gps(:,11));
sat_van         = table2array(van_gps(:,20));

% lat_van         = table2array(van_gps(:,3));
% lon_van         = table2array(van_gps(:,4));
% alt_van         = table2array(van_gps(:,5));
% sat_van         = table2array(van_gps(:,13));

%% Import OTHER Van GPS

% [import_vangps2_name, import_vangps2_path]       = uigetfile('*.csv','Grab Route Data');
% 
% import_file2     = string(import_vangps2_path) + string(import_vangps2_name);
% 
% van2_gps         = readtable(import_file2);
% 
% % lat_van2         = table2array(van2_gps(:,9));
% % lon_van2         = table2array(van2_gps(:,10));
% % alt_van2         = table2array(van2_gps(:,11));
% % sat_van2         = table2array(van2_gps(:,20));
% 
% lat_van2         = table2array(van2_gps(:,3));
% lon_van2         = table2array(van2_gps(:,4));
% alt_van2         = table2array(van2_gps(:,5));
% sat_van2         = table2array(van2_gps(:,13));


%% Plot Results

route_fig = figure('DefaultAxesFontSize', 14); 
geoscatter(lat_route, lon_route, 'Marker', '.', 'MarkerEdgeColor', 'k')
hold on
geoscatter(lat_van, lon_van, 'Marker', 'x', 'MarkerFaceColor','b')
% geoscatter(lat_van2, lon_van2, 'Marker', 'x', 'MarkerFaceColor','r')
% geoplot(lat_van, lon_van, 'b', 'LineWidth', 3)
% hold off
geobasemap 'none'

legend({'Route', 'Pacifica'}, 'FontSize', 14)

%% Plot Results with Satellites

route_fig = figure('DefaultAxesFontSize', 14); 
geoscatter(lat_route, lon_route, 50, 'Marker', '.', 'MarkerEdgeColor', 'k', 'LineWidth', 4)
hold on
geoscatter(lat_van, lon_van, 75, sat_van,'filled', 'MarkerFaceAlpha', 0.75)
hold on
% geoplot(lat_van, lon_van, 'b', 'LineWidth', 3)
geoplot(lat_van, lon_van, 'LineWidth', 3, 'Color', [0 0 1 0.75])
hold off
geobasemap 'none'

legend({'Route', 'Sats', 'Van'}, 'FontSize', 14)


% Initilizing the color
RGB = [0 0 0]; 

% Initilizing the tick marks
tm = [0];

for i = 1:max(sat_van)

    color = [(1 - (i * 1/max(sat_van))) (i * 1/max(sat_van)) abs(sin(pi * i/(max(sat_van))))];

    RGB    = [RGB; color];

    tm  = [tm; i];

end

colormap(RGB)
cbsat = colorbar();
caxis([0,numel(tm)])
cbsat.YTick = 0.5 : 1 : numel(tm);
labelChar = strsplit(sprintf('%i ',tm));
cbsat.TickLabels = labelChar(1:end-1);
cbsat.FontSize = 8; 
cbsat.TickDirection = 'out';
cbsat.Label.String = 'Num Satellites';



%% Plot Results with Satellites but with lines
route_fig_line = figure('DefaultAxesFontSize', 14); 
plot(lat_route, lon_route, 'k', 'LineWidth', 4)
hold on
scatter(lat_van, lon_van, 75, sat_van,'filled', 'MarkerFaceAlpha', 0.75)
hold on
% geoplot(lat_van, lon_van, 'b', 'LineWidth', 3)
plot(lat_van, lon_van, 'LineWidth', 3, 'Color', [0 0 1 0.75])
hold off

legend({'Route', 'Sats', 'Van'}, 'FontSize', 14)


% Initilizing the color
RGB = [0 0 0]; 

% Initilizing the tick marks
tm = [0];

for i = 1:max(sat_van)

    color = [(1 - (i * 1/max(sat_van))) (i * 1/max(sat_van)) abs(sin(pi * i/(max(sat_van))))];

    RGB    = [RGB; color];

    tm  = [tm; i];

end

colormap(RGB)
cbsat = colorbar();
caxis([0,numel(tm)])
cbsat.YTick = 0.5 : 1 : numel(tm);
labelChar = strsplit(sprintf('%i ',tm));
cbsat.TickLabels = labelChar(1:end-1);
cbsat.FontSize = 8; 
cbsat.TickDirection = 'out';
cbsat.Label.String = 'Num Satellites';
