function [gps_header, gps_data] =  import_data(filename)

    %% Import gps data from text file
    
    % Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 2);

    % Specify range and delimiter
    opts.DataLines = [1, Inf];
    opts.Delimiter = ":";

    % Specify column names and types
    opts.VariableNames = ["Header", "Data"];
    opts.VariableTypes = ["string", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, "Header", "WhitespaceRule", "preserve");
    opts = setvaropts(opts, "Header", "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "Data", "FillValue", 0.0);
    
    % Import the data
    gps_table = readtable(string(filename), opts);
    
    %% Geting the header for the table
    
    gps_array           = table2array(gps_table);
    gps_data            = str2double(gps_array(:,2));
    gps_header          = gps_array(:,1);
    
end