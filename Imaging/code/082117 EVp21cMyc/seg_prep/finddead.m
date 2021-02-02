clear all;
load('imgf_0079.mat');
im = images(2).im;
im = double(im);
seg = cellseg060117Correct(im);
seglabel = bwlabel(seg);
segdata = regionprops(seglabel, im, 'Area', 'Perimeter', 'MeanIntensity','BoundingBox','PixelValues')

L = length(segdata);
n = 2;  % the number of standard deviations about the mean for thresholding

se = strel('disk',2);
data = [];

for i = 1:L  % loop through all the objects;
    
    m_obj = mean(segdata(i).PixelValues);
    s_obj = std(segdata(i).PixelValues);
    threshold = m_obj + n*s_obj;
    
    imin = segdata(i).BoundingBox(2);
    jmin = segdata(i).BoundingBox(1);
    imax = imin+segdata(i).BoundingBox(4);
    jmax = jmin+segdata(i).BoundingBox(3);
    
    subim = im(imin:imax, jmin:jmax);
    subim2 = (subim > threshold);
    
    subim3 = imopen(subim2, se);
    
    data(i).punctaarea = sum(subim3(:));
    
    %figure(i); subplot(2,1,1); imshow(subim2,[]);
    %subplot(2,1,2); imshow(subim3,[]);
end
    
    
   