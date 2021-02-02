% script to test annulus background subtraction method 
% proces image 111
channels = [2 3 4];  % these are the channels to process 
%% structuring element parameters
se1 = strel('disk',3);   % disk of radius two for excluding outer fluorescence rim.
se2 = strel('disk',6);   % disk of radius five for background estimation
cd('/data/phnguyen/Imaging/RawData/080917 - processed');
P = 384;  % total number of stage positions;
name_channel = {'CFP' 'YFP' 'RFP'}; % channel names

for p = 1:P    % loop over all the stage positions   
    cd(['pos ' num2str(p)]);
    %% load the requisite files
    load('acq.mat');
    load('segtrackints.mat');   % load
    
    for t = 1:acq.T    % go through all the time points in an image        
        obj = objects(t).obj;   % objects from this given time point
        b1 = zeros(acq.Y, acq.X);   % initially binary image for segmentation
        for i = 1:length(obj)  % loop through all the images in movie
            b = obj(i).b;
            ind = sub2ind(size(b1), b(:,1), b(:,2));
            b1(ind) = i;    % binary labeled image that can be used for regionprops
        end
        
        b2 = imfill(b1,'holes');   % interior cell image       
        load(['imgf_' num2str(t,'%04d') '.mat']); % load images
        
        % now, assume that object ordering for original and annulus image is the same
        
        c = channels(2);  % the channel number
        im = double(images(c).im);  % this is the image for background subtraction
        b2 = bwlabel(b2);
        r = regionprops(b2,im,'Area', 'Perimeter', 'MeanIntensity','BoundingBox','PixelValues');  % object properties of interior
        n =2 ;% the number of standard deviation about the mean for thresholding
        se = strel('disk',2);
        for j = 1:length(obj)  % loop through all objects at time point
            %%%%%%% Code for identifying dead cells
            m_obj = mean(r(j).PixelValues);
            s_obj = std(r(j).PixelValues);
            threshold = m_obj + n*s_obj;
            
            imin = r(j).BoundingBox(2);
            jmin = r(j).BoundingBox(1);
            imax = imin+r(j).BoundingBox(4);
            jmax = jmin+r(j).BoundingBox(3);
            
            subim = im(imin:imax, jmin:jmax);
            subim2 = (subim > threshold);
            
            subim3 = imopen(subim2, se);
            obj(j).data.punctaarea = sum(subim3(:));
            
            %%%%%%% Patch-up Code for removing fake dead cell %%%%%%%%%

            h1 = fspecial('gaussian',[7 7], 3);
            unsharp_alpha = 0.8;
            h2 = fspecial('laplacian', unsharp_alpha);
            %Look for 'granules' within the recognize 'dead' cell. True
            %dead cell should have > 1 granules
            
            i1 = imfilter(subim,h1);   % gaussian blurr image
            i3 = imfilter(i1,h2);      % edge detection
            i4 = imopen(i3.*(-1),se);  % get rid out noise
            i5 = i4 > 5;               % threshold to get rid of more noise
            i6 = imfill(i5,'holes');   % fill holes in image
            g = regionprops(i6);       
            punctanumber = numel(g);% count how many granules there are
            %Eliminate outlying (fake) puncta
            % first get size of the dead cell
            ImageSize = size(i6);
            I = ImageSize(1);
            J = ImageSize(2);
            % define a 'outlying zone'
            k = 5/100;
            dI = I*k;
            dJ = J*k;
            % check to see if each granule centroid falls in outlying zone
            % if so remove that granule
            for i = 1:numel(g)
                loc = g(i).Centroid; %loc(2) is i (row); loc(1) is j (column)
                if     (0<=loc(2) && loc(2)<= dI) && (0<=loc(1) && loc(1)<=J)
                    punctanumber = punctanumber - 1;
                    %disp('Get I')
                elseif (0<=loc(2) && loc(2)<=I) && ((J-dJ)<=loc(1) && loc(1)<=J)
                    punctanumber = punctanumber - 1;
                    %disp('Get II')
                elseif ((I-dI)<=loc(2) &&loc(2)<=I) && (0<=loc(1) && loc(1)<=J)
                    punctanumber = punctanumber - 1;
                    %disp('Get III')
                elseif (0<=loc(2) && loc(2)<=I) && (0<=loc(1) && loc(1)<=dJ)
                    punctanumber = punctanumber - 1;
                    %disp('Get IV')
                end
            end
            obj(j).data.punctanumber = punctanumber;
            %%%%%%%%%%%%%%%%%%% End of patch - up code %%%%%%%%%%%%%%%%%%
        end
        objects(t).obj = obj;
    end
      
   
    save('segtrackintsdead.mat','gatenames','objects');
    clear('objects','gatenames','acq');
    cd '..'
end

        
        
    
    



