cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\080917 - processedNew\pos 240')
load('imgf_0075.mat')
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging')
c = 2;  % the channel number
im = double(images(c).im);  % this is the image for background subtraction
im1 = double(images(1).im);  
im = double(im);
seg = cellseg122017(im,2);
r = regionprops(seg,im,'Area', 'Perimeter', 'MeanIntensity','BoundingBox','PixelValues');  % object properties of interior
n =2 ;% the number of standard deviation about the mean for thresholding
se = strel('disk',2);
punctaarea = [];

h1 = fspecial('gaussian',[7 7], 3);
unsharp_alpha = 0.8;
h2 = fspecial('laplacian', unsharp_alpha);
low_in = 100/600; % lowest intensity input value for cell regonition 
low_out = 0; % adjusted low intensity output
high_in = 300/600; % higest intensity input value to guarantee cell
high_out = 1; % adjusted high intensity output
punctanumber = [];
for j = 1:length(r)  % loop through all objects at time point
            
            %%%%%%% Code for identifying dead cells
            m_obj = mean(r(j).PixelValues);
            s_obj = std(r(j).PixelValues);
            threshold = m_obj + n*s_obj;
            
            imin = r(j).BoundingBox(2);
            jmin = r(j).BoundingBox(1);
            imax = imin+r(j).BoundingBox(4);
            jmax = jmin+r(j).BoundingBox(3);
            
            subim = im(imin:imax, jmin:jmax);
            imtool(subim);
            subim2 = (subim > threshold);
            subim3 = imopen(subim2, se);
            punctaarea(j) = sum(subim3(:));
            
            %Look for 'granules' within the recognize 'dead' cell. True
            %dead cell should have > 1 granules
            
            i1 = imfilter(subim,h1);   % gaussian blurr image
            i3 = imfilter(i1,h2);      % edge detection
            i4 = imopen(i3.*(-1),se);  % get rid out noise
            %i5 = i4>(mean(i4(:)+0.5*std(i4(:))));
            i5 = i4 > 5;               % threshold to get rid of more noise
            i6 = imfill(i5,'holes');   % fill holes in image
            
            %imtool(i6)
            
            
            p = regionprops(i6);       
            punctanumber(j) = numel(p);% count how many granules there are
            
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
            for i = 1:numel(p)
                loc = p(i).Centroid; %loc(2) is i (row); loc(1) is j (column)
                if     (0<=loc(2) && loc(2)<= dI) && (0<=loc(1) && loc(1)<=J)
                    punctanumber(j) = punctanumber(j) - 1;
                    disp('Get I')
                elseif (0<=loc(2) && loc(2)<=I) && ((J-dJ)<=loc(1) && loc(1)<=J)
                    punctanumber(j) = punctanumber(j) - 1;
                    disp('Get II')
                elseif ((I-dI)<=loc(2) &&loc(2)<=I) && (0<=loc(1) && loc(1)<=J)
                    punctanumber(j) = punctanumber(j) - 1;
                    disp('Get III')
                elseif (0<=loc(2) && loc(2)<=I) && (0<=loc(1) && loc(1)<=dJ)
                    punctanumber(j) = punctanumber(j) - 1;
                    disp('Get IV')
                end
            end
            
                    
                    
            
end
        