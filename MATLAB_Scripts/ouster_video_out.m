function ouster_video_out(outputFile, input_struct)
    
    fprintf('\nExporting %s.......\n', outputFile)
    frameRate = 20;
    videoObj = VideoWriter(outputFile, 'Uncompressed AVI');
    videoObj.FrameRate = frameRate;
    
    open(videoObj);
    
%     numFrames = size(ouster_nearir_image_struct);
    
%     numChunks = floor(numel(ouster_nearir_image_struct{1,1}.Data) / x_pixel_dim);
    
    numMessages = length(input_struct);
    
    height = 128;
    width = 2048;
    
    frames = zeros(height, width, numMessages, 'uint8');
    
    for frame_idx = 1:numMessages
        data = input_struct{frame_idx}.Data;
        frame = reshape(data, width, height)';
        frames(:, :, frame_idx) = frame;
    end
    
    for frame_idx = 1:numMessages
        frame = frames(:, :, frame_idx);
        writeVideo(videoObj, frame);
    end
    
    close(videoObj);
    
end