close all; imtool close all; clear all;

wtotal = 278; % Total number of well positions
well = 144% Generate random well position from total number of wells 
ch = 2; % Fluorescence channel for analysis, 3 = CFP
htype = 1; % Type of histogram generated: 1 = area of objects, 2 = eccentricity of objects, 3 = wobble of objects, 4 = ratio of objects

for j = 1:1:119 % For images 1,41,81,121, and 161
    cd(['C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\111617 - processed\pos ' num2str(well)]) % Enter folder for well position
    
    if j == 1
        im = load(['imgf_000' num2str(j) '.mat']); % Load image structure at j index
        img = double(im.images(ch).im); % Convert image to double
        cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\Code\111617_EV_cMyc') % Enter folder with cellseg function
        [seg] = cellseg122017(img,j); % Segment image
        [B,imb] = bwboundaries(seg,8,'noholes'); % Label objects
        imtool(imb) % Display segmented image
        props = regionprops(imb,'Area','Perimeter','MajorAxisLength','MinorAxisLength'); % Find area and major and minor axis length of each object
        if htype == 1
            figure(j+1)
            hist([props.Area],100) % Plot histogram of object areas
        elseif htype == 2
            figure(j+2)
            hist([props.MajorAxisLength]./[props.MinorAxisLength],100) % Plot histogram of object eccentricities
        elseif htype == 3
            figure(j+3)
            hist(w,100) % Plot histogram of object wobble
        elseif htype == 4
            figure(j+4)
            hist([props.Perimeter].^(2)./[props.Area],100) % Plot histogram of object perimeter squared/area ratio
        end
        
    elseif j == 41 || j == 81
        im = load(['imgf_00' num2str(j) '.mat']); % Load image structure at j index
        img = double(im.images(ch).im); % Convert image to double
        cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\Code\111617_EV_cMyc') % Enter folder with cellseg function
        [seg] = cellseg122017(img,j); % Segment image
        [B,imb] = bwboundaries(seg,8,'noholes'); % Label objects
        imtool(imb) % Display segmented image
        props = regionprops(imb,'Area','Perimeter','MajorAxisLength','MinorAxisLength'); % Find area and major and minor axis length of each object
        if htype == 1
            figure(j+1)
            hist([props.Area],100) % Plot histogram of object areas
        elseif htype == 2
            figure(j+2)
            hist([props.MajorAxisLength]./[props.MinorAxisLength],100) % Plot histogram of object eccentricities
        elseif htype == 3
            figure(j+3)
            hist(w,100) % Plot histogram of object wobble
        elseif htype == 4
            figure(j+4)
            hist([props.Perimeter].^(2)./[props.Area],100) % Plot histogram of object perimeter squared/area ratio
        end
        
    elseif j == 101 || j == 119
        im = load(['imgf_0' num2str(j) '.mat']); % Load image structure at j index
        img = double(im.images(ch).im);
        cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\Code\111617_EV_cMyc') % Enter folder with cellseg function
        [seg] = cellseg122017(img,j); % Segment image
        [B,imb] = bwboundaries(seg,8,'noholes'); % Label objects
        imtool(imb) % Display segmented image
        props = regionprops(imb,'Area','Perimeter','MajorAxisLength','MinorAxisLength'); % Find area and major and minor axis length of each object
        if htype == 1
            figure(j+1)
            hist([props.Area],100) % Plot histogram of object areas
        elseif htype == 2
            figure(j+2)
            hist([props.MajorAxisLength]./[props.MinorAxisLength],100) % Plot histogram of object eccentricities
        elseif htype == 3
            figure(j+3)
            hist(w,100) % Plot histogram of object wobble
        elseif htype == 4
            figure(j+4)
            hist([props.Perimeter].^(2)./[props.Area],100) % Plot histogram of object perimeter squared/area ratio
        end
    end
end