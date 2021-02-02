clear
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\080917 - processedNew\pos 240')
load('imgf_0010.mat')
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging')

outdir = 'C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\';
%Place holder CheatSheet: Run this first. Set Ready to false!!
LiveDeadCheatSheet = zeros(1,1000);


%%%Generate Cheat Sheet
Ready = false;

if Ready == true
    
    TotalCell = 49;
    DeadCellPosition  = [3 6 7 12 20 28];
    
    LiveDeadCheatSheet = ones(1,TotalCell);
    for l= 1:numel(DeadCellPosition)
        LiveDeadCheatSheet(DeadCellPosition(l)) = 0;
    end
    
    display(LiveDeadCheatSheet)
end





%Enter data set name: 080917 (10) 082117(100) 111617(1000)
DataSetCode = 1000;
%Enter scanner person name: Sam (0) Blythe (100)
PersonNameCode = 0;

%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%
c = 2;  % the channel number
im = double(images(c).im);  % this is the image for background subtraction
im1 = double(images(1).im);
im = double(im);
seg = cellseg060117(im);
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

for j = 6 %1:length(r)  % loop through all objects at time point
            
            Cell(j).LiveDead = LiveDeadCheatSheet(j);
            Cell(j).DataSetCode = DataSetCode;
            Cell(j).PersonCode = PersonNameCode;
            
            Cell(j).GeneralArea = r(j).Area;
            Cell(j).GeneralPerimeter = r(j).Perimeter;
            Cell(j).GeneralMeanIntensity = r(j).MeanIntensity;
            %%%%%%% Code for identifying dead cells
            m_obj = mean(r(j).PixelValues);
            s_obj = std(r(j).PixelValues);
            threshold = m_obj + n*s_obj;
            
            imin = r(j).BoundingBox(2);
            jmin = r(j).BoundingBox(1);
            imax = imin+r(j).BoundingBox(4);
            jmax = jmin+r(j).BoundingBox(3);
            
            subim = im(imin:imax, jmin:jmax);
            %imtool(subim);
            subim2 = (subim > threshold);
            subim3 = imopen(subim2, se);
            punctaarea(j) = sum(subim3(:));
            C = regionprops(subim3,'Area','Centroid','BoundingBox','Perimeter');
            %Record Cutoff Filter data
            Cell(j).Cutoffpunctaarea = punctaarea(j);
            Cell(j).CutoffPunctaNumber = numel(C);
            
            %Look for 'granules' within the recognize 'dead' cell. True
            %dead cell should have > 1 granules
            
            i1 = imfilter(subim,h1);   % gaussian blurr image
            i3 = imfilter(i1,h2);      % edge detection
            i4 = imopen(i3.*(-1),se);  % get rid out noise
            i5 = i4 > 5;               % threshold to get rid of more noise
            %i5 = i4 > 0;               % threshold to get rid of more noise
            i6 = imfill(i5,'holes');   % fill holes in image
            
            %imtool(i6)
            
            
            p = regionprops(i6,'Area','Centroid','BoundingBox','Perimeter');       
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
            area = [];
            perimeter = [];
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
                else
                    area = [area p(i).Area];
                    perimeter = [perimeter p(i).Perimeter];
                 end
            
            end
            %report Lapacian data
            Cell(j).LapacianPunctaNumber = punctanumber(j);
            ma = mean(area);
            Cell(j).LapacianMeanPunctaArea = ma(1);
            mp = mean(perimeter);
            Cell(j).LapacianMeanPunctaPerimeter = mp(1);
                    
               
            %%%%%%%%%%%%%%%highlight the cell of interest
            figure(j)
            imshow(im1,[0,2500]);
            pause(0.75)
            hold on;
            rectangle('Position',[r(j).BoundingBox(1),r(j).BoundingBox(2),r(j).BoundingBox(3),r(j).BoundingBox(4)],'EdgeColor','r');
            hold off;
                  
end

if numel(LiveDeadCheatSheet) ~= numel(r)
    display('CheatSheet ERROR!');
    display('Cell total:');
    display(numel(r));
    display('CheatSheet elements: ')
    display(numel(LiveDeadCheatSheet));
else
    save([outdir '080917Pos71T10.mat'],'Cell') % save as ({expdate}Pos{well position}T{timepoint})
end
    
        