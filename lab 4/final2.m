function m = main()
clear all; 
close all;

image = imread('axones1.png');
figure('Name','Original Image');
imshow(image);
grey_image = rgb2gray(image);


se1 = strel('disk',2);

% Opened image 
open = imopen(grey_image, se1); 
figure('Name','Open Image disk');
imshow(open);

% Closed image 
closed = imclose(grey_image, se1); 
figure('Name','Close Image disk');
imshow(closed); 

%Dilated IMAGE
dilate = imdilate(grey_image,se1);
figure('Name','Dilated Image disk');
imshow(dilate);
  
% Eroded image 
erode = imerode(grey_image, se1); 
figure('Name','Eroded Image disk');
imshow(erode);


%top phat image
tophatFiltered = imtophat(grey_image,se1);
figure('Name','tophat Image disk');
imshow(tophatFiltered);

%%exercise 2%%%%%%%%
basic_gradient = dilate - erode;
figure('Name','Basic gradient');
imshow(basic_gradient);

internal_gradient = grey_image - erode;
figure('Name','Internal gradient');
imshow(internal_gradient);

external_gradient = dilate - grey_image;
figure('Name','External gradient');
imshow(external_gradient);

% We chose top hat filtered image

% Calculating gray thresh
level = graythresh(basic_gradient)
% Binarize image with gray thresh computed above + a factor we thought it does the job
binarized = im2bw(basic_gradient,2.5*level);
figure('Name','Binirized Image');
imshow(binarized);

dilate2 = imdilate(binarized,se1);
figure('Name','imdilate the Binirized Image');
imshow(dilate2);

skele = bwmorph(dilate2,'skel',Inf);
figure('Name','Skeletonized Image');
imshow(skele);

thickened = bwmorph(skele,'thicken');
figure('Name','Thickened Image');
imshow(thickened);

filled = imfill(thickened, 'holes');
figure('Name','Filled Image');
imshow(filled);

final = imdilate(filled,se1);
figure('Name','Dilated Image');
imshow(final);

bridged = bwmorph(final,'bridge');
figure('Name','Bridged Image');
imshow(bridged);

skele2 = bwmorph(bridged,'skel',Inf);
figure('Name','Skeletonized Image');
imshow(skele2);

cleaned = bwmorph(skele2,'clean');
figure('Name','Cleaned Image');
imshow(cleaned);

final2 = imdilate(cleaned,se1);
figure('Name','Dilated Image');
imshow(final2);

skele3 = bwmorph(final2,'skel',Inf);
figure('Name','Skeletonized Image');
imshow(skele3);

bridged2 = bwmorph(skele3,'bridge');
figure('Name','Bridged Image');
imshow(bridged2);

filled2 = imfill(bridged2, 'holes');
figure('Name','Filled Image');
imshow(filled2);

final3 = imdilate(filled2,se1);
figure('Name','Dilated Image');
imshow(final3);

skele4 = bwmorph(final3,'skel',Inf);
figure('Name','Skeletonized Image');
imshow(skele4);

shrinked = bwmorph(skele4,'shrink');
figure('Name','Shrinked Image');
imshow(shrinked);

final4 = imdilate(shrinked,se1);
figure('Name','Dilated Image');
imshow(final4);

bridged2 = bwmorph(final4,'bridge');
figure('Name','Bridged Image');
imshow(bridged2);

skele5 = bwmorph(bridged2,'skel',Inf);
figure('Name','Skeletonized Image');
imshow(skele5);

% Getting the skeletonized image perimeter

perimeter = bwperim(skele5);

% Setting perimeter color to red
finalR = grey_image;
finalG = grey_image;
finalB = grey_image;

finalR(perimeter) = 255;
finalG(perimeter) = 0;
finalB(perimeter) = 0;

% Concating the rgb layers together in order to show the red perimeter on top of the original image

RGB= cat(3,finalR,finalG,finalB);
figure('Name','rgb Image');
imshow(RGB);




end