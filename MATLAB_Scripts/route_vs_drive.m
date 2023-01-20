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

%% Plot Results

route_fig = figure('DefaultAxesFontSize', 14); 
geoscatter(lat_route, lon_route, 'Marker', '.', 'MarkerEdgeColor', 'k')
hold on
% geoscatter(lat_van, lon_van, 'Marker', 'x', 'MarkerFaceColor','b')
geoplot(lat_van, lon_van, 'b', 'LineWidth', 3)
hold off
geobasemap 'none'
