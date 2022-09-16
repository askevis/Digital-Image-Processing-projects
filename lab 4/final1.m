function m = main()
clear all; 
close all;

image = imread('axones2.png');
figure('Name','Original Image');
imshow(image);
grey_image = rgb2gray(image);


se1 = strel('disk',8);

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
figure('Name','dilated Image disk');
imshow(dilate);
  
% Eroded image 
erode = imerode(grey_image, se1); 
figure('Name','Eroted Image disk');
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


%exercise 3 calculate thresh
level = graythresh(basic_gradient)
binarized_image = im2bw(basic_gradient,1.7*level);
figure('Name','Binirized Image');
imshow(binarized_image);

%enhance the signal 
dilate2 = imdilate(binarized_image,se1)
figure('Name','Dilated Image');
imshow(dilate2)
se2 = strel('disk',35);
close2 = imclose(dilate2,se2);
figure('Name','Image after using imclose function');
imshow(close2)


skele = bwmorph(close2,'skel',Inf);
shrinked = bwmorph(skele,'shrink');
figure('Name','Skeleton of the signal');
imshow(shrinked)

% Getting the skeletonized image perimeter

perimeter = bwperim(shrinked);

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